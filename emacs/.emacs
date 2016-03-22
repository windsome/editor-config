;; (add-to-list 'load-path "~/.libs.emacs/eieio")
;; (add-to-list 'load-path "~/.libs.emacs/speedbar/")
;; (add-to-list 'load-path "~/.libs.emacs/semantic/")
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/")
;; (require 'ecb)

(add-to-list 'load-path "~/.libs.emacs")
(load "lyk.macro.el")

;; Setup GBK environment
(set-language-environment "Chinese-GBK")
(set-terminal-coding-system 'chinese-gbk)
(set-keyboard-coding-system 'chinese-gbk)
(setq locale-coding-system 'chinese-gbk)
(setq current-language-environment "Chinese-GBK")

;;--------------------------------------------------------------------------------
;;(global-set-key [f10] 'ejecuta-instruccion)
(global-set-key [f10] 'gud-next)
(global-set-key [f12] 'gud-down)
(global-set-key [f24] 'gud-up)
(global-set-key [S-f12] 'gud-up)
(global-set-key [f11] 'gud-step)
(global-set-key [f23] 'gud-finish) 
(global-set-key [S-f11] 'gud-finish) 
(global-set-key [f9] 'gud-break) 
(global-set-key [f21] 'gud-remove) ;; shift + f9
(global-set-key [S-f9] 'gud-remove) ;; shift + f9
;;--------------------------------------------------------------------------------

(setq default-tab-width 4) 

;; Visual feedback on selections
(setq-default transient-mark-mode t)

;; Always end a file with a newline
;;(setq require-final-newline nil)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; show column number
(setq column-number-mode t)

;; no backup file
;;(setq-default make-backup-files nil)
(setq make-backup-files nil) 

;; replace yes/no with y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; disable pc bell
(setq visible-bell t)

;; no startup screen
(setq inhibit-startup-message t)

;; show another parentheses but jump to it.
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; while cursor close to mouse, let mouse away
(mouse-avoidance-mode 'animate)

(menu-bar-mode nil)
(tool-bar-mode nil)
(scroll-bar-mode nil)

;; ;; set time-stamp
;; (add-hook 'write-file-hooks 'time-stamp)
;; (setq time-stamp-format "%:u %02m/%02d/%04y %02H02M02S")

(global-set-key "\M-g" 'goto-line)


; Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(autoload 'cmake-mode "cmake-mode.el" t)

(require 'doxymacs)

(add-hook 'c-mode-common-hook 'doxymacs-mode) 

(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

;; list all the lines of the current buffer matching a regrep
(global-set-key "\M-o" 'occur)

;; reference or search in files.
(global-set-key (kbd "C-M-z") 'grep-find)

(setq adaptive-fill-regexp "[ \t]+\\|[ \t]*\\([0-9]+\\.\\|\\*+\\)[ \t]*")

;; password displayed as *
(add-hook 'comint-output-filter-funtions
		  'comint-watch-for-password-promt)

; Fontlock mode settings.
(global-font-lock-mode t)

(setq font-lock-maximum-decoration t)

;;================================================================
;; settings of cvs
(setq cvs-dired-use-hook 'always) 
(define-key global-map "\C-xve" 'cvs-examine)

;;================================================================
;; Rebind C-z to start a shell (use .emacs_shellname for the shells rc file)
(global-set-key "\C-z" 'shell)

;; This binds word completions to Shift-Tab, and Ctrl+Space
;;(global-set-key [S-iso-lefttab] 'dabbrev-completion)

;; Set up some f-key shortcuts
;;(global-set-key [f1]    'help)
(global-set-key [S-f1]  'man)
(global-set-key [f2]    'save-buffer)
;;(global-set-key [f3]    'save-buffer)
(global-set-key [f4]    'kill-this-buffer)

;;================================================================
;;compile key binding.
(global-set-key [f5]    'compile)
(global-set-key [f6]    'first-error)
(global-set-key [f7]    'previous-error)
(global-set-key [f8]    'next-error)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(require 'ido)
(ido-mode t)


(add-hook 'ido-define-mode-map-hook 'ido-my-keys)

(defun ido-my-keys ()
  "Set up the keymap for `ido'."

  ;; common keys
  (define-key ido-mode-map "\C-e" 'ido-edit-input)   
  (define-key ido-mode-map "\t" 'ido-complete) ;; complete partial
  (define-key ido-mode-map "\C-j" 'ido-select-text)
  (define-key ido-mode-map "\C-m" 'ido-exit-minibuffer)
  (define-key ido-mode-map "?" 'ido-completion-help) ;; list completions
  (define-key ido-mode-map [(control ? )] 'ido-restrict-to-matches)
  (define-key ido-mode-map [(control ?@)] 'ido-restrict-to-matches)

  ;; cycle through matches
  (define-key ido-mode-map "\C-r" 'ido-prev-match)
  (define-key ido-mode-map "\C-s" 'ido-next-match)
  (define-key ido-mode-map [right] 'ido-next-match)
  (define-key ido-mode-map [left] 'ido-prev-match)

  ;; toggles
  (define-key ido-mode-map "\C-t" 'ido-toggle-regexp) ;; same as in isearch
  (define-key ido-mode-map "\C-p" 'ido-toggle-prefix)
  (define-key ido-mode-map "\C-c" 'ido-toggle-case)
  (define-key ido-mode-map "\C-a" 'ido-toggle-ignore)

  ;; keys used in file and dir environment
  (when (memq ido-cur-item '(file dir))
    (define-key ido-mode-map "\C-b" 'ido-enter-switch-buffer)
    (define-key ido-mode-map "\C-d" 'ido-enter-dired)
    (define-key ido-mode-map "\C-f" 'ido-fallback-command)

    ;; cycle among directories
    ;; use [left] and [right] for matching files
    (define-key ido-mode-map [down] 'ido-next-match-dir)
    (define-key ido-mode-map [up]   'ido-prev-match-dir)

    ;; backspace functions
    (define-key ido-mode-map [backspace] 'ido-delete-backward-updir)
    (define-key ido-mode-map "\d"        'ido-delete-backward-updir)
    (define-key ido-mode-map [(meta backspace)] 'ido-delete-backward-word-updir)
    (define-key ido-mode-map [(control backspace)] 'ido-up-directory)

    ;; I can't understand this
    (define-key ido-mode-map [(meta ?d)] 'ido-wide-find-dir)
    (define-key ido-mode-map [(meta ?f)] 'ido-wide-find-file)
    (define-key ido-mode-map [(meta ?k)] 'ido-forget-work-directory)
    (define-key ido-mode-map [(meta ?m)] 'ido-make-directory)

    (define-key ido-mode-map [(meta down)] 'ido-next-work-directory)
    (define-key ido-mode-map [(meta up)] 'ido-prev-work-directory)
    (define-key ido-mode-map [(meta left)] 'ido-prev-work-file)
    (define-key ido-mode-map [(meta right)] 'ido-next-work-file)

    ;; search in the directories
    ;; use C-_ to undo this
    (define-key ido-mode-map [(meta ?s)] 'ido-merge-work-directories)
    (define-key ido-mode-map [(control ?\_)] 'ido-undo-merge-work-directory)
    )

  (when (eq ido-cur-item 'file)
    (define-key ido-mode-map "\C-k" 'ido-delete-file-at-head)
    (define-key ido-mode-map "\C-l" 'ido-toggle-literal)
    (define-key ido-mode-map "\C-o" 'ido-copy-current-word)
    (define-key ido-mode-map "\C-v" 'ido-toggle-vc)
    (define-key ido-mode-map "\C-w" 'ido-copy-current-file-name)
    )

  (when (eq ido-cur-item 'buffer)
    (define-key ido-mode-map "\C-b" 'ido-fallback-command)
    (define-key ido-mode-map "\C-f" 'ido-enter-find-file)
    (define-key ido-mode-map "\C-k" 'ido-kill-buffer-at-head)
    ))

(ido-mode t)


;;-------------------------------------------------------------------------
(require 'swbuff)
(global-set-key [C-prior] 'swbuff-switch-to-previous-buffer)
(global-set-key [C-next] 'swbuff-switch-to-next-buffer)
(setq swbuff-exclude-buffer-regexps 
	  '("^ " "\\*.*\\*"))
(setq swbuff-status-window-layout 'scroll)
(setq swbuff-clear-delay 3)
(setq swbuff-separator "|")
(setq swbuff-window-min-text-height 1)
(autoload 'table-insert "table" "WYGIWYS table editor")

;;-------------------------------------------------------------------------
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

;;-------------------------------------------------------------------------
(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))

;;----------------------------------------------------------------------
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

;;(define-key global-map (kbd "s-c") 'wy-go-to-char)
(define-key global-map (kbd "M-n") 'wy-go-to-char)
(define-key global-map (kbd "C-c n") 'wy-go-to-char)

;;hide region
(require 'hide-region)
(global-set-key (kbd "C-c r") 'hide-region-hide)
(global-set-key (kbd "C-c R") 'hide-region-unhide)

;; hide lines
(require 'hide-lines)
(global-set-key (kbd "C-c l") 'hide-lines)
(global-set-key (kbd "C-c L") 'show-all-invisible)

;; ;;--------------------------------------------------------------------
;; (autoload 'mmm-mode "mmm-mode" "Multiple Major Modes" t)
;; (autoload 'mmm-parse-buffer "mmm-mode" "Automatic MMM-ification" t)

;; ;;================================================================
;; ;; xml mode hook.
;; (defun my-activate-sgml () (load "~/.libs.emacs/nxml-mode-20040908/rng-auto.el"))
;; (add-hook 'c-mode-hook 'my-activate-sgml)
;; (setq auto-mode-alist
;; 	  (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
;; 			auto-mode-alist))

;;================================================================
;; cscope hook, why there is no key-bindings when use hook to start cscope?
(require 'xcscope)
;;(require 'cscope)
;; (defun my-activate-cscope () (require 'xcscope))
;; (add-hook 'c-mode-hook 'my-activate-cscope)
;; (add-hook 'c++-mode-hook 'my-activate-cscope)


(defun my-c-mode-hook ()
  (require 'ctypes)
  (turn-on-font-lock))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
;(add-hook 'java-mode-hook 'my-c-mode-hook)
(add-hook 'java-mode-hook (function cscope:hook))

;;--------------------------------------------------------------------
(require 'recentf)
(recentf-mode 1)

;;--------------------------------------------------------------------
(defun recentf-open-files-compl ()
  (interactive)
  (let* ((all-files recentf-list)
	 (tocpl (mapcar (function 
			 (lambda (x) (cons (file-name-nondirectory x) x))) all-files))
	 (prompt (append '("File name: ") tocpl))
	 (fname (completing-read (car prompt) (cdr prompt) nil nil)))
    (find-file (cdr (assoc-ignore-representation fname tocpl))))) 
(global-set-key [(control x)(control r)] 'recentf-open-files-compl)

;;--------------------------------------------------------------------
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list 
      '(try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))

;; ;;--------------------------------------------------------------------
;; (custom-set-variables
;;  '(load-home-init-file t t))

;; ;;--------------------------------------------------------------------
;; (defun lev/find-tag (&optional show-only)
;;   "Show tag in other window with no prompt in minibuf."
;;   (interactive)
;;   (let ((default (funcall (or find-tag-default-function
;;                               (get major-mode 'find-tag-default-function)
;;                               'find-tag-default))))
;;     (if show-only
;;         (progn (find-tag-other-window default)
;;                (shrink-window (- (window-height) 12)) ;; limit to 12 colums
;;                (recenter 1)
;;                (other-window 1))
;;       (find-tag default))))

(setq dired-recursive-deletes t)
(setq dired-recursive-copies t)
(require 'dired-x)
(setq dired-guess-shell-alist-user
      (list
       (list "\\.chm$" "xchm")
       (list "\\.rm$" "gmplayer")
       (list "\\.rmvb$" "gmplayer")
       (list "\\.avi$" "gmplayer")
       (list "\\.asf$" "gmplayer")
       (list "\\.wmv$" "gmplayer")
       (list "\\.htm$" "w3m")
       (list "\\.html$" "w3m")
       (list "\\.mpg$" "gmplayer")
	   ))

;; (add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
;; (add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
;; (add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
;; (add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
;; (defalias 'perl-mode 'cperl-mode)

(setq dired-omit-files
     (concat dired-omit-files "\\|^\\..+$\\|\\.vcproj$\\|\\.vcp$\\|\\.bor$\\|\\.vcw$\\|\\.sln$"))

(setq dired-omit-files
     (concat dired-omit-files "\\|\\.mpb$\\|\\.mwc$\\|\\.mpc$\\|\\.out$"))

(setq dired-omit-files
     (concat dired-omit-files "\\|cscope\\.\\|\\.mp3$\\|CVS$"))

;; ;;================================================================
;; (require 'pc-bufsw "/usr/EmacsPak/pc-bufsw.el")
;; ;;(pc-bufsw::bind-keys [C-tab] [C-S-tab])
;; (pc-bufsw::bind-keys [C-tab] [C-S-iso-lefttab])
;; ;;(pc-bufsw::bind-keys [f12] [f11])

;; ;;================================================================
;; ;; Subversion support
;; (require 'psvn)

;; ;;================================================================
;; ;; w3m literal browser
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m/")
;; (require 'w3m-load)
;; (require 'mime-w3m)


;; ;;================================================================
;; ;; dictionary, from wangyin.
;; (autoload 'dictionary-search "dictionary"
;;   "Ask for a word and search it in all dictionaries" t)
;; (autoload 'dictionary-match-words "dictionary"
;;   "Ask for a word and search all matching words in the dictionaries" t)
;; (autoload 'dictionary-lookup-definition "dictionary"
;;   "Unconditionally lookup the word at point." t)
;; (autoload 'dictionary "dictionary"
;;   "Create a new dictionary buffer" t)
;; (autoload 'dictionary-mouse-popup-matching-words "dictionary"
;;   "Display entries matching the word at the cursor" t)
;; (autoload 'dictionary-popup-matching-words "dictionary"
;;   "Display entries matching the word at the point" t)
;; (autoload 'dictionary-tooltip-mode "dictionary"
;;   "Display tooltips for the current word" t)
;; (autoload 'global-dictionary-tooltip-mode "dictionary"
;;   "Enable/disable dictionary-tooltip-mode for all buffers" t)
;; (global-set-key [mouse-3] 'dictionary-mouse-popup-matching-words)
;; (global-set-key [(control c)(d)] 'dictionary-lookup-definition)
;; (global-set-key [(control c)(s)] 'dictionary-search)
;; (global-set-key [(control c)(m)] 'dictionary-match-words)
;; ;; choose a dictionary server
;; (setq dictionary-server "localhost")
;; ;; for dictionary tooltip mode
;; ;; choose the dictionary: "wn" for WordNet
;; ;; "web1913" for Webster's Revised Unabridged Dictionary(1913)
;; ;; so on
;; (setq dictionary-tooltip-dictionary "wn")
;; (global-dictionary-tooltip-mode t)
;; ;(dictionary-tooltip-mode t)


;;================================================================
;; color theme.

;;================================================================
;; ;;TTY type terminal
;; (if (and (not window-system)
;;      (not (equal system-type 'ms-dos)))
;;     (progn
;; 	  (color-theme-dark-laptop)))

;;================================================================
	  (setq user-full-name "windsome.feng")
	  (setq user-mail-address "86643838@163.com")
;	  (setq user-mail-address "agooou@gmail.com")
;; X11 or PC using direct screen writes
(if window-system
    (progn
	  (add-to-list 'load-path "~/.libs.emacs/color_theme/")
	  (require 'color-theme)
;;	  (auto-image-file-mode)
;;	  (setq user-full-name "Richard")
;;	  (setq user-mail-address "rihcard_luo@alphanetworks.com")
;;	  (custom-set-faces)
	  (setq frame-title-format "%f")
	  (mwheel-install)
;;	  (global-set-key (kbd "H-s-SPC") 'set-mark-command)
;;	  (define-key global-map (kbd "H-s-n") 'wy-go-to-char)
	  (color-theme-deep-blue)
;;	  (set-default-font "-adobe-courier-medium-r-normal--18-180-75-75-m-110-iso8859-1" ) ;good
	  (set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1" )
	  ))


;; ;;--------------------------------------------------------------------------------
;; (add-hook 'comint-output-filter-functions
;; 		  'comint-watch-for-password-prompts)

;;================================================================
;; ansi color, Good!!
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'c-mode-hook (lambda () (modify-syntax-entry ?_ "w" c-mode-syntax-table)))
(add-hook 'c++-mode-hook (lambda () (modify-syntax-entry ?_ "w" c++-mode-syntax-table)))
(add-hook 'c++-mode-hook (lambda() (c-set-style "stroustrup")))
(add-hook 'c-mode-hook (lambda () (c-set-style "stroustrup")))


(setq-default indent-tabs-mode nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(doxymacs-doxygen-style "JavaDoc")
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 20) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t) (set-background-color "black")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(background "blue")
 '(font-lock-builtin-face ((((class color) (background dark)) (:foreground "Turquoise"))))
 '(font-lock-comment-face ((t (:foreground "MediumAquamarine"))))
 '(font-lock-constant-face ((((class color) (background dark)) (:bold t :foreground "DarkOrchid"))))
 '(font-lock-doc-string-face ((t (:foreground "green2"))))
 '(font-lock-function-name-face ((t (:foreground "SkyBlue"))))
 '(font-lock-keyword-face ((t (:bold t :foreground "CornflowerBlue"))))
 '(font-lock-preprocessor-face ((t (:italic nil :foreground "CornFlowerBlue"))))
 '(font-lock-reference-face ((t (:foreground "DodgerBlue"))))
 '(font-lock-string-face ((t (:foreground "LimeGreen"))))
 '(font-lock-type-face ((t (:foreground "#9290ff"))))
 '(font-lock-variable-name-face ((t (:foreground "PaleGreen"))))
 '(font-lock-warning-face ((((class color) (background dark)) (:foreground "yellow" :background "red"))))
 '(highlight ((t (:background "CornflowerBlue"))))
 '(list-mode-item-selected ((t (:background "gold"))))
 '(makefile-space-face ((t (:background "wheat"))) t)
 '(mode-line ((t (:background "Navy"))))
 '(paren-match ((t (:background "darkseagreen4"))))
 '(region ((t (:background "DarkSlateBlue"))))
 '(show-paren-match ((t (:foreground "black" :background "wheat"))))
 '(show-paren-mismatch ((((class color)) (:foreground "white" :background "red"))))
 '(speedbar-button-face ((((class color) (background dark)) (:foreground "green4"))))
 '(speedbar-directory-face ((((class color) (background dark)) (:foreground "khaki"))))
 '(speedbar-file-face ((((class color) (background dark)) (:foreground "cyan"))))
 '(speedbar-tag-face ((((class color) (background dark)) (:foreground "Springgreen"))))
 '(vhdl-speedbar-architecture-selected-face ((((class color) (background dark)) (:underline t :foreground "Blue"))))
 '(vhdl-speedbar-entity-face ((((class color) (background dark)) (:foreground "darkGreen"))))
 '(vhdl-speedbar-entity-selected-face ((((class color) (background dark)) (:underline t :foreground "darkGreen"))))
 '(vhdl-speedbar-package-face ((((class color) (background dark)) (:foreground "black"))))
 '(vhdl-speedbar-package-selected-face ((((class color) (background dark)) (:underline t :foreground "black"))))
 '(widget-field ((((class grayscale color) (background light)) (:background "DarkBlue")))))
