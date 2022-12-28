;;; packages
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"));
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/")t)
;(add-to-list 'package-archives '("marmelade" . "http://marmalade-repo.org/packages/"));
(package-initialize)

;; (setq use-package-always-ensure t)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
;;(use-package cl-lib)
;;(require 'cl)

;; misc
(use-package  gnu-elpa-keyring-update)



(use-package diminish
  :defer t)
(use-package bind-key)


;;; Startup/Performance

;; Usually emacs triggers GC at ~0.8MB of memory at startup and most(?) systems have greater than that
(setq gc-cons-threshold 100000000)
;;(add-hook 'after-init-hook #'(lambda ()
 ;;                              ;; restore after startup
;;                             (setq gc-cons-threshold 800000)))

;; increase the amount of data which Emacs reads from the process. Again the emacs default is too low 4k considering that the some of the language server responses are in 800k - 3M range.
(setq read-process-output-max (* 1024 1024))

;;inhibit start-up message
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;;; Shutting down
;;(setq confirm-kill-emacs (quote y-or-n-p))

;; Helper
(defun is-extension-p (extension)
  (and (stringp buffer-file-name)
       (string-match (concat "\\." extension "\\'")
                     buffer-file-name)))

;Dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Abandon all hope, ye who enter here")
(setq dashboard-startup-banner "~/.emacs.d/nice.png")
  (setq dashboard-center-content t)
  (setq dashboard-set-init-info t))
;;(setq dashboard-set-heading-icons t)
;;(setq dashboard-set-file-icons t)
;;(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

;;; Emacsclient
(if (and (fboundp 'server-running-p)
         (not (server-running-p)))
(server-start))
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))


;;; Appearance

