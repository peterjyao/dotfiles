;; Start maximized
;; (add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Set initial window size
(if (window-system)
    (set-frame-size (selected-frame) 130 40))

;; Other frame sizes
(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 130))

;; Set font
(custom-set-faces                                                                                    
 '(default ((t (:height 100 :family "Dank Mono")))))

;; Set timestamp format
(setq ls-lisp-format-time-list  '("%Y-%m-%d %H:%M" "%Y-%m-%d %H:%M")
      ls-lisp-use-localized-time-format t)

;; Remove some window stuff
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Shift + arrow keys to switch focus
(windmove-default-keybindings)
(setq org-replace-disputed-keys t)

;; Make shell open in current frame
;; https://emacs.stackexchange.com/a/44846
(add-to-list 'display-buffer-alist
             `(,(regexp-quote "*shell") display-buffer-same-window))
             ;; '("^\\*shell\\*$" . (display-buffer-same-window)))

;; Bind C-tab to other-window
(global-set-key (kbd "<C-tab>") 'other-window)

;; Fix home directory
(when (eq system-type 'windows-nt)
  (setenv "Home" (getenv "UserProfile")))

;; Add to load path for simple libraries
(add-to-list 'load-path "~/AppData/Roaming/.emacs.d/lisp/")

;; Move annoying Custom stuff to its own file
(setq custom-file "~/AppData/Roaming/.emacs.d/custom.el")
(load custom-file)

;; Custom themes
(setq custom-theme-directory "~/.emacs.d/themes")
;; (load-theme 'ayu-grey t)
;; (load-theme 'atom-one-dark t)

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; (package-refresh-contents)

;; evil
;; (unless (package-installed-p 'evil)
;;   (package-install 'evil))
(require 'evil)
(evil-mode 1)
(setq evil-want-fine-undo t)
;; (evil-set-initial-state 'bs-mode 'emacs)

;; dirvish
;; (unless (package-installed-p 'dirvish)
;;   (package-install 'dirvish))
;; (require 'dirvish)

;; ranger
;; (unless (package-installed-p 'ranger)
;;   (package-install 'ranger))
(require 'ranger)
;; (setq ranger-override-dired-mode t)
(setq ranger-show-hidden t)
(setq ranger-show-literal nil)
(setq ranger-dont-show-binary t)
(setq ranger-cleanup-eagerly t)
;; (setq ranger-width-preview 0.5)

;; ess (emacs speaks statistics)
;; (unless (package-installed-p 'ess)
;;   (package-install 'ess))
(require 'ess-r-mode)

;; sunrise
;; (require 'sunrise)
;; (add-to-list 'auto-mode-alist '("\.srvm\'" . sunrise-virtual-mode))

;; base16 theme
;; (unless (package-installed-p 'base16-theme)
;;   (package-install 'base16-theme))
(require 'base16-theme)
(setq base16-highlight-mode-line 'box)
;; Set the cursor color based on the evil state
;; (load-theme 'base16-hardcore t)
;; (load-theme 'base16-onedark t)
;; (load-theme 'base16-materia t)
;; (load-theme 'base16-dracula t)
;; (load-theme 'base16-phd t)
;; (load-theme 'base16-default-dark t)
;; (load-theme 'base16-monokai t)
;; (load-theme 'base16-material t)
(load-theme 'base16-snazzy t)

;; ace-window
;; (unless (package-installed-p 'ace-window)
;;   (package-install 'ace-window))
(require 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?k ?l))
(setq aw-scope 'frame)
(setq aw-dispatch-always 't)
;; (setq aw-ignore-current 't)
(global-set-key (kbd "M-o") 'ace-window)

;; auto-dim-other-buffers
;; (unless (package-installed-p 'auto-dim-other-buffers)
  ;; (package-install 'auto-dim-other-buffers))
(add-hook 'after-init-hook (lambda ()
  (when (fboundp 'auto-dim-other-buffers-mode)
    (auto-dim-other-buffers-mode t))))

;; Start server mode
(server-start)

;; Show line numbers
(global-display-line-numbers-mode)
(setq column-number-mode t)
;; Copy paste with Super C, Super V
;; (require 'simpleclip)
;; (simpleclip-mode 1)

;; move backups to one place
;; (setq backup-directory-alist `(("." . "~/.emacs-backups")))
(defvar BACKDIR (expand-file-name "~/.emacs_backups/"))
(setq backup-directory-alist `((".*" . ,BACKDIR)))
(setq auto-save-file-name-transforms
  (cons `(,(car (car auto-save-file-name-transforms)) 
          ,(concat BACKDIR "\\2") t) auto-save-file-name-transforms))

;; org-mode stuff
(setq org-directory "~/OneDrive - Lonza/notebooks/org-mode")
(setq org-default-notes-file (concat org-directory "/notes/capture.org"))
(global-set-key (kbd "C-c c") #'org-capture)

(defun my/generate-org-note-name ()
  (setq my-org-note--name (read-string "Name: "))
  (setq my-org-note--time (format-time-string "%Y-%m-%d"))
  (expand-file-name (format "%s_%s.org" my-org-note--time my-org-note--name) "~/OneDrive - Lonza/notebooks/org-mode/notes"))

(setq org-capture-templates
  '(("n" "Note" plain 
     (file my/generate-org-note-name)
     "%(format \"#+TITLE: %s\n#+DATE: %s\n\" my-org-note--name my-org-note--time)\n* %?")))

;; File handling for org mode links
;; (setq org-file-apps '("\\.xlsx\\'" . default))
;; (add-to-list 'org-file-apps '("\\.pptx\\'" . default))

(setq org-file-apps
    '(("\\.docx\\'" . default)
      ("\\.xlsx\\'" . default)
      ("\\.pptx\\'" . default)
      ("\\.pdf\\'" . default)
      (auto-mode . emacs)))
(put 'dired-find-alternate-file 'disabled nil)

;; Set pdf viewer
;; (setq doc-view-ghostscript-program "C:/Users/pyao1/scoop/apps/ghostscript/current/bin/gswin64.exe")
(setq doc-view-ghostscript-program "gswin64.exe")

;; Persistent history
(savehist-mode 1)
;; (desktop-save-mode 1)

;; quarto-mode
;; (unless (package-installed-p 'quarto-mode)
;;   (package-install 'quarto-mode))
(require 'quarto-mode)
