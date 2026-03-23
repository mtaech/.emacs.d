;;; init.el --- Emacs 30 主配置文件 -*- lexical-binding: t -*-

;;; Commentary:
;; 现代化的 Emacs 30 配置

;;; Code:

;; ===== 恢复垃圾回收阈值 =====
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024))  ; 16MB
            (setq gc-cons-percentage 0.1)))

;; ===== 基础设置 =====

;; 添加本地 lisp 目录到加载路径
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; 设置编码
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment 'UTF-8)

;; 加载各个模块
(require 'init-package)
(require 'init-evil)     ; Vim 键绑定（必须在 UI 和 Edit 之前）
(require 'init-ui)
(require 'init-edit)
(require 'init-org)      ; Org-mode 配置
(require 'init-config)   ; 其他配置

;; 加载自定义文件（如果不存在则创建空文件）
(when (file-exists-p custom-file)
  (load custom-file nil t))

(provide 'init)
;;; init.el ends here
