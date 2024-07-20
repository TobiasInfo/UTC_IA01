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





(defun calculMensualite(pret)
  ;;calcul montant total à rembourser qu'on divise par le temps du pret puis par 12
  (let ((montant nil)
        (duree nil)
        )
    ;;Recup montant
    (setq montant (getmontant))
    
    ;;Recup durée
    (setq duree (getdureepret))
    ;;chainage avant
    ))


(defun fpret (pret)
  ;; remplissage de la bdf
  (let ((bdf nil)
        (prof nil)
        (appo nil)
        (age nil)
        (assurance nil)
        (revenu nil)
        (montant nil)
        )
    ;; demander info
    
    ;; Recup profession
    (setq prof (getProfession ))
    (push (list 'profession prof) bdf)
    
    ;;Recup montant
    (setq montant (getmontant))
    (push (list 'montant montant) bdf)
    
    ;; Recup apport
    (setq appo (getApport))
    (cond
     ((>= appo (* 0.35 montant)) (push (list 'critèreapport 2) bdf))
     ((>= appo (* 0.1 montant)) (push (list 'critèreapport 1) bdf))
     (t (push (list 'critèreapport 0) bdf))
     )
    
    ;; Recup age
    (setq age (getAge))
    (push (list 'age age) bdf)
    
    ;; Recup assurance
    (setq assurance (getAssurance))
    (push (list 'assurance assurance) bdf)
    
    ;;Recupe Revenu
    (let ((endettement nil))
      (setq revenu (getRevenu))
      (setq endettement (* (/ (calculMensualite) revenu) 100))
      (push (list 'endettement endettement) bdf))
      
    ;; ici faire le calcul de l'endettement = (mensualité)/revenu
    ;; à l'aide de la fonction qui calcule les mensualités. 

    (print bdf)
    ;; ICI la bdf est remplie

    ;; TODO :
    ;; Faire un chainage arriere sur EtatPret = Refuse 
    ;; Si le pret est refuse :
    ;;      Afficher pret refuse 
    ;;      return 
    ;; Sinon :
    ;;      Faire un chainage arriere sur EtatPret = accepte
    ;;      Si le pret est accepte :
    ;;          Afficher pret accepte
    ;;          return 
    ;;      Sinon :
    ;;          Appeler la fonction RecuperationFaute()



;;  (if (verifier_ou '(eq typepret immobilier) bdf *bdr*)
;;      (format t "& Le pret ~s peut etre envisage ~&" pret))
    
  )
 )

(setq *bdf2* '((profession CDD) (nationalite France)))
; (chainage_avant *bdf2* 'statut *bdr*)