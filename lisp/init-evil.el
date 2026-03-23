;;; init-evil.el --- Evil 模式配置 -*- lexical-binding: t -*-

;;; Commentary:
;; Vim 风格的键绑定和编辑体验

;;; Code:

;; ===== Evil 基础 =====

(use-package evil
  :demand t
  :init
  ;; 在 Evil 加载前设置变量
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)  ; 由 evil-collection 处理
  (setq evil-want-C-u-scroll t)    ; C-u 向上滚动（Vim 风格）
  (setq evil-want-C-d-scroll t)    ; C-d 向下滚动
  (setq evil-want-C-i-jump t)      ; C-i 跳转
  (setq evil-want-Y-yank-to-eol t) ; Y 复制到行尾（与 D 对应）
  (setq evil-want-fine-undo t)     ; 更细粒度的撤销
  (setq evil-undo-system 'undo-redo) ; 使用内置 undo-redo (Emacs 28+)
  :config
  ;; 启用 Evil
  (evil-mode 1)

  ;; 设置默认状态
  (setq evil-default-state 'normal)

  ;; 某些模式使用 Emacs 状态
  (dolist (mode '(dashboard-mode
                  treemacs-mode
                  vterm-mode
                  term-mode
                  eshell-mode
                  help-mode
                  Info-mode
                  dired-mode
                  calc-mode
                  debugger-mode))
    (add-to-list 'evil-emacs-state-modes mode))

  ;; 插入模式下的 Emacs 快捷键
  (define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line)
  (define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-insert-state-map (kbd "C-k") 'kill-line)
  (define-key evil-insert-state-map (kbd "C-w") 'backward-kill-word))

;; ===== Evil Collection =====

(use-package evil-collection
  :after evil
  :config
  ;; 为各种 major mode 添加 Evil 支持
  (evil-collection-init '(buffer-menu
                          calendar
                          comint
                          consult
                          dired
                          docker
                          elisp-mode
                          embark
                          eshell
                          flymake
                          forge
                          git-timemachine
                          grep
                          help
                          ibuffer
                          imenu
                          magit
                          man
                          minibuffer
                          org
                          org-roam
                          outline
                          package-menu
                          project
                          python
                          replace
                          simple
                          tab-bar
                          tablist
                          tar-mode
                          telescope
                          term
                          tetris
                          tooltip
                          treemacs
                          vterm
                          which-key
                          xref)))

;; ===== Evil  surround =====

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

;; ===== Evil 注释 =====

(use-package evil-nerd-commenter
  :after evil
  :config
  (evilnc-default-hotkeys))

;; ===== Leader 键配置 =====

;; 使用 SPC 作为 leader 键（在 Vim 风格中很常见）
(use-package general
  :after evil
  :config
  ;; 定义 leader 键
  (general-create-definer leader-def
    :prefix "SPC"
    :keymaps 'normal)

  ;; 定义 local leader 键（用于模式特定命令）
  (general-create-definer local-leader-def
    :prefix ","
    :keymaps 'normal)

  ;; 全局 leader 绑定
  (leader-def
    "" nil  ; 必须有空字符串占位
    "SPC" '(execute-extended-command :which-key "M-x")
    ":" '(eval-expression :which-key "eval")
    "u" '(universal-argument :which-key "universal")

    ;; 文件操作
    "f" '(:ignore t :which-key "file")
    "ff" '(find-file :which-key "find file")
    "fr" '(consult-recent-file :which-key "recent files")
    "fs" '(save-buffer :which-key "save")
    "fS" '(write-file :which-key "save as")

    ;; 缓冲区
    "b" '(:ignore t :which-key "buffer")
    "bb" '(consult-buffer :which-key "switch buffer")
    "bd" '(kill-this-buffer :which-key "kill buffer")
    "bn" '(next-buffer :which-key "next")
    "bp" '(previous-buffer :which-key "previous")

    ;; 窗口
    "w" '(:ignore t :which-key "window")
    "wh" '(evil-window-left :which-key "left")
    "wj" '(evil-window-down :which-key "down")
    "wk" '(evil-window-up :which-key "up")
    "wl" '(evil-window-right :which-key "right")
    "ws" '(evil-window-split :which-key "split")
    "wv" '(evil-window-vsplit :which-key "vsplit")
    "wd" '(evil-window-delete :which-key "delete")
    "w=" '(balance-windows :which-key "balance")

    ;; 搜索
    "s" '(:ignore t :which-key "search")
    "ss" '(consult-line :which-key "search line")
    "sp" '(consult-ripgrep :which-key "search project")
    "sb" '(consult-line-multi :which-key "search buffers")

    ;; 项目
    "p" '(:ignore t :which-key "project")
    "pp" '(project-switch-project :which-key "switch")
    "pf" '(project-find-file :which-key "find file")
    "ps" '(project-shell :which-key "shell")

    ;; Git
    "g" '(:ignore t :which-key "git")
    "gg" '(magit :which-key "magit")
    "gs" '(magit-status :which-key "status")
    "gb" '(magit-blame :which-key "blame")

    ;; 打开/切换
    "o" '(:ignore t :which-key "open")
    "ot" '(treemacs :which-key "treemacs")
    "oe" '(open-init-file :which-key "init.el")

    ;; Org 模式
    "O" '(:ignore t :which-key "org")
    "Oa" '(org-agenda :which-key "agenda")
    "Oc" '(org-capture :which-key "capture")
    "Ot" '(org-today-agenda :which-key "today")
    "Of" '(org-roam-node-find :which-key "find note")
    "Oi" '(org-roam-node-insert :which-key "insert note")

    ;; 退出
    "q" '(:ignore t :which-key "quit")
    "qq" '(save-buffers-kill-terminal :which-key "quit")
    "qr" '(restart-emacs :which-key "restart")

    ;; 帮助
    "h" '(:ignore t :which-key "help")
    "hk" '(describe-key :which-key "key")
    "hf" '(describe-function :which-key "function")
    "hv" '(describe-variable :which-key "variable")
    "hm" '(describe-mode :which-key "mode"))

  ;; 视觉模式下的 leader 绑定
  (general-define-key
   :states 'visual
   :prefix "SPC"
   "c" '(evilnc-comment-or-uncomment-lines :which-key "comment")))

(provide 'init-evil)
;;; init-evil.el ends here
