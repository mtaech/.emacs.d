;;初始化包管理器
(require 'package)
(package-initialize)

;;读取配置文件
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-org)
(require 'init-package)

(custom-set-faces
 '(default ((t (:family "Sarasa Mono SC" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))

(window-numbering-mode t)
(evil-mode 1)
(recentf-mode t)
(setq recentf-max-menu-items 10)
(load-theme 'doom-one t)
;; 启动页图片更改
(setq dashboard-startup-banner "~/.emacs.d/asset/img/yay_evil.png")
;;kdb setting 快捷键设置
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;;默认全屏
(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

(provide 'init.el)
