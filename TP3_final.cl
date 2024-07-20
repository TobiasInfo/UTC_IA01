;; ---------------------------------BDR------------------------------------
(setq *bdr*

'(( R1 ((eq profession CDI)) (eq situation stable))
( R2 ((eq profession fonctionnaire)) (eq situation stable))
( R3 ((>= revenu 50000)) (eq situation stable))

( R4 ((eq nationalite France)(>= age 18)) (eq statut Francais))
( R5 ((eq lieuResidence France) (>= duree_sejour 5) (>= age 18)) (eq statut Francais))

( R6 ((eq profession etudiant) (eq statut Francais) (<= age 28)) (eq StatutEtu valide))

( R7 ((> age 65) (> duree_pret 7)) (eq etatPret refuse))
( R8 ((> age 65) (eq assurance non)) (eq etatPret refuse))

( R9 ((eq situation stable)(< endettement 35)) (eq typePret credit))

( R10 ((>= critereApport 1) (eq typePret credit) (eq statut Francais)) (eq typePret Immobilier) )
( R11 ((eq typePret Immobilier)(<= duree_pret 27) (>= duree_pret 5) (>= montant 50000)) (eq etatPret accepte))

( R12 ((eq typePret Immobilier)) (>= montant 50000))
( R13 ((eq typePret Immobilier)) (<= duree_pret 27))
( R14 ((eq typePret Immobilier)) (>= duree_pret 5))
( R15 ((eq typePret Immobilier) (<= duree_pret 10)) (= taux 2.40))
( R16 ((eq typePret Immobilier) (<= duree_pret 15)(> duree_pret 10)) (= taux 2.53))
( R17 ((eq typePret Immobilier) (<= duree_pret 20)(> duree_pret 15)) (= taux 2.64))
( R18 ((eq typePret Immobilier) (>= duree_pret 20)) (= taux 2.81))


( R19 ((eq statutEtu valide)) (eq typePret Etudiant))
( R20 ((eq typePret Etudiant) (>= montant 1500) (<= montant 30000) (>= duree_pret 2) (<= duree_pret 10)) (eq etatPret accepte))

( R21 ((eq typePret Etudiant)) (<= montant 30000))
( R22 ((eq typePret Etudiant)) (>= montant 1500))
( R23 ((eq typePret Etudiant)) (= taux 2.00))
( R24 ((eq typePret Etudiant)) (<= duree_pret 10))
( R25 ((eq typePret Etudiant)) (>= duree_pret 2))

( R26 ((eq typePret credit)(eq statut Francais)) (eq typePret consommation))
( R27 ((eq typePret consommation)(< montant 50000)(>= duree_pret 1)(<= duree_pret 6)) (eq etatPret accepte))
( R28 ((eq typePret consommation)) (<= duree_pret 6))
( R29 ((eq typePret consommation)) (>= duree_pret 1))
( R30 ((eq typePret consommation)) (< montant 50000))

( R31 ((eq typePret consommation)(eq typeConso auto)(= duree_pret 1)) (= taux 0.51))
( R32 ((eq typePret consommation)(eq typeConso auto)(<= duree_pret 2)(> duree_pret 1)) (= taux 1.51))
( R33 ((eq typePret consommation)(eq typeConso auto)(<= duree_pret 3)(> duree_pret 2)) (= taux 1.91))
( R34 ((eq typePret consommation)(eq typeConso auto)(<= duree_pret 5)(> duree_pret 3)) (= taux 2.41))
( R35 ((eq typePret consommation)(eq typeConso auto)(<= duree_pret 6)(> duree_pret 5)) (= taux 3.41))

( R36 ((eq typePret consommation)(eq typeConso travaux)(= duree_pret 1)) (= taux 0.91))
( R37 ((eq typePret consommation)(eq typeConso travaux)(<= duree_pret 2)(> duree_pret 1)) (= taux 2.01))
( R38 ((eq typePret consommation)(eq typeConso travaux)(<= duree_pret 3)(> duree_pret 2)) (= taux 2.41))
( R39 ((eq typePret consommation)(eq typeConso travaux)(<= duree_pret 4)(> duree_pret 3)) (= taux 2.80))
( R40 ((eq typePret consommation)(eq typeConso travaux)(<= duree_pret 5)(> duree_pret 4)) (= taux 3.00))
( R41 ((eq typePret consommation)(eq typeConso travaux)(<= duree_pret 6)(> duree_pret 5)) (= taux 3.40))

( R42 ((eq typePret consommation)(eq typeConso personnel)(= duree_pret 1)) (= taux 0.51))
( R43 ((eq typePret consommation)(eq typeConso personnel)(<= duree_pret 2)(> duree_pret 1)) (= taux 1.51))
( R44 ((eq typePret consommation)(eq typeConso personnel)(<= duree_pret 3)(> duree_pret 2)) (= taux 1.91))
( R45 ((eq typePret consommation)(eq typeConso personnel)(<= duree_pret 4)(> duree_pret 3)) (= taux 2.80))
( R46 ((eq typePret consommation)(eq typeConso personnel)(<= duree_pret 5)(> duree_pret 4)) (= taux 2.41))
( R47 ((eq typePret consommation)(eq typeConso personnel)(<= duree_pret 6)(> duree_pret 5)) (= taux 4.51))


))


