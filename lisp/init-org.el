;;; init-org.el --- Org-mode 增强配置 -*- lexical-binding: t -*-

;;; Commentary:
;; 完整的 Org 写作 + Agenda 管理配置

;;; Code:

;; ===== Org 基础设置 =====

(use-package org
  :ensure nil  ; 使用内置 org
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode)
         (org-mode . variable-pitch-mode))
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         :map org-mode-map
         ("C-c C-," . org-priority)       ; 快速设置优先级
         ("C-c C-t" . org-todo))          ; 快速切换 TODO 状态
  :custom
  ;; 编辑设置
  (org-auto-align-tags nil)
  (org-tags-column 0)
  (org-catch-invisible-edits 'show-and-error)
  (org-special-ctrl-a/e t)
  (org-insert-heading-respect-content t)
  (org-M-RET-may-split-line nil)

  ;; 视觉样式
  (org-hide-emphasis-markers t)
  (org-pretty-entities t)
  (org-ellipsis " ▼")
  (org-pretty-entities-include-sub-superscripts t)
  (org-link-descriptive t)

  ;; 优先级设置
  (org-highest-priority ?A)
  (org-lowest-priority ?D)
  (org-default-priority ?B)

  ;; Todo 设置
  (org-todo-keywords
   '((sequence "TODO(t)" "DOING(i!/@)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELLED(c@)")))
  (org-todo-keyword-faces
   '(("TODO" . (:foreground "#fb4934" :weight bold))
     ("DOING" . (:foreground "#fabd2f" :weight bold))
     ("WAIT" . (:foreground "#d3869b" :weight bold))
     ("DONE" . (:foreground "#b8bb26" :weight bold))
     ("CANCELLED" . (:foreground "#928374" :weight bold))))

  ;; 日志记录
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-log-reschedule 'note)
  (org-log-redeadline 'note)

  ;; 现代列表样式
  (org-list-demote-modify-bullet
   '(("+" . "-") ("*" . "-") ("1." . "a.")))

  ;; 代码块设置
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t)
  (org-src-preserve-indentation t)
  (org-edit-src-content-indentation 0)
  (org-src-window-setup 'current-window)

  ;; 图片显示
  (org-startup-with-inline-images t)
  (org-image-actual-width '(600))

  ;; 自动保存组织文件
  (org-auto-save-org-buffers t))

;; ===== Agenda 配置 =====

(use-package org
  :custom
  ;; Agenda 文件位置
  (org-agenda-files (list (expand-file-name "~/org/")))

  ;; Agenda 视图设置
  (org-agenda-span 'day)           ; 默认显示一天
  (org-agenda-start-on-weekday nil) ; 从当前天开始
  (org-agenda-show-future-repeats 'next) ; 只显示下一次重复
  (org-agenda-window-setup 'current-window) ; 在当前窗口打开
  (org-agenda-restore-windows-after-quit t)

  ;; Agenda 显示格式
  (org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000 2200)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))
  (org-agenda-current-time-string
   "← now ─────────────────────────────────────────────────")
  (org-agenda-block-separator ?─)

  ;; 自定义 Agenda 视图
  (org-agenda-custom-commands
   '(("n" "今日概览"
      ((agenda "" ((org-agenda-span 'day)
                   (org-agenda-start-day "+0d")))
       (todo "DOING" ((org-agenda-overriding-header "进行中任务")))
       (todo "WAIT" ((org-agenda-overriding-header "等待中任务")))
       (todo "TODO" ((org-agenda-overriding-header "待办任务")
                     (org-agenda-max-entries 10)))))

     ("w" "本周计划"
      ((agenda "" ((org-agenda-span 'week)))
       (todo "DOING" ((org-agenda-overriding-header "进行中任务")))
       (todo "WAIT" ((org-agenda-overriding-header "等待中任务")))))

     ("p" "优先级视图"
      ((tags-todo "PRIORITY=\"A\"" ((org-agenda-overriding-header "🔴 高优先级")))
       (tags-todo "PRIORITY=\"B\"" ((org-agenda-overriding-header "🟡 中优先级")))
       (tags-todo "PRIORITY=\"C\"" ((org-agenda-overriding-header "🟢 低优先级")))))))

  ;; 提醒设置
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-skip-timestamp-if-done t)
  (org-deadline-warning-days 3)    ; 截止日期前3天提醒
  (org-scheduled-past-days 7))      ; 显示过去7天的已安排任务

;; ===== Capture 模板 =====

(use-package org
  :custom
  (org-directory "~/org/")
  (org-default-notes-file (expand-file-name "inbox.org" org-directory))

  ;; 快速捕获模板
  (org-capture-templates
   '(;; 快速任务
     ("t" "任务" entry
      (file+headline "~/org/tasks.org" "收件箱")
      "* TODO %^{任务描述}\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%?"
      :empty-lines 1
      :jump-to-captured t)

     ;; 带优先级的任务
     ("p" "优先级任务" entry
      (file+headline "~/org/tasks.org" "收件箱")
      "* TODO [#%^{优先级|B|A|B|C}] %^{任务描述}\nDEADLINE: %^{截止日期}t\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%?"
      :empty-lines 1)

     ;; 笔记
     ("n" "笔记" entry
      (file+datetree "~/org/notes.org")
      "* %^{标题}\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%?"
      :empty-lines 1)

     ;; 会议记录
     ("m" "会议" entry
      (file+datetree "~/org/meetings.org")
      "* %^{会议主题} :meeting:\n:PROPERTIES:\n:CREATED: %U\n:ATTENDEES: %^{参与者}\n:END:\n\n** 议程\n%?\n\n** 讨论要点\n\n** 行动项\n"
      :empty-lines 1)

     ;; 灵感/想法
     ("i" "灵感" entry
      (file+headline "~/org/ideas.org" "灵感池")
      "* %^{标题}\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%?"
      :empty-lines 1)))

  ;; 捕获后处理
  (org-capture-after-finalize-hook nil))

;; ===== Refile 配置 =====

(use-package org
  :custom
  ;; 允许 refile 到任意 heading
  (org-refile-targets '((org-agenda-files :maxlevel . 3)
                        (nil :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-refile-allow-creating-parent-nodes 'confirm))

;; ===== Org Modern =====

(use-package org-modern
  :hook ((org-mode . org-modern-mode)
         (org-agenda-finalize-hook . org-modern-agenda))
  :custom
  (org-modern-hide-stars t)
  (org-modern-table nil)
  (org-modern-list
   '((?+ . "◦")
     (?- . "•")
     (?* . "▸")))
  (org-modern-checkbox
   '((?X . "☑")
     (?- . "◫")
     (?\s . "☐")))
  (org-modern-todo t)
  (org-modern-priority t)
  (org-modern-tag t)
  (org-modern-timestamp t))

;; ===== Super Agenda (增强分组) =====

(use-package org-super-agenda
  :after org
  :config
  (org-super-agenda-mode)
  :custom
  (org-super-agenda-groups
   '((:name "🔴 重要且紧急"
      :priority "A"
      :scheduled today
      :deadline today)

     (:name "⏰ 今天截止"
      :deadline today)

     (:name "📅 已安排今天"
      :scheduled today)

     (:name "⚡ 进行中"
      :todo "DOING")

     (:name "⏳ 等待中"
      :todo "WAIT")

     (:name "📋 待办任务"
      :todo "TODO")

     (:discard (:anything)))))

;; ===== Org Roam (笔记网络) =====

(use-package org-roam
  :custom
  (org-roam-directory (expand-file-name "~/org/roam/"))
  (org-roam-db-location (expand-file-name "~/org/org-roam.db"))
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n g" . org-roam-graph)
         ("C-c n s" . org-roam-db-sync))
  :config
  (org-roam-db-autosync-mode)
  ;; 默认捕获模板
  (setq org-roam-capture-templates
        '(("d" "默认" plain
           "%?"
           :if-new (file+head "${slug}.org" "#+title: ${title}\n#+date: %U\n#+filetags: ")
           :unnarrowed t)

          ("p" "项目" plain
           "* 目标\n\n%?\n\n* 任务\n\n* 笔记"
           :if-new (file+head "projects/${slug}.org" "#+title: ${title}\n#+date: %U\n#+category: project\n#+filetags: :project:")
           :unnarrowed t)

          ("l" "文献" plain
           "* 来源\n\n%?\n\n* 摘要\n\n* 思考"
           :if-new (file+head "literature/${slug}.org" "#+title: ${title}\n#+date: %U\n#+category: literature\n#+filetags: :literature:")
           :unnarrowed t))))

