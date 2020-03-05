(princ "\nLaunching Ezlisp\n")
(vl-load-com)
;; (alloc 5460)
;; (expand 10)

(defun import (x / catchit)
  (setq catchit (vl-catch-all-apply 'load (list x)))
  (if (and 
       (vl-catch-all-error-p catchit)
       (not (vl-string-search "/" x))
       )
      (load (strcat x "/" x))
      (if (vl-catch-all-error-p catchit) 
        (princ (vl-catch-all-error-message catchit))
       )
   )
  (princ)
  )


(defun install (x)
  (startapp (strcat "ez.exe install " x))
  (princ)
 )

(defun uninstall (x)
  (startapp (strcat "ez.exe uninstall " x))
  (princ)
 )

(defun c:tt ()
  (foreach i __testing_mods__
           (altest i))
  )

(defun c:ll ()
  (foreach i __loaded_mods__ (import i))
  (foreach i __testing_mods__ (import i))
  )

(defun c:ttt ()
  (c:ll)
  (c:tt)
  )

(import "packages/loaded")
(princ "Ezlisp OK\n")
