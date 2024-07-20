(defun chainage_avant(bdf but bdr)
  (let ((fin Nil)
        (reglesparcourues nil)
        (conclus nil)
      )
    (while (not fin)
      (setq fin t)
      (dolist (regle bdr)
        (if (and (verif_regle regle bdf) (not (member (numregle regle) reglesparcourues)))
            (progn 
              (setq fin nil)
              (push (numregle regle) reglesparcourues)
              
              (if (not (assoc (cadr (cclregle regle)) bdf))
              (push (list (cadr (cclregle regle))
                          (caddr (cclregle regle))) bdf))
              
              (if (eq (cadr (cclregle regle)) but)
                  (push (cclregle regle)
                        conclus)))
          )
        )
      )
      ;bdf)
    conclus)
  )
