;;指定国内软件源
(setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("melpa-stable" . "http://mirrors.ustc.edu.cn/elpa/melpa-stable/")
                        ("org" . "http://mirrors.ustc.edu.cn/elpa/org/")))

;;安装use-package
(unless (package-installed-p 'use-package)
  ;; 更新本地缓存
  (package-refresh-contents)
  (package-install 'use-package))

;;使用use-package软件包
(require 'use-package)

;; 让 use-package 永远按需安装软件包
(setq use-package-always-ensure t)

(use-package better-defaults)
(use-package magit)
(use-package helm)
(use-package undo-tree)
(use-package treemacs)
(use-package yaml-mode)
(use-package evil)
(use-package doom-themes)
(use-package window-numbering)
(use-package org)
(use-package org-roam)
(use-package dashboard
  :config (dashboard-setup-startup-hook))
(use-package company)
(use-package org-modern)
(use-package pyim
  :custom
  (default-input-method "pyim")
  (pyim-default-scheme 'quanpin))
(use-package pyim-basedict)


(provide 'init-package)

