;;;
;; Copyright (C) 2010 Meteor Liu
;;
;; This code has been released into the Public Domain.
;; You may do whatever you like with it.
;;
;; @file
;; @author Meteor Liu <meteor1113@gmail.com>
;; @date 2010-05-29
;; @URL http://github.com/meteor1113/dotemacs


;; image-load-path
(let* ((dir (file-name-directory (or load-file-name (buffer-file-name))))
       (images-dir (expand-file-name "images" dir)))
  (add-to-list 'image-load-path images-dir))

(setq tool-bar-button-margin 0)
;; (setq auto-resize-tool-bars nil)

(defvar show-bm-tool-bar nil
  "If not nil, while show bm toolbar, else hide bm toolbar.")

(defun toggle-bm-tool-bar ()
  "Toggle bm toolbar show."
  (interactive)
  (setq show-bm-tool-bar (if show-bm-tool-bar nil t)))

;; (tool-bar-add-item "separator" nil 'custom-tool-bar)

;; bookmark
(when (featurep 'bm)
  (tool-bar-add-item "bm-toggle" 'bm-toggle 'bm-toggle
                     :visible 'show-bm-tool-bar)
  (tool-bar-add-item "bm-next" 'bm-next 'bm-next
                     :visible 'show-bm-tool-bar)
  (tool-bar-add-item "bm-previous" 'bm-previous 'bm-previous
                     :visible 'show-bm-tool-bar)
  (tool-bar-add-item "bm-clear" 'bm-remove-all-current-buffer
                     'bm-remove-all-current-buffer
                     :visible 'show-bm-tool-bar))

;; recent-jump
(tool-bar-add-item "recent-backward"'recent-jump-jump-backward
                   'recent-jump-jump-backward
                   :enable '(fboundp 'recent-jump-jump-backward))
(tool-bar-add-item "recent-forward" 'recent-jump-jump-forward
                   'recent-jump-jump-forward
                   :enable '(fboundp 'recent-jump-jump-forward))

;; find/replace
(tool-bar-add-item "find" 'isearch-forward 'isearch-forward)
(tool-bar-add-item "replace" 'query-replace 'query-replace)

;; up/down case
(tool-bar-add-item "upcase" 'upcase-region 'upcase-region)
(tool-bar-add-item "downcase" 'downcase-region 'downcase-region)

;; (tool-bar-add-item "separator" nil 'toggle)

;; linum
(tool-bar-add-item "linum" 'global-linum-mode
                   'global-linum-mode
                   :visible '(fboundp 'global-linum-mode))

;; toggle whitespace-mode
(tool-bar-add-item "whitespace" 'whitespace-mode
                   'whitespace-mode
                   :visible '(fboundp 'whitespace-mode))

;; toggle ecb
(tool-bar-add-item "ecb"
                   (lambda ()
                     (interactive)
                     (if (and (boundp 'ecb-minor-mode) ecb-minor-mode)
                         (ecb-deactivate)
                       (ecb-activate)))
                   'ecb
                   :visible '(fboundp 'ecb-activate))

;; (tool-bar-add-item "separator" nil 'program)

;; semantic jump/back
(tool-bar-add-item "semantic-jump-back" 'semantic-ia-fast-jump-back
                   'semantic-ia-fast-jump-back
                   :visible (fboundp 'semantic-ia-fast-jump-back))
(tool-bar-add-item "semantic-jump" 'semantic-ia-fast-jump
                   'semantic-ia-fast-jump
                   :visible (fboundp 'semantic-ia-fast-jump))

;; compile/debug
(tool-bar-add-item "compile" 'compile 'compile)
(tool-bar-add-item "gdb" 'gdb 'gdb
                   :visible '(memq major-mode '(c++-mode c-mode objc-mode)))

;; toggle h/cpp
(tool-bar-add-item "sourcepair"
                   (lambda ()
                     (interactive)
                     (if (fboundp 'sourcepair-load)
                         (sourcepair-load)
                       (eassist-switch-h-cpp)))
                   'sourcepair
                   :visible '(and (memq major-mode '(c++-mode c-mode objc-mode))
                                  (or (fboundp 'sourcepair-load)
                                      (fboundp 'eassist-switch-h-cpp))))


(provide 'init-toolbar)