(setq *bdf1* '((profession CDD) (endettement 10) (critèreApport 1)))

;;------------------------------------------------------------------------------- 

;;---------------------------------GETTER-------------------------------------
(defun getInfo (message)
  (format t message)
  (read)
  ) 

(defun getProfession ()
  (let ((prof nil))
    (setq prof (getInfo "~&Quelle est votre profession (CDI, Fonctionnaire, Etudiant ou Autre)?"))
    (while (not (member prof '(CDI Fonctionnaire Etudiant autre)))
      (format t "~&Valeur incorrecte -- les professions possibles sont : CDI, Fonctionnaire, Etudiant, autre) ~&")
      (setq prof (getInfo "~&Entrez à nouveau une profession : "))
     )
    prof
  ) 
)

(defun getApport ()
  (let ((appo nil))
    (setq appo (getInfo "~&De combien est votre apport (valeur en euro) ? "))
    (while (not (numberp appo)) 
      (setq appo (getInfo "~&Erreur -- entrez à nouveau votre apport (valeur en euro) : "))
    )
    appo
  )
)

(defun getAge ()
  (let ((age nil))
    (setq age (getInfo "~&Quel âge avez vous ? "))
    (while (or (not (numberp age)) (or (< age 0) (> age 150))) 
      (setq age (getInfo "~&Erreur -- entrez à nouveau votre âge : "))
      )
    age
  )
)

(defun getAssurance ()
  (let ((assurance nil))
      ;; TODO : JSP comment verifier si c'est bien T ou Nil : il faudra traiter la réponse oui --> T et non --> nil
  (setq assurance (getInfo "~&Avez-vous souscrit à une assurance (oui/non)? "))
  (while (not (member assurance '(oui non))) 
      (setq assurance (getInfo "~&Erreur -- répondez par oui ou non, avez-vous souscrit à une assurance? : "))
      )
    assurance
))

(defun getRevenu ()
  (let ((revenu nil))
    (setq revenu (getInfo "~&Entrez le montant total de vos revenus (mensuel) : "))
    (while (or (not (numberp revenu)) (or (< revenu 0) (> revenu 15000))) 
      (setq revenu (getInfo "~&Erreur -- entrez à nouveau vos revenus : "))
      )
    revenu
  )
)

(defun getDureePret ()
    (let ((DureePret nil))
    (setq DureePret (getInfo "~&Entrez la durée de votre prêt (nombre d'années) : "))
    (while (or (not (numberp DureePret)) (or (< DureePret 0) (> DureePret 80))) 
      (setq DureePret (getInfo "~&Erreur -- entrez à nouveau la durée de votre prêt : "))
      )
    DureePret
  )
)

(defun getNationalite ()
    (getInfo "~&Entrez votre pays d'origine (france, suisse, italie...) : ")
)

(defun getLieuResidence ()
    (getInfo "~&Entrez votre lieu de résidence (france, suisse, italie...) : ")
)

(defun getMontant ()
    (let ((Montant nil))
    (setq Montant (getInfo "~&Entrez le montant de votre prêt (en euro) : "))
    (while (or (not (numberp Montant)) (or (< Montant 0) (> Montant 1000000))) 
      (setq Montant (getInfo "~&Erreur -- entrez à nouveau le montant de votre prêt : "))
      )
    Montant
  )
)

(defun getDureeSejour ()
    (let ((DureeSejour nil))
    (setq DureeSejour (getInfo "~&Entrez la durée de votre séjour (nombre d'années) : "))
    (while (or (not (numberp DureeSejour)) (or (< DureeSejour 0) (> DureeSejour 100))) 
      (setq DureeSejour (getInfo "~&Erreur -- entrez à nouveau la durée de votre séjour : "))
      )
    DureeSejour
  )
  )


(defun getMensualiteVoulu ()
    (let ((MensualiteVoulu nil))
    (setq MensualiteVoulu (getInfo "~&Entrez la mensualité que vous souhaitez (euro / mois) : "))
    (while (or (not (numberp MensualiteVoulu)) (or (< MensualiteVoulu 0) (> MensualiteVoulu 3000))) 
      (setq MensualiteVoulu (getInfo "~&Erreur -- Entrez la mensualite que vous souhaitez (euro / mois) : "))
      )
    MensualiteVoulu
  )
  )

(defun getTypeConso()
  (let ((conso nil))
    (setq conso (getInfo "~&Entrez le type du crédit à la consommation que vous souhaitez (auto, travaux, personnel) : "))
    (while (not (member conso '(auto travaux personnel))) 
      (setq conso (getInfo "~&Erreur -- Entrez le type du crédit à la consommation que vous souhaitez (auto, travaux, personnel) : "))
      )
    conso
  )
  )

;; ------------------------------------------------------------------------------------

;;-------------------------------CHECKERS -------------------------------------------

(defun checkmontant(bdf)
  (let ((resul nil)
        (stop nil))
  (setq resul (chainage_avant bdf 'montant *bdr*)) 
    ;;(format t "resul :  ~s ~&" resul) 
    (while (and (not stop) resul) 
      (let ((regle (pop resul))) 
      (if (not (appartient regle bdf)) 
          (setq stop t)) 
        )
      )
    (if stop 
        (progn
          (format t "Erreur -- Le montant n'est pas adéquat~&") 
          nil)
      t)
    )
  )

(defun checkduree(bdf)
  (let ((resul nil)
        (stop nil))
    (setq resul (chainage_avant bdf 'duree_pret *bdr*)) 
  (while (and (not stop) resul) 
      (let ((regle (pop resul)))  
      (if (not (appartient regle bdf))  
          (setq stop t))  
        )
          )
    (if stop
        (progn
          (format t "Erreur -- La durée du pret n'est pas adéquate~&")
          nil)
      t)
    )
  )




;;------------------------------------------------------------------------------


;;----------------------------FONCTIONS-SERVICE---------------------------------
(defun cclRegle (regle) (caddr regle))

;; (cclRegle (assoc 'R6 *bdr*)) -> ((EQ TYPEPRET IMMOBILIER))


(defun premisseRegle (regle) (cadr regle))

;; (premisseregle (assoc 'R6 *bdr*)) -> ((< ENDETTEMENT 35) (>= CRITÈREAPPORT 1)
;;  (EQ SITUATION STABLE))  

(defun numRegle (regle) (car regle))
;; (numRegle (assoc 'R6 *bdr*)) --> R6



(defun appartient (but bdf)
  ;; but est de la forme: (comparateur attribut valeur)
  (let ((valeur (cadr (assoc (cadr but) bdf)))) ;; valeur = 6 (dans bdF)
    (if valeur
        (funcall (car but) valeur (caddr but))))) ;; le eval ne fonctionne pas avec eq : (eval (list (car but) valeur (caddr but))))))

;; (appartient '(< endettement 35) *bdf1*) --> T
;; (appartient '(< endettement 5) *bdf1*) --> NIL

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


;; (regles_candidates '(eq situation stable) *bdr*) --> 
;;((R1((EQ PROFESSION CDD)) (EQ SITUATION STABLE))
;; (R2 ((EQ PROFESSION FONCTIONNAIRE))
;;  (EQ SITUATION STABLE)) 
;; (R3 ((>= CRITÈREAPPORT 2)) (EQ SITUATION STABLE)))

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


;;-----------------------------------------------------------------------------

;;----------------------------CHAINAGE ARRIERE--------------------------------

(defparameter dernier_enr nil)

(defun verifier_ou (but bdF bdR &optional (i 0))
  (if (appartient but bdF) ;; ici on remplacer le member par appartient
      (progn 
        ;;(format t "~V@t But : ~A proof ~%" i but)
        T)
    ;;(let ((regles (regles_candidates but bdR)) (ok nil))
    (let ((regles (reverse (regles_candidates but bdR))) (ok nil))

     (while (and regles (not ok))
       ;;(format t "~% ~V@t VERIFIE_OU ~A Regles ~s :  ~A ~%" i but (numRegle (car regles)) (car regles))
       (setq ok (verifier_et (pop regles) bdF bdR i)))
     ok)
    ))

(defun verifier_et (regle bdF bdR i)
  (let ((ok t) (premisses (premisseRegle regle)))
    (while (and premisses ok)
      ;;(format t "~V@t  ~t VERIFIE_ET ~s premisse ~A~%" (+ 1 i) (numRegle regle) (car premisses))
      (setq dernier_enr (car premisses))
      (setq ok (verifier_ou (pop premisses) bdF bdR (+ 6 i))))
    ok))

;; Est ce qu'il à une situation stable ? (verifier_ou '(eq situation stable) *bdf1* *bdr*) --> T

;; est ce qu'il peut prétendre à un pret immobilier ? (verifier_ou '(eq typepret immobilier) *bdf1* *bdr*)

;;-----------------------------------------------------------------------------

;; -------------------------CHAINAGE AVANT ----------------------------------- 


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

;;---------------------------------------------------------------------------

;;---------------------------------------FONCTIONS UTILISATEURS---------------

(defun menuBanque ()  
  (let ((choix_menu 1)
        (choix_pret nil))
    (while (member choix_menu '(1 2 3)) 
      (setq choix_pret nil)
      (format t "Menu : ~&
1) Faisabilite du pret ~&
2) Calcul du remboursement ~&
3) Calcul de la durée de remboursement ~&
4) Sortir ~&
Entrez un choix (1, 2, 3 ou 4) : ")
      (setq choix_menu (read))
      
    (if (member choix_menu '(1 2 3))
        (progn
      (while (not (member choix_pret '(immobilier etudiant consommation)))
        (format t "~&Choix du type de prêt (immobilier ou etudiant ou consommation):") 
        (setq choix_pret (read))) 
    (cond
     ((= choix_menu 1) (fpret choix_pret))
      ((= choix_menu 2) (calculmensualite choix_pret))
     ((= choix_menu 3) (duree_remboursement choix_pret))
    ))))

    )
  (format t "fin de simulation ~&"))

;; (menuBanque)

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
    
    ;;(format t "bdf montant :  ~s ~&" bdf)
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
            (format t "~&Le taux du prêt sera de : ~s ~&" taux) 
            (setq mens (/ (* montant (+ 1 (/ taux 100)))(* duree 12)))
            (if affichage
            (format t "~&Vous devez rembourser ~s € par mois~&" mens))  
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
    
    (format t "~&~&--Récupération des informations concernant le prêt ~s-- ~& " pret)
    
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
        (format t "Le prêt n'est pas faisable, trop grand risque~&")
      (if (verifier_ou '(eq etatpret accepte) bdf *bdr*)
          (progn
            (format t "Le prêt ~s peut être envisagé ~&" pret)
            t)
        (let* ((comp (pop dernier_enr))
               (terme (pop dernier_enr))
               (val (pop dernier_enr)))
          (cond
           ((eq comp 'eq) (setq comp '=))
           ((eq terme 'profession)(setq val 'revenus_fixes)))
        
          (format t "Le prêt ne peut pas être envisagé, il faut que ~s ~s ~s ~&" terme comp val)
          
            )) )
    
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
    ;;(print taux )
    ;;(print (caddr (car taux) ))
    (if taux
        (setq duree_reel (/ (* montant (+ 1 (/ (caddr (car taux) ) 100))) (* mensualite_voulu 12)  ) )
        (progn 
          (format t "~&Erreur -- Aucun taux n'as été trouvé pour votre situation~&")
          Nil
        )
    )
    (setq intervalle_pret (chainage_avant bdf 'duree_pret *bdr*))
    (setq min (caddr ( assoc '>= intervalle_pret)))
    (setq max (caddr ( assoc '<= intervalle_pret)))
    (if  (or (> duree_reel max) (< duree_reel min))
        (format t "~&Erreur -- votre durée de prêt ne rentre pas dans les critères, il faut revoir le montant ou les mensualités ~&")
      (progn
        (push (list 'duree_pret duree_reel) bdf)
        (setq taux (chainage_avant bdf 'taux *bdr*))
        (if taux
        (setq duree_reel (/ (* montant (+ 1 (/ (caddr (car taux) ) 100))) (* mensualite_voulu 12)  ) )
        (progn 
          (format t "~&Erreur -- Aucun taux n'as été trouvé pour votre situation~&")
          Nil
        )
    )
        ;;(print duree_reel)
        (format t "La durée de votre prêt sera de :  ~A  ans et ~A mois. ~&" (truncate duree_reel) (+ (truncate (* ( - duree_reel (truncate duree_reel)) 12) 1 )))
        )
      )
;; (- 1 (/ (* ( - duree_reel (truncate duree_reel)) 12) 10))
    )
  )


(menuBanque)