(use-package gruvbox-theme)
(use-package powerline)
;; (load-theme 'gruvbox-dark-medium)


;; Font
;(add-to-list 'bdf-directory-list "/home/hitagi/.fonts/")

;(setq default-frame-alist '((tamzen . "-Misc-tamzen-normal-normal-normal-*-16-*-*-*-c-80-iso10646-1")))
;(add-to-list 'default-frame-alist '(font . "-Misc-tamzen-normal-normal-normal-*-16-*-*-*-c-80-iso10646-1"))

;; (defun please-work ()
;;   (set-face-attribute 'default nil :background "black" :foreground "white"
;;                       :font "-misc-tamzen-medium-r-normal--16-*-100-100-c-80-iso8859-1" :height 120))

(set-frame-font "Tamzen 13" nil t)

;(set-frame-font "-Misc-tamzen-normal-normal-normal-*-16-*-*-*-c-80-iso10646-1")
;; (set-language-environment 'utf-8)
;; (setq locale-coding-system 'utf-8)
;; ;; set the default encoding system
;; (prefer-coding-system 'utf-8)
;; (setq default-file-name-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
;;(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; UI
(if (functionp 'menu-bar-mode) (menu-bar-mode -1))
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))
(if (functionp 'scroll-bar-mode) (scroll-bar-mode -1))
(global-visual-line-mode 1)
(diminish 'visual-line-mode "")

;; sublimity
(use-package sublimity
  :config
  (sublimity-mode 1))
(require 'sublimity-scroll)

;; Sounds
(setq ring-bell-function 'ignore)

;;; Behavior

(setq backup-directory-alist '(("." . "~/.autosave/")))
(fset 'yes-or-no-p 'y-or-n-p)
(blink-cursor-mode 0)
(setq-default delete-selection-mode 1)
(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'expand-region))
(global-set-key (kbd "C-x C-l") 'load-file)

;;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-move-forward-on-expand        nil
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-user-mode-line-format         nil
          treemacs-user-header-line-format       nil
          treemacs-width                         30
          treemacs-workspace-switch-cleanup      nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package centaur-tabs
  :config
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

;;; Projectile
(use-package helm-projectile
  :after projectile)
(use-package projectile
  :defer t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on)
  (projectile-global-mode))

;;; Parentheses


(defun expand-parentheses()
  "Adds an additional layer of parentheses mirroring the one the cursor is on"
  (interactive)
  (let ((delim (following-char))
        (start '(( ?\( . ?\) )
                 ( ?\[ . ?\] )))
        (end '(( ?\) . ?\( )
               ( ?\] . ?\[ ))))
    (save-excursion
      (cond ((assoc delim start)
             (insert delim)
             (forward-sexp)
             (insert (cdr (assoc delim start))))
            ((assoc delim end)
             (insert delim)
             (backward-sexp)
             (forward-char 1)
             (insert (cdr (assoc delim end))))))))

(global-set-key (kbd "C-M-j") #'expand-parentheses)

;; (require 'smartparens-config)
;; (use-package smartparens
;;   :init
;;   (bind-key "C-M-f" #'sp-forward-sexp smartparens-mode-map)
;;   (bind-key "C-M-b" #'sp-backward-sexp smartparens-mode-map)
;;   (bind-key "C-)" #'sp-forward-slurp-sexp smartparens-mode-map)
;;   (bind-key "C-(" #'sp-backward-slurp-sexp smartparens-mode-map)
;;   (bind-key "M-)" #'sp-forward-barf-sexp smartparens-mode-map)
;;   (bind-key "M-(" #'sp-backward-barf-sexp smartparens-mode-map)
;;   (bind-key "C-S-s" #'sp-splice-sexp)
;;   (bind-key "C-M-<backspace>" #'backward-kill-sexp)
;;   (bind-key "C-M-S-<SPC>" (lambda () (interactive) (mark-sexp -1)))
;;   :config
;;   (smartparens-global-mode t)
;;   (smartparens-global-strict-mode t)
;;   (show-smartparens-global-mode t)
;;   (sp-pair "'" nil :actions :rem)
;;   (sp-pair "`" nil :actions :rem)
;;   (setq sp-highlight-pair-overlay nil))

;; Saving files
(add-hook 'before-save-hook
          (lambda ()
            (delete-trailing-whitespace)))

;; Buffers
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
; ace-window
;(global-set-key (kbd "C-;") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(global-set-key (kbd "C-;") #'other-window)
(defun prev-window ()
  (interactive)
  (other-window -1))

(when (fboundp 'winner-mode)
  (winner-mode 1))


;;(setq -electricpair-preserve-balance nil)
(setq kill-buffer-query-functions nil)
(defun custom-kill-buffer-fn (&optional arg)
"When called with a prefix argument -- i.e., C-u -- kill all interesting
buffers -- i.e., all buffers without a leading space in the buffer-name.
When called without a prefix argument, kill just the current buffer
-- i.e., interesting or uninteresting."
(interactive "P")
  (cond
    ((and (consp arg) (equal arg '(4)))
      (mapc
        (lambda (x)
          (let ((name (buffer-name x)))
            (unless (eq ?\s (aref name 0))
              (kill-buffer x))))
        (buffer-list)))
    (t
     (kill-buffer (current-buffer)))))

;;; Writing
;; (setq-default auto-fill-function 'do-auto-fill)
;; (diminish 'auto-fill-mode "")
;; (setq-default fill-column 80)
;; (add-hook 'paragraph-indent-text-mode 'auto-fill-mode)
(add-hook 'org-mode 'visual-fill-column-mode)
(add-hook 'c++-mode 'visual-fill-column-mode)
(add-hook 'c-mode 'visual-fill-column-mode)
(add-hook 'python-mode 'visual-fill-column-mode)

(use-package darkroom
  :defer t)

;;; EVIL
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode))
(use-package evil-collection
  :custom (evil-collection-init)
  :init (evil-collection-init))

;;; QOL
(use-package beacon
  :diminish beacon-mode
  :init
  (eval-when-compile
    ;; Silence missing function warnings
    (declare-function beacon-mode "beacon.el"))
  :config
  (beacon-mode t))
(use-package hungry-delete
  :diminish hungry-delete-mode
  :init
  (eval-when-compile
    ;; Silence missing function warnings
    (declare-function global-hungry-delete-mode "hungry-delete.el"))
  :config
  (global-hungry-delete-mode t)
)

;;; Programming

(show-paren-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
(use-package terminal-here
  :config
  (setq terminal-here-linux-terminal-command 'urxvt))

;;indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)

;; cool packages
(use-package flycheck
  :init
  (setq flycheck-check-syntax-automatically '(save mode-enable))
  :custom
  (flycheck-display-errors-delay .3))


;; Helm
;; (use-package helm-config)
(use-package helm
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-mini)
         ("M-/" . helm-dabbrev))
  :config
  (helm-autoresize-mode 1)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind
  ;; tab to run persistent action
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (setq
   helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window
   helm-autoresize-min-height 30
   helm-autoresize-max-height 40
   ))
 (use-package helm-files
   :bind ("C-x C-f" . helm-find-files))
;; (use-package helm-mode
;;   :diminish helm-mode
;;   :config
;;   (helm-mode 1))

;; Company
(use-package company
  :init (global-company-mode))

;; CMake
(use-package cmake-mode)
(autoload 'cmake-mode "cmake-mode" "Major mode for editing CMake listfiles." t)
(setq auto-mode-alist
          (append
           '(("CMakeLists\\.txt\\'" . cmake-mode))
           '(("\\.cmake\\'" . cmake-mode))
           auto-mode-alist))

;; Scripting

;; Automatically make a file executable if it contains a shebang
(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

;; Lisp
(use-package slime
  :bind ("C-c r" . slime-eval-buffer)
  :config
  (slime-setup '(slime-fancy slime-company)))

(add-hook 'lisp-mode-hook 'slime-mode)
(use-package rainbow-delimiters)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
;(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")
(use-package slime-company
  :after (slime company)
  :config (setq slime-company-completion 'fuzzy
                slime-company-after-completion 'slime-company-just-one-space))
(use-package lispy
  :init
  (add-hook 'lisp-mode-hook (lambda () (lispy-mode 1)))
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
  (add-hook 'clojure-mode-hook (lambda () (lispy-mode 1)))
  :config
  (setq lispy-compat '(cider)))

(use-package lispyville
  :after (lispy)
  :init
  (add-hook 'lispy-mode-hook #'lispyville-mode))

;; Graphviz
;(use-package graphviz-dot-mode)
;(add-hook 'graphviz-mode-hook 'display-line-numbers-mode)

;; Python
(use-package jedi
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  :config
  (setq jedi:complete-on-dot t))
(use-package elpy
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  (setq elpy-rpc-backend "jedi"))
(add-hook 'python-mode-hook 'flymake-mode)

(use-package ein)
(require 'ein-pytools)

;; C
(defun compile-cpp-program ()
  (interactive)
  (let ((name (subseq (buffer-name) 0 (- (length (buffer-name)) 4))))
    (async-shell-command
     (concat "g++ -Wall " name ".cpp -o " name ".out"))))
(defun execute-cpp-program ()
  (interactive)
  (let ((name (subseq (buffer-name) 0 (- (length (buffer-name)) 4))))
    (async-shell-command
     (concat "g++ -Wall " name ".cpp -o " name ".out && ./" name ".out"))))
(defun compile-c-program ()
  (interactive)
  (let ((name (subseq (buffer-name) 0 (- (length (buffer-name)) 2))))
    (async-shell-command
     (concat "gcc " name ".c -o " name ".out"))));;
(defun execute-c-program ()
  (interactive)
  (let ((name (subseq (buffer-name) 0 (- (length (buffer-name)) 2))));
    (async-shell-command
     (concat "gcc -Wall " name ".c -o " name ".out && ./" name ".out"))))

(with-eval-after-load "cc-mode" (define-key c++-mode-map [?\C-c ?\C-r] #'execute-cpp-program))
(with-eval-after-load "cc-mode" (define-key c++-mode-map [?\C-c r] #'compile-cpp-program))
(with-eval-after-load "cc-mode" (define-key c-mode-base-map [?\C-c ?\C-r] #'execute-c-program))
(with-eval-after-load "cc-mode" (define-key c-mode-base-map [?\C-c r] #'compile-c-program))

(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'display-line-numbers-mode)
(add-hook 'c-mode-hook 'display-line-numbers-mode)

;; Javascript & web dev
(use-package js2-mode
  :config
  (setq-default js2-basic-offset 2))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(defun insert-semicolon ()
  (interactive)
  (save-excursion
    (end-of-line)
    (insert ";"))
  (next-line))
;(eval-after-load "js2-mode" (define-key js-mode-map [?\C-'] #'insert-semicolon))
 (add-hook 'find-file-hook (lambda ()
                              (if (is-extension-p "vue")
                                  (progn (web-mode)
                                         (define-key js-mode-map [?\C-'] #'insert-semicolon))
                                nil)))
(use-package web-mode)


;;; w3m
;(use-package w3m
;  :defer t)
;(require 'w3m-load)

;(setq browse-url-browser-function 'w3m-browse-url)
;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
;(global-set-key "\C-xm" 'browse-url-at-point)

;;(define-key w3m-mode-map [mouse-2] 'w3m-mouse-view-this-url-new-session)

;;(defadvice mouse-drag-track (after replace-mouse-2-event activate)
;;  "Replace mounse-2 event with the key for `w3m-view-this-url' command.
;;This will be done only when mouse-1 is clicked in an emacs-w3m buffer
;;and `mouse-1-click-follows-link' is non-nil."
;;  (let ((keys (this-command-keys)))
;;    (if (and (vectorp keys)
;;	     (eq (car-safe (aref keys 0)) 'down-mouse-1)
;;	     (eq (car-safe (car unread-command-events)) 'mouse-2)
;;	     (with-current-buffer
;;		 (window-buffer
;;		  (posn-window (event-start (car unread-command-events))))
;;	       (eq major-mode 'w3m-mode)))

;;		(aref (car (where-is-internal 'w3m-view-this-url
;;					      w3m-mode-map))
;;		      0)))))
;; Org-mode
(use-package org-bullets)
;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook 'org-bullets-mode)
;;(setq inhibit-compacting-font-caches t)
;;(add-hook 'org-mode-hook 'org-startup-with-inline-images)
(add-hook 'org-mode-hook #'abbrev-mode)
(setq org-image-actual-width nil)
(add-hook 'org-mode-hook #'org-indent-mode)
; org-capture
;(setq org-default-notes-file (concat org-directory "/notes.org"))
(global-set-key (kbd "C-c c") 'org-capture)



;;; Latex
(add-hook 'latex-mode-hook 'display-line-numbers-mode)
;(setenv "PATH" (concat "/usr/local/texlive/2020/bin/x86_64-linux/:" (getenv "PATH")))
;(setq exec-path (append '("/usr/local/texlive/2020/bin/x86_64-linux/") exec-path))
(setq org-latex-create-formula-image-program 'dvipng)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.8))

;


;;; IRC
;(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "#erc" "#gentoo")
;                                    ("installgentoo.com" "#installgentoo")))

;; Magit
(use-package magit
  :defer t)
;email-client

;(setq user-mail-address "nameo@large.com")

;(setq smtpmail-default-smtp-server "Domain name of macine with SMTP server")
;(setq smtpmail-local-domain nil)
;(setq send-mail-function 'smtpmail-send-it)

;(load-library "smtpmail")
;(load-library "message")
;;(setq message-send-mail-function 'smtpmail-send-it)

;;; RSS feeds
(use-package elfeed
  :defer t
  :config
  (global-set-key (kbd "C-x w") 'elfeed))

(setq custom-file "~/.emacs.d/.emacs-custom.el")
(load custom-file)
