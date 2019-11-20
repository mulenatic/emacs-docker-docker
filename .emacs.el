;;.emacs

;; melpa
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
 ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (qote
    (company-irony irony platformio-mode helm-projectile magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; zenburn theme
(load-theme 'zenburn t)

;; company
(global-company-mode)

;; platformio and irony
(require 'platformio-mode)

;; Add the required company backend
(add-to-list 'company-backends 'company-irony)

;; Enable irony for all c++ files, and platform-io only
;; when needed (platformio.ini present in project root).
(add-hook 'c++-mode-hook (lambda()
			   (irony-mode)
			   (irony-eldoc)
			   (platformio-conditionally-enable)))

;; Use irony's completion functions.
(add-hook 'irony-mode-hook
	  (lambda()
		 (define-key irony-mode-map [remap completion-at-point]
		   'irony-completion-at-point-async)
		 (defind-key irony-mode-map [remap complete-symbol]
		   'irony-completion-at-point-async)

		 (irony-cdb-autosetup-compile-options)))

;; Setup irony for flycheck
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'flycheck-mode-hook 'flycheck-irony-setup)

;; flycheck
global-flycheck-mode)
