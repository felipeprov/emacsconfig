

(require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;;i must install all packages i like
(setq package-list '(
                     ac-c-headers
                     ac-etags
                     airline-themes
                     async
                     auctex
                     auto-complete
                     bind-key
                     c-eldoc
                     cmake-ide
                     color-moccur
                     company
                     company-auctex
                     company-c-headers
                     ctags
                     ctags-update
                     dash
                     dash-at-point
                     dash-functional
                     diminish
                     epl
                     epl
                     flx
                     flx-ido
                     ggtags
                     git-commit
                     git-commit
                     helm
                     helm-c-moccur
                     helm-c-yasnippet
                     helm-core
                     helm-dash
                     helm-gtags
                     helm-projectile
                     levenshtein
                     magit
                     magit-gitflow
                     magit-popup
                     markdown-mode
                     org
                     org-dashboard
                     pkg-info
                     popup
                     powerline
                     project-root
                     projectile
                     seq
                     sr-speedbar
                     use-package
                     with-editor
                     yasnippet ))

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'helm)
(require 'helm-config)

(helm-mode 1)

(require 'powerline)
(powerline-default-theme)

(require 'airline-themes)
(require 'yasnippet)
(yas-global-mode 1)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(load-theme 'misterioso)
(load-theme 'airline-dark t)

(projectile-global-mode)

(setq org-agenda-files (quote ("~/Dropbox/vida")))

                                        ;(require 'company)
;(require 'ac-config-default)
;(ac-etags-setup)
;(add-to-list 'company-backends 'company-irony)

;(add-hook 'c++-mode-hook 'irony-mode)
;(add-hook 'c-mode-hook 'irony-mode)
;(add-hook 'objc-mode-hook 'irony-mode)

; replace the `completion-at-point' and `complete-symbol' bindings in
; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
;(add-hook 'irony-mode-hook 'my-irony-mode-hook)
;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 3)

;solving airline visualization problems
(setq airline-utf-glyph-separator-left      #xe0b0
      airline-utf-glyph-separator-right     #xe0b2
      airline-utf-glyph-subseparator-left   #xe0b1
      airline-utf-glyph-subseparator-right  #xe0b3
      airline-utf-glyph-branch              #xe0a0
      airline-utf-glyph-readonly            #xe0a2
      airline-utf-glyph-linenumber          #xe0a1)

;enable autocompletion
(add-hook 'after-init-hook 'global-company-mode)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;(when executable-find "curl")
;  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(setq w32-pipe-read-delay 0)

;(require 'helm-gtags)
;; Enable helm-gtags-mode
;(add-hook 'dired-mode-hook 'helm-gtags-mode)
;(add-hook 'eshell-mode-hook 'helm-gtags-mode)
;(add-hook 'c-mode-hook 'helm-gtags-mode)
;(add-hook 'c++-mode-hook 'helm-gtags-mode)
;(add-hook 'asm-mode-hook 'helm-gtags-mode)

;(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
;(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
;(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
;(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
;(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
;(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "fbcdb6b7890d0ec1708fa21ab08eb0cc16a8b7611bb6517b722eba3891dfc9dd" "51277c9add74612c7624a276e1ee3c7d89b2f38b1609eed6759965f9d4254369" "2a5be663818e1e23fd2175cc8dac8a2015dcde6b2e07536712451b14658bbf68" "8e7ca85479dab486e15e0119f2948ba7ffcaa0ef161b3facb8103fb06f93b428" "532769a638787d1196bc22c885e9b85269c3fc650fdecfc45135bb618127034c" "6998bd3671091820a6930b52aab30b776faea41449b4246fdce14079b3e7d125" "133222702a3c75d16ea9c50743f66b987a7209fb8b964f2c0938a816a83379a0" "878e22a7fe00ca4faba87b4f16bc269b8d2be5409d1c513bb7eda025da7c1cf4" default)))
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("c:/Users/Felipe/Dropbox/vida/")))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Droid Sans Mono Dotted for Powe" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))


(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-directory "~/Dropbox/vida")
(setq org-default-notes-file "~/Dropbox/vida/refile.org")
;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)


;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Dropbox/vida/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/Dropbox/vida/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/Dropbox/vida/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/Dropbox/vida/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/Dropbox/vida/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/Dropbox/vida/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/Dropbox/vida/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/Dropbox/vida/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

(setq org-hierarchical-todo-statistics nil)

;; (setq org-todo-state-tags-triggers
;;       (quote (("CANCELLED" ("CANCELLED" . t))
;;               ("WAITING" ("WAITING" . t))
;;               ("HOLD" ("WAITING") ("HOLD" . t))
;;               (done ("WAITING") ("HOLD"))
;;               ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
;;               ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
;;               ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))


;; ; Targets include this file and any file contributing to the agenda - up to 9 levels deep
 (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                  (org-agenda-files :maxlevel . 9))))

;; ; Use full outline paths for refile targets - we file directly with IDO
 (setq org-refile-use-outline-path t)

;; ; Targets complete directly with IDO
 (setq org-outline-path-complete-in-steps nil)

;; ; Allow refile to create parent tasks with confirmation
 (setq org-refile-allow-creating-parent-nodes (quote confirm))

 ; Use IDO for both buffer and file completion and ido-everywhere to t
 (setq org-completion-use-ido t)
 (setq ido-everywhere t)
 (setq ido-max-directory-size 100000)
 (ido-mode (quote both))
 ; Use the current window when visiting files and buffers with ido
 (setq ido-default-file-method 'selected-window)
 (setq ido-default-buffer-method 'selected-window)
 ; Use the current window for indirect buffer display
 (setq org-indirect-buffer-display 'current-window)

;; ;;;; Refile settings
;; ; Exclude DONE state tasks from refile targets
;; (defun bh/verify-refile-target ()
;;   "Exclude todo keywords with a done state from refile targets"
;;   (not (member (nth 2 (org-heading-components)) org-done-keywords)))

;; (setq org-refile-target-verify-function 'bh/verify-refile-target)

;; ;; Do not dim blocked tasks
;; (setq org-agenda-dim-blocked-tasks nil)

;; ;; Compact the block agenda view
;; (setq org-agenda-compact-blocks t)

;; (require 'org-habit)

;; ;; Custom agenda command definitions
;; (setq org-agenda-custom-commands
;;       (quote (("N" "Notes" tags "NOTE"
;;                ((org-agenda-overriding-header "Notes")
;;                 (org-tags-match-list-sublevels t)))
;;               ("h" "Habits" tags-todo "STYLE=\"habit\""
;;                ((org-agenda-overriding-header "Habits")
;;                 (org-agenda-sorting-strategy
;;                  '(todo-state-down effort-up category-keep))))
;;               (" " "Agenda"
;;                ((agenda "" nil)
;;                 (tags "REFILE"
;;                       ((org-agenda-overriding-header "Tasks to Refile")
;;                        (org-tags-match-list-sublevels nil)))
;;                 (tags-todo "-CANCELLED/!"
;;                            ((org-agenda-overriding-header "Stuck Projects")
;;                             (org-agenda-skip-function 'bh/skip-non-stuck-projects)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-HOLD-CANCELLED/!"
;;                            ((org-agenda-overriding-header "Projects")
;;                             (org-agenda-skip-function 'bh/skip-non-projects)
;;                             (org-tags-match-list-sublevels 'indented)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-CANCELLED/!NEXT"
;;                            ((org-agenda-overriding-header (concat "Project Next Tasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
;;                             (org-tags-match-list-sublevels t)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-sorting-strategy
;;                              '(todo-state-down effort-up category-keep))))
;;                 (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
;;                            ((org-agenda-overriding-header (concat "Project Subtasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-non-project-tasks)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
;;                            ((org-agenda-overriding-header (concat "Standalone Tasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-project-tasks)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-CANCELLED+WAITING|HOLD/!"
;;                            ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-non-tasks)
;;                             (org-tags-match-list-sublevels nil)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
;;                 (tags-todo "bug"
;;                       ((org-agenda-overriding-header "Bugs")
;;                        (org-agenda-skip-function 'bh/skip-non-tasks)
;;                        (org-agenda-skip-entry-if 'done)
;;                       ))
;;                 (tags "-REFILE/"
;;                       ((org-agenda-overriding-header "Tasks to Archive")
;;                        (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
;;                        (org-tags-match-list-sublevels nil))))
;;                nil))))

;; (defun bh/skip-non-archivable-tasks ()
;;   "Skip trees that are not available for archiving"
;;   (save-restriction
;;     (widen)
;;     ;; Consider only tasks with done todo headings as archivable candidates
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
;;           (subtree-end (save-excursion (org-end-of-subtree t))))
;;       (if (member (org-get-todo-state) org-todo-keywords-1)
;;           (if (member (org-get-todo-state) org-done-keywords)
;;               (let* ((daynr (string-to-int (format-time-string "%d" (current-time))))
;;                      (a-month-ago (* 60 60 24 (+ daynr 1)))
;;                      (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
;;                      (this-month (format-time-string "%Y-%m-" (current-time)))
;;                      (subtree-is-current (save-excursion
;;                                            (forward-line 1)
;;                                            (and (< (point) subtree-end)
;;                                                 (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
;;                 (if subtree-is-current
;;                     subtree-end ; Has a date in this month or last month, skip it
;;                   nil))  ; available to archive
;;             (or subtree-end (point-max)))
;;         next-headline))))

;; (defun bh/is-project-p ()
;;   "Any task with a todo keyword subtask"
;;   (save-restriction
;;     (widen)
;;     (let ((has-subtask)
;;           (subtree-end (save-excursion (org-end-of-subtree t)))
;;           (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;       (save-excursion
;;         (forward-line 1)
;;         (while (and (not has-subtask)
;;                     (< (point) subtree-end)
;;                     (re-search-forward "^\*+ " subtree-end t))
;;           (when (member (org-get-todo-state) org-todo-keywords-1)
;;             (setq has-subtask t))))
;;       (and is-a-task has-subtask))))

;; (defun bh/is-project-subtree-p ()
;;   "Any task with a todo keyword that is in a project subtree.
;; Callers of this function already widen the buffer view."
;;   (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
;;                               (point))))
;;     (save-excursion
;;       (bh/find-project-task)
;;       (if (equal (point) task)
;;           nil
;;         t))))

;; (defun bh/is-task-p ()
;;   "Any task with a todo keyword and no subtask"
;;   (save-restriction
;;     (widen)
;;     (let ((has-subtask)
;;           (subtree-end (save-excursion (org-end-of-subtree t)))
;;           (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;       (save-excursion
;;         (forward-line 1)
;;         (while (and (not has-subtask)
;;                     (< (point) subtree-end)
;;                     (re-search-forward "^\*+ " subtree-end t))
;;           (when (member (org-get-todo-state) org-todo-keywords-1)
;;             (setq has-subtask t))))
;;       (and is-a-task (not has-subtask)))))

;; (defun bh/is-subproject-p ()
;;   "Any task which is a subtask of another project"
;;   (let ((is-subproject)
;;         (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;     (save-excursion
;;       (while (and (not is-subproject) (org-up-heading-safe))
;;         (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;           (setq is-subproject t))))
;;     (and is-a-task is-subproject)))

;; (defun bh/list-sublevels-for-projects-indented ()
;;   "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
;;   This is normally used by skipping functions where this variable is already local to the agenda."
;;   (if (marker-buffer org-agenda-restrict-begin)
;;       (setq org-tags-match-list-sublevels 'indented)
;;     (setq org-tags-match-list-sublevels nil))
;;   nil)

;; (defun bh/list-sublevels-for-projects ()
;;   "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
;;   This is normally used by skipping functions where this variable is already local to the agenda."
;;   (if (marker-buffer org-agenda-restrict-begin)
;;       (setq org-tags-match-list-sublevels t)
;;     (setq org-tags-match-list-sublevels nil))
;;   nil)

;; (defvar bh/hide-scheduled-and-waiting-next-tasks t)

;; (defun bh/toggle-next-task-display ()
;;   (interactive)
;;   (setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
;;   (when  (equal major-mode 'org-agenda-mode)
;;     (org-agenda-redo))
;;   (message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))

;; (defun bh/skip-stuck-projects ()
;;   "Skip trees that are not stuck projects"
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (if (bh/is-project-p)
;;           (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;                  (has-next ))
;;             (save-excursion
;;               (forward-line 1)
;;               (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
;;                 (unless (member "WAITING" (org-get-tags-at))
;;                   (setq has-next t))))
;;             (if has-next
;;                 nil
;;               next-headline)) ; a stuck project, has subtasks but no next task
;;         nil))))

;; (defun bh/skip-non-stuck-projects ()
;;   "Skip trees that are not stuck projects"
;;   ;; (bh/list-sublevels-for-projects-indented)
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (if (bh/is-project-p)
;;           (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;                  (has-next ))
;;             (save-excursion
;;               (forward-line 1)
;;               (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
;;                 (unless (member "WAITING" (org-get-tags-at))
;;                   (setq has-next t))))
;;             (if has-next
;;                 next-headline
;;               nil)) ; a stuck project, has subtasks but no next task
;;         next-headline))))

;; (defun bh/skip-non-projects ()
;;   "Skip trees that are not projects"
;;   ;; (bh/list-sublevels-for-projects-indented)
;;   (if (save-excursion (bh/skip-non-stuck-projects))
;;       (save-restriction
;;         (widen)
;;         (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;           (cond
;;            ((bh/is-project-p)
;;             nil)
;;            ((and (bh/is-project-subtree-p) (not (bh/is-task-p)))
;;             nil)
;;            (t
;;             subtree-end))))
;;     (save-excursion (org-end-of-subtree t))))

;; (defun bh/skip-non-tasks ()
;;   "Show non-project tasks.
;; Skip project and sub-project tasks, habits, and project related tasks."
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (cond
;;        ((bh/is-task-p)
;;         nil)
;;        (t
;;         next-headline)))))

;; (defun bh/skip-project-trees-and-habits ()
;;   "Skip trees that are projects"
;;   (save-restriction
;;     (widen)
;;     (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;       (cond
;;        ((bh/is-project-p)
;;         subtree-end)
;;        ((org-is-habit-p)
;;         subtree-end)
;;        (t
;;         nil)))))

;; (defun bh/skip-projects-and-habits-and-single-tasks ()
;;   "Skip trees that are projects, tasks that are habits, single non-project tasks"
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (cond
;;        ((org-is-habit-p)
;;         next-headline)
;;        ((and bh/hide-scheduled-and-waiting-next-tasks
;;              (member "WAITING" (org-get-tags-at)))
;;         next-headline)
;;        ((bh/is-project-p)
;;         next-headline)
;;        ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
;;         next-headline)
;;        (t
;;         nil)))))

;; (defun bh/skip-project-tasks-maybe ()
;;   "Show tasks related to the current restriction.
;; When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
;; When not restricted, skip project and sub-project tasks, habits, and project related tasks."
;;   (save-restriction
;;     (widen)
;;     (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;            (next-headline (save-excursion (or (outline-next-heading) (point-max))))
;;            (limit-to-project (marker-buffer org-agenda-restrict-begin)))
;;       (cond
;;        ((bh/is-project-p)
;;         next-headline)
;;        ((org-is-habit-p)
;;         subtree-end)
;;        ((and (not limit-to-project)
;;              (bh/is-project-subtree-p))
;;         subtree-end)
;;        ((and limit-to-project
;;              (bh/is-project-subtree-p)
;;              (member (org-get-todo-state) (list "NEXT")))
;;         subtree-end)
;;        (t
;;         nil)))))

;; (defun bh/skip-project-tasks ()
;;   "Show non-project tasks.
;; Skip project and sub-project tasks, habits, and project related tasks."
;;   (save-restriction
;;     (widen)
;;     (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
;;       (cond
;;        ((bh/is-project-p)
;;         subtree-end)
;;        ((org-is-habit-p)
;;         subtree-end)
;;        ((bh/is-project-subtree-p)
;;         subtree-end)
;;        (t
;;         nil)))))

;; (defun bh/skip-non-project-tasks ()
;;   "Show project tasks.
;; Skip project and sub-project tasks, habits, and loose non-project tasks."
;;   (save-restriction
;;     (widen)
;;     (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;            (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (cond
;;        ((bh/is-project-p)
;;         next-headline)
;;        ((org-is-habit-p)
;;         subtree-end)
;;        ((and (bh/is-project-subtree-p)
;;              (member (org-get-todo-state) (list "NEXT")))
;;         subtree-end)
;;        ((not (bh/is-project-subtree-p))
;;         subtree-end)
;;        (t
;;         nil)))))

;; (defun bh/skip-projects-and-habits ()
;;   "Skip trees that are projects and tasks that are habits"
;;   (save-restriction
;;     (widen)
;;     (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;       (cond
;;        ((bh/is-project-p)
;;         subtree-end)
;;        ((org-is-habit-p)
;;         subtree-end)
;;        (t
;;         nil)))))

;; (defun bh/find-project-task ()
;;   "Move point to the parent (project) task if any"
;;   (save-restriction
;;     (widen)
;;     (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
;;       (while (org-up-heading-safe)
;;         (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;           (setq parent-task (point))))
;;       (goto-char parent-task)
;;       parent-task)))

;; (defun bh/skip-non-subprojects ()
;;   "Skip trees that are not projects"
;;   (let ((next-headline (save-excursion (outline-next-heading))))
;;     (if (bh/is-subproject-p)
;;         nil
;;       next-headline)))

;; ;; Agenda clock report parameters
 (setq org-agenda-clockreport-parameter-plist
       (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))

;; ; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%60ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM %20TAGS")

 (setq org-global-properties (quote (("Effort_ALL" . "1:00 2:00 4:00 1d 2d 3d 5d 6d 7d")
                                     ("STYLE_ALL" . "habit"))))

;; ;; Agenda log mode items to display (closed and state changes by default)
;; ;(setq org-agenda-log-mode-items (quote (closed state)))

;; ;(setq org-agenda-span 'day)

(setq org-time-clocksum-use-effort-durations t)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)"  "CANCELED(c)")
              (sequence "TASK(f)" "|" "DONE(d)")
              (sequence "BUG(b)" "TESTING(t)" "|" "DONE(d)")
              (sequence "DOC(D)" "REVIEW(r)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "chocolate" :weight bold)
              ("BUG" :foreground "yellow" :weight bold)
              ("DOC" :foreground "dark goldenrod" :weight bold)
              ("TESTING" :foreground "sea green" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

(setq org-tags-exclude-from-inheritance '("prj")
      org-stuck-projects '("+prj/-MAYBE-DONE"
                           ("TODO" "TASK") ()))

(setq org-agenda-custom-commands
      '(("h" "Work todos" tags-todo
         "-personal-doat={.+}-dowith={.+}/!-TASK"
         ((org-agenda-todo-ignore-scheduled t)))
        ("H" "All work todos" tags-todo "-personal/!-TASK-MAYBE"
         ((org-agenda-todo-ignore-scheduled nil)))
        ("A" "Work todos with doat or dowith" tags-todo
         "-personal+doat={.+}|dowith={.+}/!-TASK"
         ((org-agenda-todo-ignore-scheduled nil)))
        ("j" "TODO dowith and TASK with"
         ((org-sec-with-view "TODO dowith")
          (org-sec-where-view "TODO doat")
          (org-sec-assigned-with-view "TASK with")
          (org-sec-testing-with-view "TESTING with")
          (org-sec-stuck-with-view "STUCK with")))
        ("J" "Interactive TODO dowith and TASK with"
         ((org-sec-who-view "TODO dowith")))))


(defvar org-sec-with "nobody"
  "Value of the :with: property when doing an
   org-sec-tag-entry. Change it with org-sec-set-with,
   set to C-c w")

(defvar org-sec-where ""
  "Value of the :at: property when doing an
   org-sec-tag-entry. Change it with org-sec-set-with,
   set to C-c W")

(defvar org-sec-with-history '()
  "History list of :with: properties")

(defvar org-sec-where-history '()
  "History list of :where: properties")

(defun org-sec-set-with ()
  "Changes the value of the org-sec-with variable for use
   in the next call of org-sec-tag-entry."
  (interactive)
  (setq org-sec-with (read-string "With: " nil
                                  'org-sec-with-history "")))
(global-set-key "\C-cw" 'org-sec-set-with)

(defun org-sec-set-where ()
  "Changes the value of the org-sec-where variable for use
   in the next call of org-sec-tag-entry."
  (interactive)
  (setq org-sec-where
        (read-string "Where: " nil
                     'org-sec-where-history "")))
(global-set-key "\C-cW" 'org-sec-set-where)

(defun org-sec-set-dowith ()
  "Sets the value of the dowith property."
  (interactive)
  (let ((do-with
         (read-string "Do with: "
                      nil 'org-sec-dowith-history "")))
    (unless (string= do-with "")
      (org-entry-put nil "dowith" do-with))))
(global-set-key "\C-cd" 'org-sec-set-dowith)

(defun org-sec-set-doat ()
  "Sets the value of the doat property."
  (interactive)
  (let ((do-at (read-string "Do at: "
                            nil 'org-sec-doat-history "")))
    (unless (string= do-at "")
      (org-entry-put nil "doat" do-at))))
(global-set-key "\C-cD" 'org-sec-set-doat)

(defun org-sec-tag-entry ()
  "Adds a :with: property with the value of org-sec-with if
   defined, an :at: property with the value of org-sec-where
   if defined, and an :on: property with the current time."
  (interactive)
  (save-excursion
    (org-entry-put nil "on" (format-time-string
                             (org-time-stamp-format 'long)
                             (current-time)))
    (unless (string= org-sec-where "")
      (org-entry-put nil "at" org-sec-where))
    (unless (string= org-sec-with "nobody")
      (org-entry-put nil "with" org-sec-with))))
(global-set-key "\C-cj" 'org-sec-tag-entry)


(defun join (lst sep &optional pre post)
  (mapconcat (function (lambda (x)
                         (concat pre x post)))
             lst sep))

(defun org-sec-with-view (par &optional who)
  "Select tasks marked as dowith=who, where who
   defaults to the value of org-sec-with."
  (org-tags-view '(4) (join (split-string (if who
                                              who
                                            org-sec-with))
                            "|" "dowith=\"" "\"")))

(defun org-sec-where-view (par)
  "Select tasks marked as doat=org-sec-where."
  (org-tags-view '(4) (concat "doat={" org-sec-where "}")))

(defun org-sec-assigned-with-view (par &optional who)
  "Select tasks assigned to who, by default org-sec-with."
  (org-tags-view '(4)
                 (concat (join (split-string (if who
                                                 who
                                               org-sec-with))
                               "|")
                         "/TASK")))

(defun org-sec-testing-with-view (par &optional who)
  "Select tasks assigned to who, by default org-sec-with."
  (org-tags-view '(4)
                 (concat (join (split-string (if who
                                                 who
                                               org-sec-with))
                               "|")
                         "/TESTING|BUG")))

(defun org-sec-stuck-with-view (par &optional who)
  "Select stuck projects assigned to who, by default
   org-sec-with."
  (let ((org-stuck-projects
         `(,(concat "+prj+"
                    (join (split-string (if who
                                            who
                                          org-sec-with)) "|")
                    "/-MAYBE-DONE")
           ("TODO" "TASK") ())))
    (org-agenda-list-stuck-projects)))


(defun org-sec-who-view (par)
  "Builds agenda for a given user.  Queried. "
  (let ((who (read-string "Build todo for user/tag: "
                          "" "" "")))
    (org-sec-with-view "TODO dowith" who)
    (org-sec-assigned-with-view "TASK with" who)
    (org-sec-stuck-with-view "STUCK with" who)))


(require 'ox-latex)

(add-to-list 'org-latex-classes
             '("mxtdoc"
               "\\documentclass[a4paper, 12pt]{template/mxtdoc}
\\usepackage{glossaries}
\\usepackage{smartdiagram}
\\usepackage{enumitem}
\\usepackage{tikz}
\\usetikzlibrary{shapes.geometric, arrows}
\\makeglossaries
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]
"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(setq org-latex-pdf-process 
  '("xelatex -interaction nonstopmode %f"
     "xelatex -interaction nonstopmode %f"))


(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(setq coding-system-for-write 'utf-8)

(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t))
          t)

(add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
(setq ispell-program-name "aspell")
(require 'ispell)
