;;set default-note-file
(setq org-default-notes-file (concat "~/org-note/orphan_notes.org"))
;;--------------------------------------------------------------------------
;; set pyim
;; ------------------------------------------------------------------------
;;(require 'pyim)
;;(setq default-input-method "pyim")

;;中文的换行
(add-hook 'org-mode-hook
          (lambda () (setq truncate-lines nil)))

;;  image for org-mode first of all install scrot
;; 1. suspend current emacs window
;; 2. call scrot to capture the screen and save as a file in $HOME/.emacs.img/
;; 3. put the png file reference in current buffer, like this:  [[/home/path/.emacs.img/1q2w3e.png]]
(add-hook 'org-mode-hook 'iimage-mode) ; enable iimage-mode for org-mode
(defun my-screenshot ()
  "Take a screenshot into a unique-named file in the current buffer file  directory and insert a link to this file."
  (interactive)
  (setq filename-shortcut
        (concat (make-temp-name
                 (concat "./" "images/")) ".png"))
  (setq filename
        (concat (make-temp-name
                 (concat (file-name-directory (buffer-file-name)) "images/" ) ) ".png"))
  (if (file-accessible-directory-p (concat (file-name-directory (buffer-file-name)) "images/"))
      nil
    (make-directory "images"))
  ;;保存在.emacs.img中
  ;;(setq filename (concat (make-temp-name (concat  (getenv "HOME") "/.emacs.img/" ) ) ".png"))
  (suspend-frame)
  (call-process-shell-command "gnome-screenshot" nil nil nil nil " -a -f" (concat
                                                                           "\"" filename-shortcut "\"" ))
  (insert (concat "[[" filename-shortcut "]]"))
  (org-display-inline-images)
  )
(global-set-key [f12] 'my-screenshot)

;;;---------------------------------------------
;;window-numbering-mode
;;;---------------------------------------------
(require 'window-numbering)
(window-numbering-mode t)
;;;---------------------------------------------
;;linum-mode
;;;---------------------------------------------
(global-linum-mode t)
;;;---------------------------------------------
;;org-mode agenda
;;;---------------------------------------------
;; Collect all .org from my Org directory and subdirs
(load-library "find-lisp")
(setq org-agenda-files (find-lisp-find-files "~/org-note/" "\.org$"))
;; (setq org-agenda-files (list "~/org-note/todo_event.org"
;;                              "~/org-note/todo_home.org"
;;                              "~/org-note/todo_read.org"
;;                              "~/org-note/todo_project.org"
;;                           "~/org-note/paper_notes.org"
;;                              "~/org-note/orphan_notes.org"))



;;;------------------------------------------------
;;;org-mode refile set
;;;-----------------------------------------------
                                        ; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

                                        ; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)
                                        ; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)
                                        ; Allow refile to create parent tasks with confirmation
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

;;;; Refile settings
                                        ; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))
(setq org-refile-target-verify-function 'bh/verify-refile-target)


;;; Add sphinx support to python-mode
(add-hook 'python-mode-hook (lambda ()
                              (require 'sphinx-doc)
                              (sphinx-doc-mode t)))
;;;-----------------------
;;;refile set end
;;;-------------------------

;;;------------------------------------------
;;; deft setting
;;;----------------------------------------
;; 设置匹配文件后缀名
(setq deft-extension "org")

;; 查找文件目录
(setq deft-directory "/home/einhep/org-note/Note")

;; 使用文件名作为标题
(setq deft-use-filename-as-title t)

;; 默认使用正则搜索
(setq deft-incremental-search nil)

;; 设置自动保存时间
(setq deft-auto-save-interval nil)

;;设置deft的递归搜索
(setq deft-recursive t)


;;;---------------------------------
;; 有到辞典的配置
;;;------------------------------------
;; Enable Cache
(setq url-automatic-caching t)

;; Example Key binding
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)

;;;-----------------------
;;; set default latex engine : xelate
;;;-------------------------
(setq Tex-commond-default "XeLaTeX")


(provide 'init-local)
;;;
