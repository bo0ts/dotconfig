(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(scheme-program-name "guile")
 '(standard-indent 2))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(server-start)

(require 'quack)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(require 'color-theme)
(color-theme-initialize)
(color-theme-shaman)
(set-fringe-mode 0)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(setq TeX-auto-save t)
(setq TeX-parse-self t)

(load "/home/boots/.emacs.d/pastebin.el")

(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))
(put 'narrow-to-region 'disabled nil)

(setq c-default-style "stroustrup"
      c-basic-offset 2)