(defparameter dernier_enr nil)

(defun verifier_ou (but bdF bdR &optional (i 0))
  (if (appartient but bdF) ;; ici on remplacer le member par appartient
      (progn 
        (format t "~V@t But : ~A proof ~%" i but)
        T)
    ;;(let ((regles (regles_candidates but bdR)) (ok nil))
    (let ((regles (reverse (regles_candidates but bdR))) (ok nil))

     (while (and regles (not ok))
       (format t "~% ~V@t VERIFIE_OU ~A Regles ~s :  ~A ~%" i but (numRegle (car regles)) (car regles))
       (setq ok (verifier_et (pop regles) bdF bdR i)))
     ok)
    ))

(defun verifier_et (regle bdF bdR i)
  (let ((ok t) (premisses (premisseRegle regle)))
    (while (and premisses ok)
      (format t "~V@t  ~t VERIFIE_ET ~s premisse ~A~%" (+ 1 i) (numRegle regle) (car premisses))
      (setq dernier_enr (car premisses))
      (setq ok (verifier_ou (pop premisses) bdF bdR (+ 6 i))))
    ok))



;;vérifie si une règle est faisable en fonction de la bdf
(defun verif_regle(regle bdf)
  (let ((premisse (premisseregle regle))
        (verif t))
    (while (and verif premisse)
      (let ((test (pop premisse)))
        (if (not (appartient test bdf))
            (setq verif nil))
        )
      )
    verif))

