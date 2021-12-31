;;org mode setting org-mode 设置
(setq org-agenda-files '("~/Documents/Docs/agenda/"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Agenda/Todo.org"  "Tasks")
         "* TODO %?\n  %a")
        ("j" "Journal" entry (file+datetree "~/Agenda/Journal.org" "Note")
         "* %U%?\n  %a")
        ("i" "Ideas" entry (file "~/Agenda/Shower_Thought.org" "Shower_Thought")
         "* %U%?\n %a")))







(provide 'init-org)
