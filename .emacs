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
 '(org-agenda-files (quote ("~/everything/org/bdays.org" "~/everything/org/notes.org" "~/everything/uni/studium.org")))
 '(org-archive-location "~/everything/org/archive.org::From %s")
 '(org-time-stamp-rounding-minutes (quote (0 15)))
 '(standard-indent 2)
 '(url-max-redirections 30))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;;
;; setup
;;

(require 'color-theme)
(require 'codepad)

(load "/home/boots/.emacs.d/zenburn.el")
(require 'zenburn)
(zenburn)
(set-fringe-mode 0)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;
;; erc
;;

(require 'erc)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
				"324" "329" "332" "333" "353" "477"))
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(setq erc-kill-buffer-on-part t)
(setq erc-kill-server-buffer-on-quit t)
(setq erc-auto-query 'buffer)

(defun x-urgency-hint (frame arg &optional source)
  (let* ((wm-hints (append (x-window-property 
			    "WM_HINTS" frame "WM_HINTS" 
			    (if source
				source
			      (string-to-number 
			       (frame-parameter frame 'outer-window-id)))
			    nil t) nil))
	 (flags (car wm-hints)))
    (setcar wm-hints
	    (if arg
		(logior flags #x00000100)
	      (logand flags #xFFFFFEFF)))
    (x-change-window-property "WM_HINTS" wm-hints frame "WM_HINTS" 32 t)))

(defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p) 
      (x-urgency-hint (selected-frame) t)
    ;;(setq ad-return-value (intern "erc-current-nick-face")))
    ad-do-it))

(setq erc-autojoin-channels-alist
          '(("freenode.net" "#emacs" "#archlinux" "#haskell" "#xmonad" "##c++")))
;; (erc :server "irc.freenode.net" :port 6667 :nick "bo0ts__")
;; (erc :server "localhost" :port 6667 :nick "boots")


;;
;; haskell
;; 

(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

;;
;; latex
;; 

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq require-final-newline nil)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq latex-block-names '("theorem" "corollary" "proof"))

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
;; org-mode related
;;
(require 'org-install)

(setq org-log-done t)
(setq org-hide-leading-stars t)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-directory "~/everything/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

;;
;; yas related
;;

(add-to-list 'load-path "/usr/share/emacs/site-lisp/yas")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "/usr/share/emacs/site-lisp/yas/snippets")

;;
;; processing related
;;

(require 'processing-mode)
(add-to-list 'load-path "/usr/share/emacs/site-lisp/processing-mode")
(autoload 'processing-mode "processing-mode" "Processing mode" t)
(setq processing-location "/usr/share/processing/")
(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))

