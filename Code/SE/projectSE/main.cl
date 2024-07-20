;; Inclusion des fichiers
(load "bdr.cl")
(load "getters.cl")
(load "verif.cl")
(load "fonctions_outil.cl")
(load "chainage_arriere.cl")
(load "chainage_avant.cl")


(defun menuBanque ()  
  (let ((choix_menu 1)
        (choix_pret nil))
    (while (member choix_menu '(1 2 3)) 
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
        (format t "~& Choix du type de pret (immobilier ou etudiant ou consommation): ") 
        (setq choix_pret (read))) 
    (cond
     ((= choix_menu 1) (fpret choix_pret))
      ((= choix_menu 2) (calculmensualite choix_pret))
     ((= choix_menu 3) (duree_remboursement choix_pret))
    ))))

    )
  (format t "fin de simulation"))



;; (menuBanque)
