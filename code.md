```lisp

; Base de règle 
(setq *bdr* 
      
'(( R1 ((eq profession CDD)) (eq situation stable))
( R2 ((eq profession fonctionnaire)) (eq situation stable))

( R3 ((>= critèreApport 2)) (eq situation stable))

( R4 ((> age 65) (> duree_pret 7)) (eq etatPret refuse))
( R5 ((> age 65) (eq assurance nil)) (eq etatPret refuse))

( R6 ((< endettement 35) (>= critèreApport 1) (eq situation stable)) (eq typePret Immobilier) )
( R19 ((eq typePret Immobilier)(<= duree_pret 27) (>= duree_pret 5) (>= montant 50000)) (eq etatPret accepte))
( R7 ((eq typePret Immobilier)) (<= duree_pret 27))
( R21 ((eq typePret Immobilier)) (>= duree_pret 5))
( R8 ((eq typePret Immobilier) (<= duree_pret 10)) (= taux 2.40))
( R9 ((eq typePret Immobilier) (<= duree_pret 15)(> duree_pret 10)) (= taux 2.53))
( R10 ((eq typePret Immobilier) (<= duree_pret 20)(> duree_pret 15)) (= taux 2.64))
( R11 ((eq typePret Immobilier) (>= duree_pret 20)) (= taux 2.81))
( R12 ((eq nationalite France)) (eq statut Francais))
( R13 ((eq lieuResidence France) (>= duree_sejour 5)) (eq statut Français))
( R14 ((eq profession etudiant) (eq statut Français)) (eq StatutEtu valide))
( R15 ((>= age 18) (<= age 28) (eq statutEtu valide)) (eq typePret Etudiant))
( R20 ((eq typePret Etudiant) (>= montant 1500) (<= montant 30000) (>= duree_pret 2) (<= duree_pret 10)) (eq etatPret accepte))
( R16 ((eq typePret Etudiant)) (<= montant 30000))
( R22 ((eq typePret Etudiant)) (>= montant 1500))
( R17 ((eq typePret Etudiant)) (= taux 2))
( R18 ((eq typePret Etudiant)) (<= duree_pret 10))
( R23 ((eq typePret Etudiant)) (>= duree_pret 2))
)


; Fonctions de service
(defun cclRegle (regle) (caddr regle))

;; (cclRegle (assoc 'R6 *bdr*)) -> ((EQ TYPEPRET IMMOBILIER))


(defun premisseRegle (regle) (cadr regle))

;; (premisseregle (assoc 'R6 *bdr*)) -> ((< ENDETTEMENT 35) (>= CRITÈREAPPORT 1)
;;  (EQ SITUATION STABLE))  

(defun numRegle (regle) (car regle))

;; (numRegle (assoc 'R6 *bdr*)) --> R6

(setq *bdf1* '((profession CDD) (endettement 10) (critèreApport 1)))


(defun appartient (but bdf)
  ;; but est de la forme: (comparateur attribut valeur)
  (let ((valeur (cadr (assoc (cadr but) bdf)))) ;; valeur = 6 (dans bdF)
    (if valeur
        (funcall (car but) valeur (caddr but))))) ;; le eval ne fonctionne pas avec eq : (eval (list (car but) valeur (caddr but))))))

;; (appartient '(< endettement 35) *bdf1*) --> T

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

;; Est ce qu'il à une situation stable ? (verifier_ou '(eq situation stable) *bdf1* *bdr*) --> T

;; est ce qu'il peut prétendre à un pret immobilier ? (verifier_ou '(eq typepret immobilier) *bdf1* *bdr*)

(defun menuBanque ()
  (let ((choix_menu nil)
        (choix_pret nil))
    (while (not (member choix_menu '(1 2 3)))
      (format t "Menu : ~&
1) Faisabilité du prêt ~&
2) vérification du montant ~&
3) Calcul du remboursement ~&
Entrez un choix (1, 2 ou 3) : ")
      (setq choix_menu (read))
      )
      (while (not (member choix_pret '(immobilier etudiant)))
        (format t "~& Choix du pret (immobilier ou etudiant): ")
        (setq choix_pret (read)))
    (cond
     ((= choix_menu 1) (format t "faisabilité du pret"))
     ((= choix_menu 2) (format t "Verif du montant"))
     ((= choix_menu 3) (format t "Calcul du remboursement")))
    )

  )

(defun fpret (pret)
  ;; remplissage de la bdf
  (let ((prof nil)
        (apport nil)
        (age nil)
        (assurance nil)
        (revenu nil)
        )
    ;; demander info
  (if (verifier_ou '(eq typepret immobilier) bdf *bdr*)
      (format t "& Le prêt ~s peut être envisagé ~&" pret))





```
idée pour récupérer la faute : créer une liste contenant toute les caractéristiques non déductibles (finales), lors du chainage arrière enregistrer les prémisses qui sont contenus dans cette liste puis vérifier laquelle pose problème par rapport à la bdf. 

faisabilité du pret : récupère toutes les informations clients, vérifier etatpret refusé qui est à nil, chainage arrière en partant de (etatpret accepte), si renvoie nil --> faire récupération de faute. 

Faire fonction chainage avant qui fonctionne au moins pour récupérer le taux.

On fait deux fonctions fpret, une pour immo l'autre pour etudiant, car les critères à vérifier ne sont pas les mêmes

Vérif montant voir plus tard --> réglé avec changement de la base

calcul du remboursement : chainage avec durée et type du prêt et vérifier conformité de la durée, faire une faisabilité, on calcule le remboursement mensualité = taux x montant/ 12 * durée (vérifier calcul)

Faire le menu interface
