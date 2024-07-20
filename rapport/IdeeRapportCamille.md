Lexique : (>= age 18) >= : comparateur, age : terme, 18 : valeur

Sujet : SE pour l’aide à la réalisation de prêts bancaires. 
En tant qu’étudiant, on peut avoir à réaliser un prêt étudiant. Pour ce faire, quelques critères sont a remboursés. Mais avant tout, ce qui nous intéresse est le montant que l’on aura à rembourser par mois une fois que l’on sera diplomé, une partie de notre futur salaire sera dédiée au remboursement du prêt et il est nécessaire de savoir à quel niveau sera-t-il .
Il est souvent compliqué de savoir si l’on est éligible à tel ou tel prêt. Si nos revenus sont suffisants pour supporter le remboursement d’un prêt sur le long terme. 
L’interface finale est dédiée à tout particulier souhaitant réaliser un prêt, pas seulement pour le personnel bancaire. 
La source experte provient de nombreux sites internet, que ce soit des banques ou de simulateur préexistants. Les différents sites consultés sont référencés dans les sources.
Nous avons décidé de traiter les prêts immobilier, étudiant et à la consommation. 
A partir de cette source d’expertise, nous avons pu créer notre base de règles. La bdr regroupe, pour chaque type de prêt, les caractéristiques permettant sa réalisation ainsi que tous les attributs qui le concerne, càd ; taux, montant min et max, durée min et max.
TO DO : INSERER L’ARBRE DE DEDUCTION
Avec cette bdr nous avons décidé de réaliser un menu proposant 3 choix. Le premier étant pour tester la faisabilité du prêt :
	Dans la fonction fpret, on réalise un chainage arrière afin de savoir si les informations rentrées par l’utilisateur permettent d’arriver à la conclusion (eq etatPret accepte). Ce chainage arrière s’effectue en profondeur sur la bdr puisqu’il parcours les règles comportant la conclusion (eq typePret credit) (eq situation stable) (eq typePret ‘immobilier ou ‘etudiant ou ‘consommation) et (eq statut français). Avant de réaliser ce chainage arrière, on effectue un autre chainage arrière sur la conclusion (eq etatPret refuse) pour vérifier si l’utilisateur n’a pas entré d’informations qui pouvait compromettre son prêt, notamment un age avancé. 
Ensuite, le menu propose le calcul de la mensualité :
	La fonction calculmensualité permet pour un type de prêt donné et une durée de récupérer à l’aide d’un chainage avant le taux correspondant afin de calculer le montant que l’emprunteur aura à rembourser chaque mois. A noter que cette fonction est utilisée dans la première partie du menu également. 
Enfin, la troisième proposition permet de fournir une durée pour le remboursement d’un prêt :
	La fonction duree_remboursement calcule la durée nécessaire de remboursement d’un prêt à l’aide d’un montant et d’un critère de mensualité donné. Ce critère de mensualité définit le montant que l’emprunteur souhaite rembourser par mois. 

D’autres fonctions annexes sont employées dans ces fonctions. On retrouve notamment les getters qui permettent à l’aide d’un read l’information rentrée par l’utilisateur pour chaque type de donnée voulue.
Les checkers vérifient à l’aide d’un chainage avant si le montant (resp la durée) correspond bien au min et au max de chaque type de prêt. 
Le chinage arrière est réalisé grâce à la combinaison de la fonction verfier_ou et vérifier_et. Verifier_ou permet de vérifier si la bdf permet de vérifier au moins une règle comportant le but voulu. Elle fait appel (à chaque « ou ») à vérifier_et qui vérifie pour chaque règle si la bdf vérifie toutes les prémisses de la règle.  
Pour des fins d’explicabilité, nous avons modifié la fonction vérifier_et et ajouté une variable globale dernier_enr qui nous permet d’enregister la règle qui n’a pas aboutit au succès du chainage avant. De ce fait, dans la fonction fpret, un affichage permet d’indiquer pourquoi le prêt n’est pas faisable. Cela permet d’enrichir l’utilisateur, qui sait alors quel critère ne correspond pas afin de pouvoir le modifier si possible.
Le chainage avant parcours toutes la bdr, si une règle se vérifie avec la bdf grace à la fonction verif_regle alors quand le premier parcours de la bdr sera fini, il faudra recommencer puisque la bdf sera enrichie. Lorsqu’une conclusion comportant le terme recherché est atteinte, on ajoute la conclusion à une liste résultat qui sera renvoyée à la fin de l’exécution de la fonction.
Par exemple, si on veut récupérer la durée min et max d’un prêt etudiant la liste résultat contiendra : ((>= duree_pret 2)(<= duree_pret 10)) ainsi il ne reste plus qu’à vérifier si la durée entrée par l’utilisateur est comprise entre ces deux durées, c’est sur ce principe que fonctionnent les checkers. 

TODO : mettre des exemples d’utilisation pour chaque fonction décrite ci-dessus (je considère que ccl_regle et les trucs comme ça ne sont pas intéressants à détailler d’autant plus qu’on les a vu en cours).
