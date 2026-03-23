;;; init-edit.el --- 编辑行为配置 -*- lexical-binding: t -*-

;;; Commentary:
;; 编辑体验和快捷键设置

;;; Code:

;; ===== 基础编辑设置 =====

;; 使用空格代替制表符
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; 自动换行
(global-visual-line-mode t)

;; 自动括号匹配
(electric-pair-mode t)

;; 自动保存
(setq auto-save-default t)
(setq auto-save-interval 300)
(setq auto-save-timeout 30)

;; 备份文件设置
(setq backup-directory-alist
      `((".*" . ,(expand-file-name "backups" user-emacs-directory))))
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
(setq version-control t)

;; 自动恢复光标位置
(save-place-mode t)

;; 最近文件
(recentf-mode t)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 100)

;; 删除选区时替换
(delete-selection-mode t)

;; 在括号间跳转
(global-set-key (kbd "C-c j") #'xref-find-definitions)
(global-set-key (kbd "C-c b") #'xref-go-back)

;; ===== 快捷键设置 =====

;; Org-mode 相关
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; 注释/取消注释
(global-set-key (kbd "C-c d") #'comment-line)

;; 快速打开配置文件
(defun open-init-file ()
  "打开 Emacs 配置文件。"
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))
(global-set-key (kbd "C-c e") #'open-init-file)

;; 重新加载配置
(defun reload-init-file ()
  "重新加载 Emacs 配置。"
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))
(global-set-key (kbd "C-c r") #'reload-init-file)

;; ===== 搜索和替换 =====

;; Isearch 设置
(setq search-highlight t)
(setq query-replace-highlight t)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq lazy-count-suffix-format nil)

;; 使用正则搜索
(global-set-key (kbd "C-M-s") #'isearch-forward-regexp)
(global-set-key (kbd "C-M-r") #'isearch-backward-regexp)

;; ===== Dired 设置 =====

;; Dired 重用缓冲区
(setq dired-kill-when-opening-new-dired-buffer t)

;; 递归复制/删除
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'top)

;; Dired 中显示 human-readable 大小
(setq dired-listing-switches "-alh")

;; ===== 性能优化 =====

;; 大文件警告阈值
(setq large-file-warning-threshold (* 50 1024 1024))  ; 50MB

;; 长行优化
(global-so-long-mode t)

(provide 'init-edit)
;;; init-edit.el ends here
