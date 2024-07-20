(defun chainage-arriere (but bdF bdR &optional (i 0))
  (if (member (list (cadr but) (caddr but)) bdF)
      (progn 
        (format t "~V@t   But : ~A proof ~%" i but)
        T)
    (progn
      ;;(let ((regles (reverse (regles_candidates but bdR))) (sol nil))
      (let ((regles (regles_candidates but bdR)) (sol nil))
      
        (while (and regles (not sol))
          (format t "~%~V@t VERIFIE_OU ~A Regles ~s :  ~A ~%" i but (numRegle (car regles)) (car regles))
          (let ((premisses (premisseRegle (car regles))))
            (setq sol T)
            ;;(format t "premisses ~s~%" premisses)
            (while (and premisses sol)
              (format t "~V@t  ~t VERIFIE_ET premisse ~A~%" (+ 1 i) (car premisses))
              (setq sol (chainage-arriere (pop premisses) bdF bdR (+ 9 i))))
            (if sol 
                  (push (numRegle (car regles)) sol)
                  ))
            (pop regles))
     sol))
    ))