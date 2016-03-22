;;; nxml-maint.el --- commands for maintainers of nxml-*.el

;; Copyright (C) 2003 Thai Open Source Software Center Ltd

;; Author: James Clark <jjc@thaiopensource.com>
;; Keywords: XML

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary:

;;; Code:

;;; Generating files with Unicode char names.

(require 'nxml-uchnm)

(defun nxml-create-unicode-char-name-sets (file)
  "Generate files containing char names from Unicode standard."
  (interactive "fUnicodeData file: ")
  (mapcar (lambda (block)
	    (let ((nameset (nxml-unicode-block-char-name-set (nth 0 block))))
	      (save-excursion
		(find-file (concat (get nameset 'nxml-char-name-set-file)
				   ".el"))
		(erase-buffer)
		(insert "(nxml-define-char-name-set '")
		(prin1 nameset (current-buffer))
		(insert "\n  '())\n")
		(goto-char (- (point) 3)))))
	  nxml-unicode-blocks)
  (save-excursion
    (find-file file)
    (goto-char (point-min))
    (let ((blocks nxml-unicode-blocks)
	  code name)
      (while (re-search-forward "^\\([0-9A-F]+\\);\\([^<;][^;]*\\);"
				nil
				t)
	(setq code (string-to-number (match-string 1) 16))
	(setq name (match-string 2))
	(while (and blocks
		    (> code (nth 2 (car blocks))))
	  (setq blocks (cdr blocks)))
	(when (and (<= (nth 1 (car blocks)) code)
		   (<= code (nth 2 (car blocks))))
	  (save-excursion
	    (find-file (concat (get (nxml-unicode-block-char-name-set
				     (nth 0 (car blocks)))
				    'nxml-char-name-set-file)
			       ".el"))
	    (insert "(")
	    (prin1 name (current-buffer))
	    (insert (format " #x%04X)\n    " code))))))))

;;; Parsing target repertoire files from ucs-fonts.
;; This is for converting the TARGET? files in
;; http://www.cl.cam.ac.uk/~mgk25/download/ucs-fonts.tar.gz
;; into a glyph set.

(defun nxml-insert-target-repertoire-glyph-set (file var)
  (interactive "fTarget file: \nSVariable name: ")
  (let (lst head)
    (save-excursion
      (set-buffer (find-file-noselect file))
      (goto-char (point-min))
      (while (re-search-forward "^ *\\([a-FA-F0-9]\\{2\\}\\)[ \t]+" nil t)
	(let ((row (match-string 1))
	      (eol (save-excursion (end-of-line) (point))))
	  (while (re-search-forward "\\([a-FA-F0-9]\\{2\\}\\)-\\([a-FA-F0-9]\\{2\\}\\)\\|\\([a-FA-F0-9]\\{2\\}\\)" eol t)
	    (setq lst
		  (cons (if (match-beginning 3)
			    (concat "#x" row (match-string 3))
			(concat "(#x" row (match-string 1)
				" . #x" row (match-string 2) ")"))
			lst))))))
    (setq lst (nreverse lst))
    (insert (format "(defconst %s\n  [" var))
    (while lst
      (setq head (car lst))
      (setq lst (cdr lst))
      (insert head)
      (when (= (length head) 6)
	(while (and lst (= (length (car lst)) 6))
	  (insert " ")
	  (insert (car lst))
	  (setq lst (cdr lst))))
      (when lst (insert "\n   ")))
    (insert "])\n")))

(provide 'nxml-maint)

;;; nxml-maint.el ends here
