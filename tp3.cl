; ----------------------------------------------------------------------
; --------------------------------- BDR --------------------------------
; ----------------------------------------------------------------------
(load "bdr.cl")
; (setq *bdr* 
      
; '(( R1 ((eq profession CDD)) (eq situation stable))
; ( R2 ((eq profession fonctionnaire)) (eq situation stable))

; ( R3 ((>= critèreApport 2)) (eq situation stable))

; ( R4 ((> age 65) (> duree_pret 7)) (eq etatPret refuse))
; ( R5 ((> age 65) (eq assurance nil)) (eq etatPret refuse))

; ( R6 ((< endettement 35) (>= critèreApport 1) (eq situation stable)) (eq typePret Immobilier) )
; ( R19 ((eq typePret Immobilier)(<= duree_pret 27) (>= duree_pret 5) (>= montant 50000)) (eq etatPret accepte))
; ( R7 ((eq typePret Immobilier)) (<= duree_pret 27))
; ( R21 ((eq typePret Immobilier)) (>= duree_pret 5))
; ( R8 ((eq typePret Immobilier) (<= duree_pret 10)) (= taux 2.40))
; ( R9 ((eq typePret Immobilier) (<= duree_pret 15)(> duree_pret 10)) (= taux 2.53))
; ( R10 ((eq typePret Immobilier) (<= duree_pret 20)(> duree_pret 15)) (= taux 2.64))
; ( R11 ((eq typePret Immobilier) (>= duree_pret 20)) (= taux 2.81))
; ( R12 ((eq nationalite France)) (eq statut Francais))
; ( R13 ((eq lieuResidence France) (>= duree_sejour 5)) (eq statut Français))
; ( R14 ((eq profession etudiant) (eq statut Français)) (eq StatutEtu valide))
; ( R15 ((>= age 18) (<= age 28) (eq statutEtu valide)) (eq typePret Etudiant))
; ( R20 ((eq typePret Etudiant) (>= montant 1500) (<= montant 30000) (>= duree_pret 2) (<= duree_pret 10)) (eq etatPret accepte))
; ( R16 ((eq typePret Etudiant)) (<= montant 30000))
; ( R22 ((eq typePret Etudiant)) (>= montant 1500))
; ( R17 ((eq typePret Etudiant)) (= taux 2))
; ( R18 ((eq typePret Etudiant)) (<= duree_pret 10))
; ( R23 ((eq typePret Etudiant)) (>= duree_pret 2))
; ))

; ----------------------------------------------------------------------
; --------------------------------- BDF --------------------------------
; ----------------------------------------------------------------------

