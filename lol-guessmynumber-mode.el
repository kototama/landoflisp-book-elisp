(defvar lol-guessmynumber-mode-map nil
  "Local keymap for the lol guess my number mode")

;; set up the mode map
(if lol-guessmynumber-mode-map
    nil
  (setq lol-guessmynumber-mode-map (make-sparse-keymap))
  (define-key lol-guessmynumber-mode-map "p" 'lol-guessmynumber-newgame)
  (define-key lol-guessmynumber-mode-map "s" 'lol-guessmynumber-issmaller)
  (define-key lol-guessmynumber-mode-map "g" 'lol-guessmynumber-isgreater)
  (define-key lol-guessmynumber-mode-map "y" 'lol-guessmynumber-isfound))

(defun lol-guessmynumber-ask
  ()
  (let ((guess (/ (+ lol-guessmynumber-smaller
                     lol-guessmynumber-greater) 2)))
    (setq lol-guessmynumber-guest-number guess)
    (insert (concat "\nIs your number " (number-to-string guess) " (y/s/g/p)? "))))

(defun lol-guessmynumber-showinstructions
  ()
  (interactive)
  (insert "Choose a number between one and hundred in your head.\n")
  (insert "I will try to guess it!\n\n")
  (insert "Commands are y for yes, s for smaller, g for greater and p for play new game.\n"))

(defun lol-guessmynumber-newgame 
  ()
  "Launch a new game."
  (interactive)
  (setq lol-guessmynumber-smaller 1)
  (setq lol-guessmynumber-greater 100)
  (insert "\n")
  (insert "\nNew game!")
  (lol-guessmynumber-ask))

(defun lol-guessmynumber-issmaller
  ()
  (interactive)
  "Indicates to the computer that our number is smaller than the one guessed."
  (setq lol-guessmynumber-greater (1- lol-guessmynumber-guest-number))
  (lol-guessmynumber-ask))

(defun lol-guessmynumber-isgreater
  ()
  (interactive)
  "Indicates to the computer that our number is greater than the one guessed."
  (setq lol-guessmynumber-smaller (1+ lol-guessmynumber-guest-number))
  (lol-guessmynumber-ask))

(defun lol-guessmynumber-isfound
  ()
  (interactive)
  "Indicates to the computer that our number has been found."
  (insert "\nHow great, I found your number!")
  (lol-guessmynumber-newgame))

(defun lol-guessmynumber-mode
  ()
  "Land of Lisp game 'guess my number'.
Available commands:
p: play new game
s: indicates your number is smaller
g: indicates your number is greater
y: yes the number has been found
"
  (interactive)
  (pop-to-buffer "*guessmynumber*" nil)
  (kill-all-local-variables)
  (make-local-variable 'lol-guessmynumber-smaller)
  (make-local-variable 'lol-guessmynumber-greater)
  (make-local-variable 'lol-guessmynumber-guest-number)
  (setq lol-guessmynumber-smaller 1)
  (setq lol-guessmynumber-greater 100)
  (setq major-mode 'lol-guessmynumber-mode)
  (setq mode-name "Guess my number")
  (use-local-map lol-guessmynumber-mode-map)
  (lol-guessmynumber-showinstructions)
  (lol-guessmynumber-newgame))

