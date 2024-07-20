(setq *bdr* 
      
'(( R1 ((eq profession CDD)) (eq situation stable))
( R2 ((eq profession fonctionnaire)) (eq situation stable))

( R3 ((>= critèreApport 2)) (eq situation stable))

( R4 ((> age 65) (> duree_pret 7)) (eq etatPret refuse))
( R5 ((> age 65) (eq assurance nil)) (eq etatPret refuse))

( R6 ((< endettement 35) (>= critèreApport 1) (eq situation stable)) (eq typePret Immobilier) )
( R19 ((eq typePret Immobilier)(<= duree_pret 27) (>= duree_pret 5) (>= montant 50000)) (eq etatPret accepte))
( R24 ((eq typePret Immobilier)) (>= montant 50000))
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
( R17 ((eq typePret Etudiant)) (= taux 2.00))
( R18 ((eq typePret Etudiant)) (<= duree_pret 10))
( R23 ((eq typePret Etudiant)) (>= duree_pret 2))
))

(setq *bdf2* '((profession CDD) (nationalite France)))
