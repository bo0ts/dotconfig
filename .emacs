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
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(mediawiki-site-alist (quote (("Wikipedia" "http://en.wikipedia.org/w/" "username" "password" "Main Page") ("CGAL" "https://cgal.geometryfactory.com/CGAL/Members/w/" "Pmoeller" "" "Main Page"))))
 '(org-agenda-files (quote ("~/everything/org/notes.org")))
 '(org-archive-location "~/everything/org/archive.org::From %s")
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
 '(quack-default-program "guile")
 '(quack-dir "~/.quack")
 '(scheme-program-name "guile")
 '(standard-indent 2)
 '(url-max-redirections 30)
 '(yas/prompt-functions (quote (yas/dropdown-prompt yas/ido-prompt yas/completing-prompt))))
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
(require 'mediawiki)

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
;; latex/auctex
;; 

(setq TeX-auto-save nil)
(setq TeX-parse-self t)
(setq require-final-newline nil)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(add-hook 'TeX-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (concat "pdflatex -interaction nonstopmode -file-line-error "
                         (buffer-name)))))

(add-hook 'TeX-mode-hook 'flyspell-mode)
          

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
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

(add-hook 'c++-mode-hook 'flyspell-prog-mode)

;; 
;; yasnippets
;;

(add-to-list 'load-path "/usr/share/emacs/site-lisp/yas")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)

;;
;;org-mode related
;;

(setq org-agenda-custom-commands '(("h" "Daily habits" ((agenda ""))
                                    ((org-agenda-show-log t) (org-agenda-ndays 7)
                                     (org-agenda-log-mode-items '(state))
                                     (org-agenda-skip-function '(org-agenda-skip-entry-if
                                                                 'notregexp ":DAILY:"))
                                     ))
                                   ("d" "Weekly CGAL report" 
                                    ((agenda "" ((org-agenda-span 'week)
                                                 (org-agenda-show-log t)
                                                 (org-agenda-filter-preset '("+cgal"))
                                                 (org-agenda-log-mode-items '(closed))))
                                     ))
                                   ;; others
                                   ))

(defun www-get-page-title (url)
  (interactive "sURL: ")
  (with-current-buffer (url-retrieve-synchronously url)
    (goto-char 0)
    (re-search-forward "<title>\\(.*\\)<[/]title>" nil t 1)
    (match-string 1)))

(require 'org-install)

(setq org-log-done t)
(setq org-hide-leading-stars t)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook 'flyspell-mode)

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation))
(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(setq org-directory "~/everything/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

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

;;
;; emacs disabled
;;

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
