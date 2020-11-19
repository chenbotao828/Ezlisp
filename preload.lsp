(princ "\nLaunching Ezlisp\n")
(vl-load-com)
(alloc 5460)
(expand 10)
(setq {func_pos_dict} nil)



(defun import (x / catchit file2func_dict temp)
  (defun file2func_dict(file / str2lst line2func f line idx ret func)
    (defun str2lst ( s d / l lst pos )
      (setq l (1+ (strlen d)))
      (while (setq pos (vl-string-search d s))
             (setq lst (cons (substr s 1 pos) lst)
                   s (substr s (+ pos l))))
      (reverse (cons s lst)))
    (defun line2func (l / ret sl temp)
      (setq ret nil temp nil)
      (setq sl (cdr (str2lst (vl-string-trim "( " l) " ")))
      (while (and sl (not ret))
             (setq temp (car sl)
                   sl (cdr sl))
             (if (/= "" temp)
               (setq ret (vl-string-trim "'" temp))))
      ret) 
    (if (/= 'str (type x))
        nil
        (progn
          (setq f (open (findfile (strcat file ".lsp")) "r")
                idx -1
                ret nil)
          (while (setq line (read-line f))
                 (progn
                   (setq idx (+ 1 idx))
                   (if (= "(DEF" (substr (strcase line) 1 4))
                       (progn
                         (setq func (line2func line))
                         (if func 
                             (setq ret (cons (cons func (cons file idx )) ret )))))))
          ret)))
  (setq catchit (vl-catch-all-apply 'load (list x)))
  (if (and (vl-catch-all-error-p catchit) (not (vl-string-search "/" x)))
      (progn
        (setq x (strcat x "/" x))
        (setq catchit (vl-catch-all-apply 'load (list x)))
        )
      )
  (if (and (= (type x) 'str) (= (type catchit) 'sym))
      ;; (setq {func_pos_dict} (append (file2func_dict x) {func_pos_dict})))
      (progn
        (setq temp (file2func_dict x))
        (if temp
            (setq {func_pos_dict} (append temp {func_pos_dict}))
            )))
  (if (vl-catch-all-error-p catchit) 
      (progn
        (princ (vl-catch-all-error-message catchit))
        (princ "\n")
        )))

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
  (setq {func_pos_dict} nil)
  (foreach i __loaded_mods__ (import i))
  )

(defun c:ttt ()
  (c:ll)
  (c:tt)
  )

(import "packages/loaded")
(princ "Ezlisp OK\n")
(princ)