;;; init-org.el --- Org-mode 配置 -*- lexical-binding: t -*-

;;; Commentary:
;; Org-mode 现代化配置

;;; Code:

;; ===== Org 基础设置 =====

(use-package org
  :ensure nil  ; 使用内置 org
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode))
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :custom
  ;; 编辑设置
  (org-auto-align-tags nil)
  (org-tags-column 0)
  (org-catch-invisible-edits 'show-and-error)
  (org-special-ctrl-a/e t)
  (org-insert-heading-respect-content t)

  ;; 视觉样式
  (org-hide-emphasis-markers t)
  (org-pretty-entities t)
  (org-ellipsis " ▼")
  (org-pretty-entities-include-sub-superscripts t)

  ;; Agenda 样式
  (org-agenda-block-separator ?─)
  (org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))
  (org-agenda-current-time-string
   "← now ─────────────────────────────────────────────────")

  ;; Todo 设置
  (org-todo-keywords
   '((sequence "TODO(t)" "DOING(i)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELLED(c@)")))

  ;; 日志记录
  (org-log-done 'time)
  (org-log-into-drawer t)

  ;; 现代列表样式
  (org-list-demote-modify-bullet
   '(("+" . "-") ("*" . "-") ("1." . "a.")))

  ;; 代码块设置
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t)
  (org-src-preserve-indentation t)
  (org-edit-src-content-indentation 0))

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
     (?\s . "☐"))))

;; ===== Org Download =====

(use-package org-download
  :hook (org-mode . org-download-enable)
  :custom
  (org-download-method 'directory)
  (org-download-image-dir "images")
  (org-download-heading-lvl nil))

(provide 'init-org)
;;; init-org.el ends here
