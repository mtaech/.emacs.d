;;读取配置文件
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-package)
;;(require 'init-org)
(require 'init-config)

(custom-set-faces
 '(default ((t (:family "Sarasa Term SC Nerd" :foundry "outline"
                        :slant normal :weight normal
                        :height 140 :width normal)))))

(global-display-line-numbers-mode t)
;;window-numbering on
(window-numbering-mode t)
;;set gobal theme
(load-theme 'solarized-dark t)
;;set undo-tree global
(global-undo-tree-mode)
;;enable company mode
(add-hook 'after-init-hook 'global-company-mode)
;; 启动页图片更改
(setq dashboard-startup-banner "~/.emacs.d/asset/img/yay_evil.png")
;;启动页内容居中
(setq dashboard-center-content t)
;;默认全屏
(add-hook 'emacs-startup-hook 'toggle-frame-maximized)
(pyim-basedict-enable)
;;kdb setting 快捷键设置
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c m") 'magit)


(provide 'init.el)
