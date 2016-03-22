; Chinese environment settings.
(set-language-environment 'Chinese-GB)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq-default pathname-coding-system 'utf-8)

; Looking settings.
(set-frame-height (selected-frame) 27)
(set-frame-width (selected-frame) 80)
(set-foreground-color "white")
(set-background-color "darkgreen")
(set-face-foreground 'modeline "darkgreen")
;(set-face-background 'modeline "white")
(set-cursor-color "purple")
(set-default-font "-misc-fixed-medium-r-normal--18-120-100-100-c-90-iso8859-1")

; Fontlock mode settings.
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(setq font-lock-support-mode 'lazy-lock-mode)

; C-mode settings.
(setq c-macro-preprocessor "cpp -C")
(add-hook 'c-mode-hook
	  '(lambda ()
	     (c-set-style "k&r")
	     (c-toggle-hungry-state)
	     (c-toggle-auto-state)))

; C++-mode settings.
(add-hook 'cc-mode-hook
	  '(lambda ()
	     (c-set-style "stroustrup")
	     (c-toggle-hungry-state)
	     (c-toggle-auto-state)))

; Shell settings.
(setq comint-scroll-show-maximum-output 'this)
(setq comint-completion-addsuffix t)
(make-variable-buffer-local 'comint-completion-addsuffix)
(setq comint-eol-on-send t)
(setq shell-command-switch "-cf")

; Bash settings.
(setq bash-shell-file-name "/bin/sh")
(setenv "SHELL" bash-shell-file-name)
(setq explicit-shell-file-name bash-shell-file-name)
(setq shell-file-name bash-shell-file-name)

; Personal settings.
(menu-bar-mode nil)
(scroll-bar-mode nil)
(tool-bar-mode nil)
(show-paren-mode t)
(setq-default make-backup-files nil)
(display-time)
(column-number-mode t)
(setq line-number-mode t)
(setq frame-title-format "%b [%s] -- %F")
(setq scroll-step 1)
