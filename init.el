;;初始化包管理器
(require 'package)
(package-initialize)

;;读取配置文件
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-package)
(require 'init-org)
(require 'meow)
(custom-set-faces
 '(default ((t (:family "Sarasa Mono SC" :foundry "outline"
                        :slant normal :weight normal
                        :height 120 :width normal)))))

(global-display-line-numbers-mode t)
;;window-numbering on
(window-numbering-mode t)
;;evil-mode on
(evil-mode 1)
;;set gobal theme
(load-theme 'doom-one t)
;;set undo-tree global
(global-undo-tree-mode)
;;enable company mode
(add-hook 'after-init-hook 'global-company-mode)
;; 启动页图片更改
(setq dashboard-startup-banner "~/.emacs.d/asset/img/yay_evil.png")
;;默认全屏
(add-hook 'emacs-startup-hook 'toggle-frame-maximized)
;;kdb setting 快捷键设置
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c m") 'magit)


(provide 'init.el)