;; ===== Org Download (图片支持) =====

(use-package org-download
  :hook (org-mode . org-download-enable)
  :bind (:map org-mode-map
              ("C-c i s" . org-download-screenshot)
              ("C-c i y" . org-download-yank)
              ("C-c i c" . org-download-clipboard))
  :custom
  (org-download-method 'directory)
  (org-download-image-dir "images")
  (org-download-heading-lvl nil)
  (org-download-screenshot-method "powershell.exe -Command \"& {$screen = [Windows.Forms.Clipboard]::GetImage(); if ($screen) { $screen.Save('%s') }}\""))

;; ===== Org Babel (代码执行) =====

(use-package org
  :config
  ;; 启用 Babel 语言
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t)
     (python . t)
     (js . t)
     (sql . t)
     (dot . t)       ; 图表
     (plantuml . t)  ; UML
     ))

  ;; 不需要每次确认执行
  (setq org-confirm-babel-evaluate nil))

;; ===== 创建必要的目录 =====

(defun org-setup-directories ()
  "创建 Org 工作目录结构。"
  (interactive)
  (let ((dirs '("~/org/"
                "~/org/roam/"
                "~/org/roam/literature/"
                "~/org/roam/projects/")))
    (dolist (dir dirs)
      (unless (file-exists-p (expand-file-name dir))
        (make-directory (expand-file-name dir) t)
        (message "创建目录: %s" dir)))))

;; 启动时自动创建目录
(org-setup-directories)

;; ===== 快捷函数 =====

(defun org-quick-task (task-name)
  "快速创建一个任务。"
  (interactive "s任务名称: ")
  (find-file "~/org/tasks.org")
  (goto-char (point-max))
  (insert (format "\n* TODO %s\n:PROPERTIES:\n:CREATED: %s\n:END:\n"
                  task-name
                  (format-time-string "[%Y-%m-%d %a %H:%M]")))
  (save-buffer)
  (message "已创建任务: %s" task-name))

(defun org-today-agenda ()
  "快速打开今日 Agenda。"
  (interactive)
  (org-agenda nil "n"))

;; 绑定到便捷键
(global-set-key (kbd "C-c o t") #'org-quick-task)
(global-set-key (kbd "C-c o a") #'org-today-agenda)
(global-set-key (kbd "C-c o c") #'org-capture)

(provide 'init-org)
;;; init-org.el ends here
