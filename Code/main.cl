;; Inclusion des fichiers
(load "bdr.cl")
(load "getters.cl")
(load "verif.cl")
(load "fonctions_outil.cl")
(load "chainage_arriere.cl")
(load "chainage_avant.cl")


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