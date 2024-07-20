(setq actions '((16 3 2 1) (15 3 2 1) (14 3 2 1) (13 3 2 1)
                (12 3 2 1) (11 3 2 1) (10 3 2 1) (9 3 2 1)
                (8 3 2 1) (7 3 2 1) (6 3 2 1) (5 3 2 1)
                (4 3 2 1) (3 3 2 1) (2 2 1) (1 1))) 

;; fonction qui donne tous les successeurs d'un etat :
(defun successeurs (allumettes actions)
  (cdr (assoc allumettes actions))) 

;; EXPLORE
(defun explore (allumettes actions joueur i)
  (cond
   ((and (eq joueur 'humain) (eq allumettes 0)) nil)
   ((and (eq joueur 'IA) (eq allumettes 0)) t)
    (t (progn
         (let ((sol nil) (coups (successeurs allumettes actions)))
           (while (and coups (not sol))
             (progn
               (format t "~%~V@tJoueur ~s joue ~s allumettes - il reste ~s allumette(s) " i joueur (car coups) (- allumettes (car coups)))
                (setq sol (explore (- allumettes (car coups)) actions (if (eq joueur 'IA) 'humain 'IA) (+ i 3)))
                (if sol
                    (setq sol (car coups)))
               (format t "~%~V@t sol = ~s~%" i sol)
               (pop coups)
               )
             )
           sol))))) 

(defun JeuJoueur (allumettes actions)
  (let ((choix_joueur nil)
        (coups nil))
    (while (not choix_joueur)
      (format t "Rentrer le coups à jouer (il reste ~s allumettes): ~&" allumettes)
      (setq coups (read))
      (setq choix_joueur (member coups (successeurs allumettes actions)))
      )
    coups)
  )

(defun Randomsuccesseurs (actions) 
  (let ((r (random (length actions))))
    ;;(format t "~&~2t Res du random ~s~&" r)
    (nth r actions)))



(defun explore-renf (nb_allumettes actions)
  (let ((IA_coups ) (humain_coups))
    (cond 
     ((= nb_allumettes 0) (dolist (x a_renf actions)
                              (renforcement (car x) (cadr x) actions)
                              )) ;; IA gagne
     ((= nb_allumettes 1) nil) ;; IA perd
     (t 
      (progn
        ;; IA qui joue
            (setq IA_coups (Randomsuccesseurs (successeurs nb_allumettes actions)))
        (format t "L'IA joue ~s ~&" IA_coups)
        (push (list nb_allumettes IA_coups) a_renf)
            (setq nb_allumettes (- nb_allumettes IA_coups))
        ;; humain qui joue
        (if (> nb_allumettes 0)
            (progn
            (setq humain_coups (JeuJoueur nb_allumettes actions))
              (setq nb_allumettes (- nb_allumettes humain_coups))
            (explore-renf nb_allumettes actions)
              )
          (explore-renf 1 actions))
            )
        ))
    ))

(defun explore-renf-rec (nb_allumettes actions)
  (defparameter a_renf nil)
    (explore-renf nb_allumettes actions))
  
(defun renforcement (allumettes coup actions)
  (setf (cdr (assoc allumettes actions))
    (nconc (cdr(assoc allumettes actions)) (list coup))))

(defun explore-renfD (nb_allumettes actions)
  (let ((IA_coups ) (humain_coups))
    (cond 
     ((= nb_allumettes 0) actions) ;; IA gagne
     ((= nb_allumettes 1) nil) ;; IA perd
     (t 
      (progn
        ;; IA qui joue
            (setq IA_coups (Randomsuccesseurs (successeurs nb_allumettes actions)))
        (format t "L'IA joue ~s ~&" IA_coups)
        (setq dernier_coup (list nb_allumettes IA_coups))
        
        (setq nb_allumettes_IA nb_allumettes)
        (setq nb_allumettes (- nb_allumettes IA_coups))
        ;; humain qui joue
        (if (> nb_allumettes 0)
            (progn
            (setq humain_coups (JeuJoueur nb_allumettes actions))
              (setq nb_allumettes (- nb_allumettes humain_coups))
              (when (= nb_allumettes 0) (renforcement nb_allumettes_IA IA_coups actions)
)
            (explore-renfD nb_allumettes actions)
              )
          (explore-renfD 1 actions))
            )
        ))
    ))
