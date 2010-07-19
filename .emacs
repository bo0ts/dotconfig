(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(erc-nickserv-identify-mode (quote nick-change))
 '(inhibit-startup-screen t)
 '(standard-indent 2))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(require 'color-theme)
(require 'codepad)

(color-theme-initialize)
(color-theme-gnome2)
(set-fringe-mode 0)

(require 'erc)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
				"324" "329" "332" "333" "353" "477"))
(setq erc-hide-list '("JOIN" "PART" "QUIT"))

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
(erc :server "irc.freenode.net" :port 6667 :nick "bo0ts__")
(erc :server "localhost" :port 6667 :nick "boots")
(setq erc-auto-query 'buffer)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq require-final-newline nil)

(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

(setq latex-block-names '("theorem" "corollary" "proof"))


(setq c-default-style "stroustrup"
      c-basic-offset 2)

(defun cplusplus-query (search-string)
  "Search for SEARCH-STRING on cplusplus.com"
  (interactive "sSearch for: ")
  (browse-url (concat "http://www.cplusplus.com/query/search.cgi?q="
                      (url-hexify-string
                       (encode-coding-string search-string 'utf-8)))))

(defun sgi-query (search-string)
  "Search for SEARCH-STRING in http://www.sgi.com/tech/stl/ "
  (interactive "sSearch for: ")
  (browse-url (concat "http://www.google.com/search?q=site:http://www.sgi.com/tech/stl/+"
                      (url-hexify-string
                       (encode-coding-string search-string 'utf-8)))))


;;(autoload 'markdown-mode "markdown-mode.el"
;;   "Major mode for editing Markdown files" t)
;;(setq auto-mode-alist
;;   (cons '("\\.text" . markdown-mode) auto-mode-alist))
