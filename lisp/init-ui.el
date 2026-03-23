;;; init-ui.el --- UI 配置 -*- lexical-binding: t -*-

;;; Commentary:
;; 界面外观和显示设置

;;; Code:

;; ===== 字体设置 =====
;; 编程字体：Maple Mono (带连字支持)
(when (find-font (font-spec :name "Maple Mono"))
  (set-face-attribute 'default nil
                      :family "Maple Mono"
                      :height 130)
  (set-face-attribute 'fixed-pitch nil
                      :family "Maple Mono")
  ;; 可变宽度字体使用系统默认或指定中文兼容字体
  (set-face-attribute 'variable-pitch nil
                      :family "Maple Mono"))

;; ===== 界面元素 =====

;; 默认最大化
(add-hook 'emacs-startup-hook #'toggle-frame-maximized)

;; 显示行号
(global-display-line-numbers-mode t)
;; 在某些模式下禁用行号
(dolist (mode '(org-mode-hook
                term-mode-hook
                vterm-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; 高亮当前行
(global-hl-line-mode t)

;; 显示列号
(column-number-mode t)

;; 显示时间
(display-time-mode t)
(setq display-time-24hr-format t)
(setq display-time-default-load-average nil)

;; 光标设置
(setq-default cursor-type 'bar)
(blink-cursor-mode -1)

;; 平滑滚动
(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000
      scroll-preserve-screen-position t)

;; 禁用蜂鸣，使用视觉提示
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; ===== 模式栏设置 =====

;; 显示缓冲区大小
(setq size-indication-mode t)

;; 简洁的模式栏
(setq mode-line-compact t)

;; ===== 窗口管理 =====

;; 窗口分割方向偏好
(setq split-width-threshold 120
      split-height-threshold nil)

;; 窗口调整大小
(global-set-key (kbd "S-C-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")  'shrink-window)
(global-set-key (kbd "S-C-<up>")    'enlarge-window)

;; ===== 透明度设置 (可选) =====
;; (set-frame-parameter (selected-frame) 'alpha '(95 . 95))
;; (add-to-list 'default-frame-alist '(alpha . (95 . 95)))

(provide 'init-ui)
;;; init-ui.el ends here
