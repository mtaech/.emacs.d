;;; early-init.el --- Emacs 30 早期初始化配置 -*- lexical-binding: t -*-

;;; Commentary:
;; 在 GUI 初始化之前执行，用于性能优化和早期设置

;;; Code:

;; ===== 性能优化 =====

;; 禁用启动时的一些耗时操作
(setq package-enable-at-startup nil)  ; 使用 use-package 管理，无需提前加载
(setq frame-inhibit-implied-resize t)  ; 禁止帧隐式调整大小

;; 禁用包签名验证（Windows 下避免 GPG 问题）
(setq package-check-signature nil)

;; 抑制字节编译警告
(setq byte-compile-warnings '(not obsolete))
(setq native-comp-async-report-warnings-errors 'silent)

;; 垃圾回收优化 - 启动时增大阈值，后面恢复正常
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)

;; 禁用启动屏幕、工具栏、滚动条等 UI 元素
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)

;; 禁止启动屏幕和启动消息
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; 窗口系统下的优化
(when (boundp 'w32-get-true-file-attributes)
  (setq w32-get-true-file-attributes nil)
  (setq w32-pipe-read-delay 0)
  (setq w32-pipe-buffer-size (* 64 1024)))

;; 减少绘制延迟
(setq redisplay-dont-pause t)

;; 原生编译优化 (Emacs 28+)
(when (featurep 'native-compile)
  ;; 异步原生编译
  (setq native-comp-jit-compilation t)
  ;; 抑制编译器警告输出
  (setq native-comp-async-report-warnings-errors 'silent)
  ;; 警告缓冲区不要自动弹出
  (setq warning-suppress-types '((comp))))

;; 设置自定义文件位置，避免污染 init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(provide 'early-init)
;;; early-init.el ends here