(setq *bdf1* '((profession CDD) (endettement 10) (critèreApport 1)))

(setq *bdf5* '((profession CDD) (age 25) (endettement 10) (assurance nil) (critèreApport 1)))



; ----------------------------------------------------------------------
; ------------------------------ Getters -------------------------------
; ----------------------------------------------------------------------
(defun getInfo (message)
  (format t message)
  (read)
  ) 

(defun getProfession ()
  (let ((prof nil))
    (setq prof (getInfo "Quel est votre type de profession (CDD Fonctionnaire Etudiant)?"))
    (while (not (member prof '(CDD Fonctionnaire Etudiant)))
      (format t "Valeur incorrect, les professions possibles sont : CDD, Fonctionnaire, Etudiant) ~&")
      (setq prof (getInfo "Entrez a nouveau une profession : "))
     )
    prof
  ) 
)

(defun getApport ()
  (let ((appo nil))
    (setq appo (getInfo "De combien est votre apport (valeur en euro) ? "))
    (while (not (numberp appo)) 
      (setq appo (getInfo "Erreur, entrez a nouveau votre apport (valeur en euro) : "))
    )
    appo
  )
)

(defun getAge ()
  (let ((age nil))
    (setq age (getInfo "Quel age avez vous ? "))
    (while (or (not (numberp age)) (or (< age 0) (> age 150))) 
      (setq age (getInfo "Erreur, entrez a nouveau votre age : "))
      )
    age
  )
)

(defun getAssurance ()
  (let ((assurance nil))
      ;; TODO : JSP comment verifier si c'est bien T ou Nil : il faudra traiter la réponse oui --> T et non --> nil
  (setq assurance (getInfo "Avez-vous souscrit a une assurance (oui/non)? "))
  (while (not (member assurance '(oui non))) 
      (setq assurance (getInfo "Erreur, entrez a nouveau votre age : "))
      )
    assurance
))

(defun getRevenu ()
  (let ((revenu nil))
    (setq revenu (getInfo "Entrez vos revenu (mensuel) : "))
    (while (or (not (numberp revenu)) (or (< revenu 0) (> revenu 15000))) 
      (setq revenu (getInfo "Erreur, entrez a nouveau vos revenus : "))
      )
    revenu
  )
)

(defun getDureePret ()
    (let ((DureePret nil))
    (setq DureePret (getInfo "Entrez la Duree de votre Pret (nombre d'annee) : "))
    (while (or (not (numberp DureePret)) (or (< DureePret 0) (> DureePret 80))) 
      (setq DureePret (getInfo "Erreur, entrez a nouveau la Duree de votre Pret : "))
      )
    DureePret
  )
)

(defun getNationnalite ()
    (getInfo "Entrez votre pays d'origine (france, suisse, italie...) : ")
)

(defun getLieuResidence ()
    (getInfo "Entrez votre lieu de residence (france, suisse, italie...) : ")
)

(defun getMontant ()
    (let ((Montant nil))
    (setq Montant (getInfo "Entrez le montant de votre pret (en euro) : "))
    (while (or (not (numberp Montant)) (or (< Montant 0) (> Montant 1000000))) 
      (setq Montant (getInfo "Erreur, entrez a nouveau le montant de votre Pret : "))
      )
    Montant
  )
)

(defun getDureeSejour ()
    (let ((DureeSejour nil))
    (setq DureeSejour (getInfo "Entrez la Duree de votre sejour (nombre d'annee) : "))
    (while (or (not (numberp DureeSejour)) (or (< DureeSejour 0) (> DureeSejour 100))) 
      (setq DureeSejour (getInfo "Erreur, entrez a nouveau la Duree de votre sejour : "))
      )
    DureeSejour
  )
)


; Fonctions de service
(defun cclRegle (regle) (caddr regle))

;; (cclRegle (assoc 'R6 *bdr*)) -> ((EQ TYPEPRET IMMOBILIER))


(defun premisseRegle (regle) (cadr regle))

;; (premisseregle (assoc 'R6 *bdr*)) -> ((< ENDETTEMENT 35) (>= CRITÈREAPPORT 1)
;;  (EQ SITUATION STABLE))  

(defun numRegle (regle) (car regle))
;; (numRegle (assoc 'R6 *bdr*)) --> R6




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



; ----------------------------------------------------------------------
; -------------------------- Chainage arrière --------------------------
; ----------------------------------------------------------------------
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
      (setq ok (verifier_ou (pop premisses) bdF bdR (+ 6 i))))
    ok))


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
;; Est ce qu'il à une situation stable ? (verifier_ou '(eq situation stable) *bdf1* *bdr*) --> T

;; est ce qu'il peut prétendre à un pret immobilier ? (verifier_ou '(eq typepret immobilier) *bdf1* *bdr*)

(defun menuBanque ()
  (let ((choix_menu nil)
        (choix_pret nil))
    (while (not (member choix_menu '(1 2 3)))
      (format t "Menu : ~&
1) Faisabilite du pret ~&
2) verification du montant ~&
3) Calcul du remboursement ~&
Entrez un choix (1, 2 ou 3) : ")
      (setq choix_menu (read))
      )
      (while (not (member choix_pret '(immobilier etudiant)))
        (format t "~& Choix du pret (immobilier ou etudiant): ")
        (setq choix_pret (read)))
    (cond
     ((= choix_menu 1) (fpret choix_pret))
     ((= choix_menu 2) (format t "Verif du montant"))
     ((= choix_menu 3) (format t "Calcul du remboursement")))
    )

)

;; (menuBanque)


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

;; le but rentré correspond à la valeur que l'on cherche (taux, duree, ...)
(defun chainage_avant(bdf but bdr)
  (let ((fin nil)
        (reglesparcourues nil)
        (conclus nil))
    (while (not fin)
      (format t "rentre while ~&")
      (setq fin t)
      (format t "fin : ~s ~&" fin)
      (dolist (regle bdr)
        (format t "regle : ~s ~&" regle)
        (format t "verif regle : ~s ~&" (verif_regle regle bdf))
        (if (and (verif_regle regle bdf) (not (member (numregle regle) reglesparcourues)))
            (progn 
              (format t "rentre if ~&")
              (setq fin nil)
              (format t "fin : ~s ~&" fin)
              (push (list (cadr (cclregle regle))
                          (caddr (cclregle regle))) bdf)
              (push regle reglesparcourues)
              (if (eq (cadr (cclregle regle)) but)
                  (push (cclregle regle) conclus)))
          )
        )
      )
    conclus)
  )
  

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

; Fonctionnel 
;; le but rentré correspond à la valeur que l'on cherche (taux, duree, ...)
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
; /!\ Gestion du signe <= >= pour la duree + le montant

(setq *bdf2* '((profession CDD) (nationalite France)))
(chainage_avant *bdf2* 'statut *bdr*)

; (defun chainage_avant(bdf but bdr)
;   (let ((fin nil)
;         (reglesparcourues nil)
;         (conclus nil))
;     (while (not fin)
;       (format t "rentre while ~&")
;       (setq fin t)
;       (format t "fin : ~s ~&" fin)
;       (dolist (regle bdr)
;         (format t "regle : ~s ~&" regle)
;         (format t "verif regle : ~s ~&" (verif_regle regle bdf))
;         (if (and (verif_regle regle bdf) (not (member (numregle regle) reglesparcourues)))
;             (progn 
;               (format t "rentre if ~&")
;               (setq fin nil)
;               (format t "fin : ~s ~&" fin)
;               (push (list (cadr (cclregle regle))
;                           (caddr (cclregle regle))) bdf)
;               (push regle reglesparcourues)
;               (if (eq (cadr (cclregle regle)) but)
;                   (push (cclregle regle) conclus)))
;           )
;         )
;       )
;     conclus)
;   )
; )





; (defun chainage_avant2 (bdf bdr modif_bdf)
;    (let ( (ccl NIL)
;           ; (modif_bdf NIL)
;         )
;         (dolist (regle bdr)
;           (when  (verif_regle regle bdr))
;               (setq ccl (cclRegle regle))
;               (dolist (each_ccl ccl)
;                 (when (not (member )))
;               )
;               (push () bdf)
;               (setq modif_bdf T)
;         )
;       )
;   )

; (defun main_chainage_avant (bdf bdr)
;     chainage_avant2 (bdf bdr T)
