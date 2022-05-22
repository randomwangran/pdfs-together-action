(require 'ivy)
(require 'icicles-cmd1)

(defun my-insert-action (x)
  (push x impossible-2-have-same-name/pdfs-to-execute))

(defun wr-select-pdf-frames ()
  (interactive)
  (setq impossible-2-have-same-name/pdfs-to-execute nil)
  (let ((candidates (mapcar #'car (icicle-make-window-alist current-prefix-arg))))
    (ivy-read "choice: " candidates
              :action #'my-insert-action)))

(defun wr/pdf-view-next-page-command-together (&optional n)
  (interactive "p")
  (if (eq (derived-mode-p major-mode) 'PDFView)
      (message "Not able to execute from a PDF buffer.")
    (if impossible-2-have-same-name/pdfs-to-execute
      (dolist (buffer impossible-2-have-same-name/pdfs-to-execute)
        (with-current-buffer buffer
          (call-interactively #'pdf-view-next-page-command)))
    (call-interactively #'wr-select-pdf-frames))))

(defun wr/pdf-view-previous-page-command-together (&optional n)
  (interactive "p")
  (if (eq (derived-mode-p major-mode) 'PDFView)
      (message "Not able to execute from a PDF buffer.")
    (if impossible-2-have-same-name/pdfs-to-execute
      (dolist (buffer impossible-2-have-same-name/pdfs-to-execute)
        (with-current-buffer buffer
          (call-interactively #'pdf-view-previous-page-command)))
    (call-interactively #'wr-select-pdf-frames))))

(define-key ivy-minibuffer-map (kbd "C-<SPC>") 'ivy-mark)

(provide 'pdfs-together-action)
