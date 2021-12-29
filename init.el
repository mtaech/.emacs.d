;;初始化包管理器
(require 'package)
(package-initialize)

;;读取配置文件
(add-to-list 'load-path "~/.emacs.d/lisp")
(require  'init-org)



;;指定国内软件源
(setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("melpa-stable" . "http://mirrors.ustc.edu.cn/elpa/melpa-stable/")
                        ("org" . "http://mirrors.ustc.edu.cn/elpa/org/")))

(custom-set-faces
 '(default ((t (:family "Sarasa Mono SC" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))


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
               window-numbering)))
  (dolist (pkg package-list)
    (eval `(use-package ,pkg))))


(window-numbering-mode t)

;;kdb setting 快捷键设置
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;;默认全屏
(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

(provide 'init.el)
