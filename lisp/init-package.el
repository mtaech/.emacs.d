;;指定国内软件源
(setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("melpa-stable" . "http://mirrors.ustc.edu.cn/elpa/melpa-stable/")
                        ("org" . "http://mirrors.ustc.edu.cn/elpa/org/")))

;;安装use-package
(unless (package-installed-p 'use-package)
  ;; 更新本地缓存
  (package-refresh-contents)
  ;; 之后安装它。use-package 应该是你配置中唯一一个需要这样安装的包。
  (package-install 'use-package))

;;使用use-package软件包
(require 'use-package)

;; 让 use-package 永远按需安装软件包
(setq use-package-always-ensure t)

(let ((package-list '(
	       better-defaults
	       magit
	       helm
	       undo-tree
	       treemacs
               yaml-mode
               evil
               doom-themes
               window-numbering
	       treemacs
               org-roam
               )))
  (dolist (pkg package-list)
    (eval `(use-package ,pkg))))
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))



(provide 'init-package)

