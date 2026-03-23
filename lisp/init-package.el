;;; init-package.el --- 包管理和核心包配置 -*- lexical-binding: t -*-

;;; Commentary:
;; Emacs 30 已内置 use-package，无需手动安装

;;; Code:

;; ===== 包源设置 =====
(require 'package)

;; 使用清华镜像源
(setq package-archives
      '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
        ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; 初始化包管理
(package-initialize)

;; 刷新包列表（仅在需要时）
(unless package-archive-contents
  (package-refresh-contents))

;; ===== use-package 配置 =====

;; Emacs 29+ 已内置 use-package，无需安装
(require 'use-package)

;; 自动确保所有包已安装
(setq use-package-always-ensure t)

;; 默认使用延迟加载
(setq use-package-always-defer t)

;; 详细加载日志（调试用，稳定后可关闭）
;; (setq use-package-verbose t)

;; ===== 现代补全框架 - Vertico + Consult =====

;; Vertico: 垂直补全界面
(use-package vertico
  :demand t
  :init
  (vertico-mode)
  :custom
  (vertico-count 10)           ; 显示候选数量
  (vertico-resize t)           ; 根据内容调整大小
  (vertico-cycle t))           ; 循环浏览

;; Consult: 增强的搜索和导航命令
(use-package consult
  :bind (("C-s"   . consult-line)           ; 当前缓冲区搜索
         ("C-c s" . consult-ripgrep)        ; 全局搜索
         ("C-c f" . consult-find)           ; 文件查找
         ("C-c b" . consult-buffer)         ; 缓冲区切换
         ("M-y"   . consult-yank-pop)       ; 粘贴历史
         ("M-g g" . consult-goto-line)      ; 跳转到行
         ("M-g m" . consult-mark)           ; 标记导航
         ("M-g i" . consult-imenu)))        ; 大纲导航

;; Orderless: 无序模糊匹配
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

;; Marginalia: 为 minibuffer 补全添加注释
(use-package marginalia
  :init
  (marginalia-mode))

;; Embark: 上下文相关操作
(use-package embark
  :bind (("C-."   . embark-act)             ; 在当前位置执行操作
         ("C-;"   . embark-dwim)            ; 智能执行
         :map minibuffer-local-map
         ("C-c C-o" . embark-export)        ; 导出到 buffer
         ("C-c C-c" . embark-collect)))     ; 收集结果

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; ===== 基础工具 =====

;; Which-key: 显示可用快捷键
(use-package which-key
  :demand t
  :init
  (which-key-mode)
  :custom
  (which-key-idle-delay 0.3)
  (which-key-show-early-on-C-h t)
  (which-key-idle-secondary-delay 0.05))

;; Magit: Git 客户端
(use-package magit
  :bind ("C-c g" . magit)
  :custom
  (magit-display-buffer-function
   #'magit-display-buffer-same-window-except-diff-v1))

;; Vundo: 可视化撤销树 (轻量替代 undo-tree)
(use-package vundo
  :bind ("C-x u" . vundo)
  :custom
  (vundo-glyph-alist vundo-unicode-symbols))

;; Treemacs: 文件树
(use-package treemacs
  :bind (("C-c t" . treemacs)
         :map treemacs-mode-map
         ([mouse-1] . #'treemacs-single-click-expand-action))
  :custom
  (treemacs-width 30)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t))

;; Window numbering: 窗口编号
(use-package window-numbering
  :demand t
  :init
  (window-numbering-mode))

;; Company: 代码补全
(use-package company
  :hook (after-init . global-company-mode)
  :custom
  (company-idle-delay 0.2)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations t))

;; YASnippet: 代码片段
(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :after yasnippet)

;; ===== 主题和外观 =====

;; Gruvbox 主题
(use-package autothemer
  :ensure t)

(use-package gruvbox-theme
  :ensure t
  :after autothemer
  :demand t
  :config
  (load-theme 'gruvbox t))

;; Dashboard: 启动页面
(use-package dashboard
  :demand t
  :after gruvbox-theme  ; 确保主题先加载
  :custom
  (dashboard-startup-banner (expand-file-name "asset/img/yay_evil.png"
                                               user-emacs-directory))
  (dashboard-center-content t)
  (dashboard-show-shortcuts nil)
  ;; 显示 agenda 和任务
  (dashboard-items '((agenda . 5)
                     (recents . 8)
                     (projects . 5)
                     (bookmarks . 3)))
  ;; Agenda 设置
  (dashboard-agenda-sort-strategy '(time-up priority-down))
  (dashboard-agenda-prefix-format "%-12:c %s ")
  :init
  ;; 在包加载前设置启动钩子
  (dashboard-setup-startup-hook)
  :config
  ;; 支持 Evil 模式的 dashboard 导航
  (when (bound-and-true-p evil-mode)
    (evil-define-key 'normal dashboard-mode-map
      (kbd "j") 'dashboard-next-line
      (kbd "k") 'dashboard-previous-line
      (kbd "g") 'dashboard-refresh-buffer
      (kbd "f") 'dashboard-jump-to-bookmarks
      (kbd "r") 'dashboard-jump-to-recents
      (kbd "p") 'dashboard-jump-to-projects
      (kbd "a") 'dashboard-jump-to-agenda
      (kbd "q") 'quit-window)))

;; ===== 输入法 =====

(use-package pyim
  :custom
  (default-input-method "pyim")
  (pyim-default-scheme 'quanpin)
  :config
  (pyim-basedict-enable))

(use-package pyim-basedict)

;; ===== 编程语言支持 =====

(use-package yaml-mode
  :mode ("\\.ya?ml\\'" . yaml-mode))

(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

;; ===== 更好的默认设置 =====

(use-package better-defaults)

;; ===== Org 增强包 =====

;; 更好的 Agenda 分组
(use-package org-super-agenda)

;; Org Roam - 笔记网络
(use-package org-roam
  :after org)

(provide 'init-package)
;;; init-package.el ends here
