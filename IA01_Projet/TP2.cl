; TP2 : Jeu de Nim
; SAVARY Tobias, BAUVAIS Camille


(setq actions '((16 3 2 1) (15 3 2 1) (14 3 2 1) (13 3 2 1) 
              (12 3 2 1) (11 3 2 1) (10 3 2 1) (9 3 2 1) 
              (8 3 2 1) (7 3 2 1) (6 3 2 1) (5 3 2 1) (4 3 2 1) 
              (3 3 2 1) (2 2 1) (1 1)))

; Resolution 1:

;; fonction qui donne tous les successeurs d'un état :
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

; Appel :
(defvar nbCoupsAJouer nil)
(setq nbCoupsAJouer (explore 16 actions 'IA 0))
(setq nbCoupsAJouer (explore 8 actions 'IA 0))
(setq nbCoupsAJouer (explore 3 actions 'IA 0))


; Resolution 2:

(defun Randomsuccesseurs (actions) 
  (let ((r (random (length actions))))
    ;;(format t "~&~2t Res du random ~s~&" r)
    (nth r actions)))

; Question 2:

; Première Implémentation

; (defun JeuJoueur (NbAllumettes listeActions)
;     (let ((lecture 5)
;           (possible (assoc NbAllumettes listeActions)))
        
;         (while (not (member lecture (cdr possible)))
;             (format t "Rentrer le coups à jouer (il reste ~s allumettes): ~&" NbAllumettes)
;             (setq lecture (read))
;         )
;         lecture
;     )
; )  


; Seconde Implémentation

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
; Appel :
(JeuJoueur 5 actions)
(JeuJoueur 12 actions)
(JeuJoueur 2 actions)
(JeuJoueur 1 actions)


; Question 3 :

(defun explore-renf1 (nb_allumettes actions)
  (let ((IA_coups) (humain_coups))
    (cond 
     ((= nb_allumettes 0) actions) ;; IA gagne
     ((= nb_allumettes 1) nil) ;; IA perd
     (t 
      (progn
        ;; IA qui joue
            (setq IA_coups (Randomsuccesseurs (successeurs nb_allumettes actions)))
        (format t "L'IA joue ~s ~&" IA_coups)
            (setq nb_allumettes (- nb_allumettes IA_coups))
        ;; humain qui joue
        (if (> nb_allumettes 0)
            (progn
            (setq humain_coups (JeuJoueur nb_allumettes actions))
              (setq nb_allumettes (- nb_allumettes humain_coups))
            (explore-renf1 nb_allumettes actions)
              )
          (explore-renf1 1 actions))
            )
        ))
    ))

; Appel :
(explore-renf1 16 actions)


; Question 4 :

(defun explore-renfDernierCoup (nb_allumettes actions)
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
              (when (= nb_allumettes 0) 
                  (renforcement nb_allumettes_IA IA_coups actions)
              )
            (explore-renfDernierCoup nb_allumettes actions)
            )
          (explore-renfDernierCoup 1 actions))
        )
      )
    )
  )
)

;Appel :
(explore-renfDernierCoup 16 actions)


; Question 5 :

; Première Implémentation

; (defun renforcement (nbAllumettes coup actions)
;     (let ((toAdd (append (list nbAllumettes coup) (cdr (assoc nbAllumettes actions)) )))
;     ; On prépare l'element a ajouter (liste composée 
;     ; du nombre d'allumettes, du coup et des autres 
;     ; possibilitées déjà présentes dans actions)
;     (setf (nth  (* (- nbAllumettes 16) -1) actions) toAdd)
;     ; On récupère l'indice ou se trouve la sous liste 
;     ; correspondante au nombre d'allumettes et on la modifie 
;     ; grâce au setf par la sous liste toAdd cree précédement.
;     actions
;     ; On retourne actions
;   )
; )


; Seconde Implémentation

(defun renforcement (nbAllumettes coup actions)
  (setf (cdr (assoc nbAllumettes actions))
    (nconc (cdr(assoc nbAllumettes actions)) (list coup)))
    actions)

(Renforcement 7 1 actions) ; -> (... (7 3 2 1 1) ...)
(Renforcement 16 3 actions) ; -> ((16 3 2 1 3) ...)


; Question 6

(defun explore-renf-rec (nb_allumettes actions)
  (defparameter a_renf nil)
    (explore-renf nb_allumettes actions))


(defun explore-renf (nb_allumettes actions)
  (let ((IA_coups ) (humain_coups))
    (cond 
     ((= nb_allumettes 0) 
        (dolist (x a_renf actions)
          (renforcement (car x) (cadr x) actions)
        );; IA gagne
      ) 
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

; Appel :
(explore-renf-rec 16 actions)
