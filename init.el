(setq org-confirm-babel-evaluate nil)

; basic interface setup
(setq inhibit-startup-message t)
(setq visible-bell t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(scroll-bar-mode -1)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package all-the-icons
  :if (display-graphic-p))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

					;(use-package doom-themes
					;  :init (load-theme 'doom-gruvbox t))

(set-face-attribute 'default nil :family "FiraCode Nerd Font Mono")

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Doom themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(defun rune/evil-hook ()
  (dolist (mode '(custom-mode
                  eshell-mode
                  git-rebase-mode
                  erc-mode
                  circe-server-mode
                  circe-chat-mode
                  circe-query-mode
                  sauron-mode
                  term-mode))
   (add-to-list 'evil-emacs-state-modes mode)))

; enables evil mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :hook (evil-mode . rune/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))


(require 'evil)
(evil-mode 1)

(use-package projectile
    :diminish projectile-mode
    :config (projectile-mode)
    :bind-keymap
    ("C-c p" . projectile-command-map)
    :init
    (when (file-directory-p "~/Projects/Code")
      (setq projectile-project-search-path '("~/Projects/Code")))
    (setq projectile-switch-project-action #'projectile-dired))

  (use-package counsel-projectile
   :after projectile
   :config
   (counsel-projectile-mode 1))

  (use-package magit
    :commands (magit-status magit-get-current-branch)
    :custom
    (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))


(use-package neotree)

(defun dw/org-mode-setup ()
    (org-indent-mode)
    (variable-pitch-mode 1)
    (auto-fill-mode 0)
    (visual-line-mode 1)
    (setq evil-auto-indent nil))

  (defun efs/org-font-setup ()
    ;; Replace list hyphen with dot
    (font-lock-add-keywords 'org-mode
        			  '(("^ *\\([-]\\) "
        			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

    (dolist (face '((org-level-1 . 1.75)
                    (org-level-2 . 1.5)
                    (org-level-3 . 1.25)
                    (org-level-4 . 1.1)
                    (org-level-5 . 1.0)
                    (org-level-6 . 1.0)
                    (org-level-7 . 1.0)
                    (org-level-8 . 1.0)
  		  (org-document-title . 0.75)))
      (set-face-attribute (car face) nil :weight 'regular :height (cdr face)))

    ;; Make sure org-indent face is available
    (require 'org-indent)

    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

  (use-package visual-fill-column
    :ensure t)

  (defun my/org-mode-center-buffer ()
    (visual-line-mode 1)
    (setq visual-fill-column-width 120
  	visual-fill-column-center-text t)
    (visual-fill-column-mode 1))

  (use-package org
    :hook (org-mode . dw/org-mode-setup)
    :config
    (setq org-ellipsis " ▾" org-hide-emphasis-markers t)
    (setq org-directory "~/org")
    (setq org-agenda-files '("~/org/" "~/org/roam/" "~/org/roam/daily/"))
    (setq org-todo-keywords
        	'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
        	  (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

    (setq org-refile-targets
        	'(("Archive.org" :maxlevel . 1)))

    (efs/org-font-setup)
    ;; Save Org buffers after refiling!
    (advice-add 'org-refile :after 'org-save-all-org-buffers)
    (add-hook 'org-mode-hook #'my/org-mode-center-buffer)
    (add-hook 'org-mode-hook (lambda ()
  			   (display-line-numbers-mode -1))))


  (use-package org-bullets
    :after org
    :hook (org-mode . org-bullets-mode)
    :custom
    (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))
    (efs/org-font-setup))

  (use-package org-roam
    :after org
    :ensure t
    :init
    (setq org-roam-v2-ack t)
    :custom
    (org-roam-directory (file-truename "~/org/roam"))
     					;(org-roam-completion-system 'ivy)
    (org-roam-completion-everywhere t)
    :bind (("C-c n l" . org-roam-buffer-toggle)
           ("C-c n f" . org-roam-node-find)
           ("C-c n g" . org-roam-graph)
           ("C-c n i" . org-roam-node-insert)
           ("C-c n c" . org-roam-capture)
        	 ("C-M-i"   . completion-at-point)
           ;; Dailies
           ("C-c n j" . org-roam-dailies-capture-today))
    :config
    ;; If you're using a vertical completion framework, you might want a more informative completion interface
    ;(setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
    (org-roam-setup)
    )

  (use-package cape
    :after org-roam 
    :ensure t
    :init
    ;; Hook Org-roam’s completion-at-point into Cape
     					;(add-to-list 'completion-at-point-functions 'org-roam-complete-at-point)
    ;; If you use Company, tie Cape in:
    (add-hook 'org-mode-hook #'company-mode))

  (use-package evil-org
    :ensure t
    :after org
    :hook (org-mode . (lambda () evil-org-mode))
q    :config
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys))


  (use-package evil-nerd-commenter
    :bind ("C-;" . evilnc-comment-or-uncomment-lines))

  					; auto tangle
  (defun efs/org-babel-tangle-config ()
    (when (string-equal (buffer-file-name)
  		      (expand-file-name "~/.emacs.d/config.org"))
      (let ((org-confirm-babel-evaluate nil))
        (org-babel-tangle))))

  (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook
                                                        #'efs/org-babel-tangle-config)))

(org-babel-do-load-languages
       'org-babel-load-languages
       '((emacs-lisp . t)
         (python . t)))

(setq org-confirm-babel-evaluate nil)

;; LSP
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(setq lsp-ui-sideline-enable nil)
(setq lsp-ui-sideline-show-hover nil)

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(use-package lsp-treemacs
  :after lsp)

;; Optional, but recommended for extra LSP UI goodies like code lenses, docs, etc.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package lsp-ivy)

(use-package zig-mode
      :ensure t
      :hook (zig-mode . lsp-deferred)   ;; Automatically start LSP in zig-mode
      :config
      ;; If "zls" is not on your PATH, specify its path here:
      ;(setq lsp-zig-zls-executable "/path/to/zls")
      )

       ;; markdown
    (use-package markdown-mode
      :ensure t
      :mode ("README\\.md\\'" . gfm-mode)
      :init (setq markdown-command "multimarkdown")
      :bind (:map markdown-mode-map
             ("C-c C-e" . markdown-do)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-line-numbers 'relative)
 '(display-line-numbers-type 'relative)
 '(global-display-line-numbers-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(all-the-icons cape command-log-mode company company-box
		   counsel-projectile doom-modeline doom-themes
		   emacs-neotree evil-collection evil-nerd-commenter
		   evil-org helpful ivy-rich lsp-ivy lsp-mode
		   lsp-treemacs lsp-ui neotree org-bullets org-roam
		   rainbow-delimiters zig-mode))
 '(scroll-conservatively 101)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "FiraCode Nerd Font Mono" :foundry "outline" :slant normal :weight regular :height 110 :width normal)))))

;; (use-package rpgtk
;; :straight (rpgtk :type git :host github :repo "howardabrams/emacs-rpgtk")
;; ;; :config
;; ;;   (your config here)
;; )
