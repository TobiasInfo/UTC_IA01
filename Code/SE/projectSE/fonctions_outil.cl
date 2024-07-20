; ----------------------------------------------------------------------
; ----------------------------- Appartient -----------------------------
; ----------------------------------------------------------------------

(defun appartient (but bdf)
  ;; but est de la forme: (comparateur attribut valeur)
  (let ((valeur (cadr (assoc (cadr but) bdf)))) ;; valeur = 6 (dans bdF)
    (if valeur
        (funcall (car but) valeur (caddr but))))) ;; le eval ne fonctionne pas avec eq : (eval (list (car but) valeur (caddr but))))))

;; (appartient '(< endettement 35) *bdf1*) --> T
;; (appartient '(< endettement 5) *bdf1*) --> NIL


; ----------------------------------------------------------------------
; ------------------------- Regles_candidates --------------------------
; ----------------------------------------------------------------------
(defun regles_candidates (but bdr) ;; (eq moyen voiture) // (> age 18) 
  ;;(print bdr)
  (if bdr
      (let* ((conclusion (cclRegle (car bdr))) ;; R1 (eq moyen voiture) // Rx (> age 20)
             (attribut (cadr conclusion)) ;; moyen  // age
             (valeur (caddr conclusion))) ;; voiture // 20

        (if 
          (and 
           ;; il faut verifier l identité des attributs
           (eq attribut (cadr but))  ;; eq moyen moyen // eq age age
           ;; et que la regle concluera sur une valeur correcte 
           (funcall (car but) valeur (caddr but)))  ;; eq voiture voiture // > 20 18 // ou (eval list (car but) valeur (caddr but))))
          (cons (car bdr) (regles_candidates but (cdr bdr))) ;; alors on push la règle R1 // RX
          (regles_candidates but (cdr bdr))))))

;; Test
;; (regles_candidates '(eq situation stable) *bdr*) --> 
;;((R1((EQ PROFESSION CDD)) (EQ SITUATION STABLE))
;; (R2 ((EQ PROFESSION FONCTIONNAIRE))
;;  (EQ SITUATION STABLE)) 
;; (R3 ((>= CRITÈREAPPORT 2)) (EQ SITUATION STABLE)))




(defun calculMensualite(pret &optional (montant nil))
  ;;calcul montant total à rembourser qu'on divise par le temps du pret puis par 12
  (let ((duree nil)
        (bdf nil)
        (resul nil)
        (stop nil)
        (mens nil)
        (taux nil)
        (affichage nil)
        )
    
    (setq bdf (list (list 'typepret pret)))
    
    (if (eq pret 'consommation)
        (let ((typeconso nil))
          (setq typeconso (gettypeconso))
          (push (list 'typeconso typeconso) bdf))
      )
    
    ;;;;Recup montant si pas déjà
    (if (not montant)
        (progn
          (setq montant (getmontant))
          (setq affichage t)))
    (push (list 'montant montant) bdf)
    
    (format t "bdf montant :  ~s ~&" bdf)
    (if (checkmontant bdf)
    ;;montant valide
      (progn
        ;;Recup durée
        (setq duree (getdureepret))
        (push (list 'duree_pret duree) bdf)
        (if (checkduree bdf)
          ;;duree_valide 
            (progn
            ;; récupération du taux
            (setq taux (caddr (car (chainage_avant bdf 'taux *bdr*))))
            (format t "taux : ~s ~&" taux) 
            (setq mens (/ (* montant (+ 1 taux))(* duree 12)))
            (if affichage
            (format t "Vous devez rembourser ~s € par mois~&" mens))  
            )
          )
        )
      )
    mens)
  )
            




(defun fpret (pret)
  ;; remplissage de la bdf
  (let ((bdf nil)
        (prof nil)
        (age nil)
        (montant nil)
        (nationalite nil)
        )
    ;; demander info
    
    (format t "Récupération des informations concernant le prêt ~s ~& " pret)
    
    ;; Recup profession
    (setq prof (getProfession ))
    (push (list 'profession prof) bdf)
    
    ;;Recup montant
    (setq montant (getmontant))
    (push (list 'montant montant) bdf)
    
    ;; Recup age
    (setq age (getAge))
    (push (list 'age age) bdf)
    
    ;;recup nationalite
    (setq nationalite (getnationalite))
    (push (list 'nationalite nationalite) bdf)
    (if (not (eq nationalite 'france))
        (let ((pays_sejour nil)
              (duree_sejour nil))
          (setq pays_sejour (getlieuresidence))
          (push (list 'lieuresidence pays_sejour) bdf)
          (setq duree_sejour (getdureesejour))
          (push (list 'duree_sejour duree_sejour) bdf)
          )
      )
    
    (if (member pret '(immobilier consommation))
        (let ((assurance nil)
              (revenu nil)
              (endettement nil)
              (mens nil))
          ;;recup assurance
          (setq assurance (getassurance))
          (push (list 'assurance assurance) bdf)
          ;;recup revenu --> endettement
          (setq revenu (getrevenu))
          (setq mens (calculmensualite pret montant))
          (setq endettement (/ (* mens 100) revenu))
          (push (list 'endettement endettement) bdf)
          
          (if (eq pret 'immobilier)
              (let ((appo nil))
                (setq appo(getapport))
                (cond
                 ((>= appo (* 0.35 montant)) (push (list 'critereapport 2) bdf)) 
                 ((>= appo (* 0.1 montant)) (push (list 'critereapport 1) bdf)) 
                 (t (push (list 'critereapport 0) bdf)) 
                 )
                )
            )
          )
      )

    ;;(print bdf) 

    (if (verifier_ou '(eq etatpret refuse) bdf *bdr*)
        (format t "Le prêt n'est pas faisable, trop grand risque")
      (if (verifier_ou '(eq etatpret accepte) bdf *bdr*)
          (progn
            (format t "Le pret ~s peut etre envisage ~&" pret)
            t)
        
          (format t "Le prêt ne peut pas être envisagé, l'erreur vient de ~s ~&" dernier_enr)
          
            )) 
    
  )
  )

(defun duree_remboursement (pret)
  (let ((bdf nil)
        (montant nil)
        (mensualite_voulu nil)
        (duree_reel nil)
        (taux nil)
        (max nil)
        (min nil)
        (intervalle_pret nil)
        )
    
    (push (list 'typepret pret) bdf)
    
    ;; demander info
    
    
    ;; type du pret conso si pret conso
    (if (eq pret 'consommation)
        (let ((typeconso nil))
          (setq typeconso (gettypeconso))
          (push (list 'typeconso typeconso) bdf))
      )
    ;;Recup montant
    (setq montant (getmontant))
    (push (list 'montant montant) bdf)



    ;; Recup typepret
    (setq mensualite_voulu (getMensualiteVoulu ))
    (push (list 'mensualite_voulu mensualite_voulu) bdf)
;;    (print (list 'eq 'typepret typepret))
;;    (print (chainage_avant bdf 'taux *bdr*))
    (setq taux (chainage_avant bdf 'taux *bdr*))
    (print taux )
    (print (caddr (car taux) ))
    (if taux
        (setq duree_reel (/ (* montant (+ 1 (caddr (car taux) ))) (* mensualite_voulu 12)  ) )
        (progn 
          (format t "Erreur aucun taux n'as ete trouve pour votre situation")
          Nil
        )
    )
    (setq intervalle_pret (chainage_avant bdf 'duree_pret *bdr*))
    (setq min (caddr ( assoc '>= intervalle_pret)))
    (setq max (caddr ( assoc '<= intervalle_pret)))
    (if  (or (> duree_reel max) (< duree_reel min))
        (format t "Erreur, votre duree de pret ne rentre pas dans les critères, il faut revoir le montant ou les mensualites ~&")
      (progn 
        (print duree_reel)
        (format t "La duree de votre pret sera de :  ~A  ans et ~A mois. ~&" (truncate duree_reel) (+ (truncate (* ( - duree_reel (truncate duree_reel)) 12) 1 )))
        )
      )
;; (- 1 (/ (* ( - duree_reel (truncate duree_reel)) 12) 10))
    )
  )

