(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(erc-modules (quote (autojoin button completion fill irccontrols keep-place list match menu move-to-prompt netsplit networks noncommands readonly ring stamp spelling track)))
 '(erc-nickserv-identify-mode (quote nick-change))
 '(erc-play-sound nil)
 '(erc-sound-mode t)
 '(erc-try-new-nick-p nil)
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/everything/org/notes.org")))
 '(org-archive-location "~/everything/org/archive.org::From %s")
 '(quack-default-program "guile")
 '(quack-dir "~/.quack")
 '(scheme-program-name "guile")
 '(standard-indent 2)
 '(url-max-redirections 30))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-hide ((((background dark)) (:foreground "#2b2b2b")))))


;;
;; setup
;;

(add-to-list 'load-path "/home/boots/.emacs.d")

(server-start)

(require 'quack)

(require 'grep-edit)

(require 'color-theme)
(require 'color-theme-zenburn)
(color-theme-zenburn)

(set-fringe-mode 0)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key [f6] 'recompile)

(require 'pastebin)

;;
;; erc
;;

(require 'erc)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
				"324" "329" "332" "333" "353" "477"))
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(setq erc-kill-buffer-on-part t)
(setq erc-kill-server-buffer-on-quit t)

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#archlinux" "#haskell" "#xmonad" "##c++")))
;; (erc :server "irc.freenode.net" :port 6667 :nick "bo0ts__")
;; (erc :server "localhost" :port 6667 :nick "boots")
(setq erc-auto-query 'buffer)

;;
;; latex
;; 

(setq TeX-auto-save nil)
(setq TeX-parse-self t)
(setq require-final-newline nil)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)



;;
;; haskell-related
;;


(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

;;
;; c++
;;

(setq c-default-style "stroustrup"
      c-basic-offset 2)

(defun cplusplus-query (search-string)
  "Search for SEARCH-STRING on cplusplus.com"
  (interactive "sSearch for: ")
  (browse-url (concat "http://www.cplusplus.com/search.do?q="
                      (url-hexify-string
                       (encode-coding-string search-string 'utf-8)))))

(defun sgi-query (search-string)
  "Search for SEARCH-STRING in http://www.sgi.com/tech/stl/ "
  (interactive "sSearch for: ")
  (browse-url (concat "http://www.google.com/search?q=site:http://www.sgi.com/tech/stl/+"
                      (url-hexify-string
                       (encode-coding-string search-string 'utf-8)))))

(add-to-list 'auto-mode-alist '("\\.glsl$" . c-mode))


;; 
;; yasnippets
;;

(add-to-list 'load-path "/usr/share/emacs/site-lisp/yas")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "/usr/share/emacs/site-lisp/yas/snippets")

;;
;;org-mode related
;;

(require 'org-install)

(setq org-log-done t)
(setq org-hide-leading-stars t)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation))
(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(setq org-directory "~/everything/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

;; ;; allow for export=>beamer by placing

;; ;; #+LaTeX_CLASS: beamer in org files
;; (unless (boundp 'org-export-latex-classes)
;;   (setq org-export-latex-classes nil))

;; (add-to-list 'org-export-latex-classes
;;              '("article"
;;                "\\documentclass{article}"
;;                ("\\section{%s}" . "\\section*{%s}")))
;; (add-to-list 'org-export-latex-classes
;;   ;; beamer class, for presentations
;;   '("beamer"
;;      "\\documentclass[11pt]{beamer}\n
;;       \\mode<{{{beamermode}}}>\n
;;       \\usetheme{{{{beamertheme}}}}\n
;;       \\usecolortheme{{{{beamercolortheme}}}}\n
;;       \\beamertemplateballitem\n
;;       \\setbeameroption{show notes}
;;       \\usepackage[utf8]{inputenc}\n
;;       \\usepackage[T1]{fontenc}\n
;;       \\usepackage{hyperref}\n
;;       \\usepackage{color}
;;       \\usepackage{listings}
;;       \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
;;   frame=single,
;;   basicstyle=\\small,
;;   showspaces=false,showstringspaces=false,
;;   showtabs=false,
;;   keywordstyle=\\color{blue}\\bfseries,
;;   commentstyle=\\color{red},
;;   }\n
;;       \\usepackage{verbatim}\n
;;       \\institute{{{{beamerinstitute}}}}\n          
;;        \\subject{{{{beamersubject}}}}\n"

;;      ("\\section{%s}" . "\\section*{%s}")
     
;;      ("\\begin{frame}[fragile]\\frametitle{%s}"
;;        "\\end{frame}"
;;        "\\begin{frame}[fragile]\\frametitle{%s}"
;;        "\\end{frame}")))

;;   ;; letter class, for formal letters

;; (add-to-list 'org-export-latex-classes

;; 	     '("letter"
;;      "\\documentclass[11pt]{letter}\n
;;       \\usepackage[utf8]{inputenc}\n
;;       \\usepackage[T1]{fontenc}\n
;;       \\usepackage{color}"
     
;;      ("\\section{%s}" . "\\section*{%s}")
;;      ("\\subsection{%s}" . "\\subsection*{%s}")
;;      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;      ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
;; 	     '("article"
;; 	       "\\documentclass{article}"
;; 	       ("\\section{%s}" . "\\section*{%s}")))

;;
;; ispell dictionaries
;;

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "deutsch8") "english" "deutsch8")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary)