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

(defun getTypePret ()
    (let ((TypePret nil))
      (while (not (member TypePret '(immobilier etudiant)))
        (format t "~& Entrez votre type de Pret (immobilier ou etudiant): ")
        (setq TypePret (read)))
        TypePret
  )
)


(defun getMensualiteVoulu ()
    (let ((MensualiteVoulu nil))
    (setq MensualiteVoulu (getInfo "Entrez la mensualite que vous souhaitez (euro / mois) : "))
    (while (or (not (numberp MensualiteVoulu)) (or (< MensualiteVoulu 0) (> MensualiteVoulu 3000))) 
      (setq MensualiteVoulu (getInfo "Erreur, Entrez la mensualite que vous souhaitez (euro / mois) : "))
      )
    MensualiteVoulu
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


CHECKERS

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
          (format t "Le montant n'est pas adéquat~&") 
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
          (format t "La durée du pret n'est pas adéquate~&")
          nil)
      t)
    )
  )


