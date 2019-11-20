(message "==== Reading configuration from .emacs.el ===")

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(load-theme 'zenburn t)

;;company
(global-company-mode)

(add-to-list 'company-backends '(company-shell company-shell-env company-irony))

;; eliminate long "yes" or "no" prompts
(fset 'yes-or-no-p 'y-or-n-p)
;; Cusom mod configurations
;; turn of the menu bar
(menu-bar-mode -1)
;; turn of the tool bar
(if window-system
    (tool-bar-mode -1) )

