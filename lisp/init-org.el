;;org mode setting org-mode 设置
(setq org-agenda-files '("~/Documents/Agenda/"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Documents/Agenda/Todo.org"  "Tasks")
         "* TODO %?\n  %a")
        ("j" "Journal" entry (file+datetree "~/Documents/Agenda/Journal.org" "Note")
         "* %U%?\n  %a")
        ("i" "Ideas" entry (file "~/Documents/Agenda/Shower_Thought.org" "Shower_Thought")
         "* %U%?\n %a")))

;;(setq org-roam-directory (file-truename "~/org-roam"))
;;(org-roam-db-autosync-mode t)






(provide 'init-org)
