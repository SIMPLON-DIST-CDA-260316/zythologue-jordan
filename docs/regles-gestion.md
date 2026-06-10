| Utilisateur                                                                  |
| ---------------------------------------------------------------------------- |
| Un utilisateur peut consulter les différentes bières                         |
| Un utilisateur peut consulter les différentes brasseries                     |
| Un utilisateur peut mettre aucune, une ou des bières en favoris              |
| Un utilisateur peut mettre aucune, une ou des brasseries en favoris          |
| Un utilisateur peut mettre au maximum un avis sur une bière                  |
| Un utilisateur peut mettre au maximum un avis sur une brasserie              |
| Un utilisateur doit avoir un email unique                                    |
| Un utilisateur doit avoir son mot de passe hashé                             |
| Un utilisateur doit avoir son âge calculé à partir de sa date de naissance   |
| Un utilisateur doit avoir au moins 18 ans                                    |
| Un même utilisateur ne peut pas mettre deux fois la même bière en favori     |
| Un même utilisateur ne peut pas mettre deux fois la même brasserie en favori |
| Un même utilisateur ne peut pas laisser plusieurs avis sur la même bière     |
| Un même utilisateur ne peut pas laisser plusieurs avis sur la même brasserie |
| Si un utilisateur est supprimé, ses avis et favoris le sont aussi            |

| Bière                                                                          |
| ------------------------------------------------------------------------------ |
| Une bière peut être mise en favoris par aucun, un ou plusieurs utilisateurs    |
| Une bière peut recevoir aucun, un ou plusieurs avis                            |
| Une bière peut appartenir à une ou plusieurs catgories                         |
| Une bière peut être illustrée par aucune, une ou plusieurs photos              |
| Une bière doit être produite par une seule brasserie                           |
| Une bière doit contenir plusieurs ingrédients                                  |
| Une bière doit appartenir à au moins une catégorie                             |
| Le taux d'alcool d'une bière ne peut pas être négatif                          |
| Le prix d'une bière ne peut pas être négatif                                   |
| Si une bière est supprimée, ses avis, mises en favoris et photos le sont aussi |

| Photo bière                              |
| ---------------------------------------- |
| Une photo doit illustrer une seule bière |

| Photo brasserie                              |
| -------------------------------------------- |
| Une photo doit illustrer une seule brasserie |

| Catégorie                                                    |
| ------------------------------------------------------------ |
| Une catégorie peut comporter aucune, une ou plusieurs bières |

| Brasserie                                                                                  |
| ------------------------------------------------------------------------------------------ |
| Une brasserie peut produire aucune, une ou plusieurs bières                                |
| Une brasserie peut être mise en favoris par aucun, un ou plusieurs utilisateurs            |
| Une brasserie peut être illustrée par aucune, une ou plusieurs photos                      |
| Si une brasserie est supprimée, ses bières, avis, mises en favoris et photos le sont aussi |

| Ingrédient                                                   |
| ------------------------------------------------------------ |
| Un ingrédient peut concerner aucune, une ou plusieurs bières |

| Journal bière                                                                                                |
| ------------------------------------------------------------------------------------------------------------ |
| Toute insertion d'une bière doit être automatiquement enregistrée dans le journal                            |
| Une entrée de journal doit référencer la bière insérée                                                       |
| Une entrée de journal doit conserver le nom de la bière au moment de l'insertion                             |
| Une entrée de journal doit enregistrer l'horodatage exact de l'insertion                                     |
| Une entrée de journal ne peut pas être modifiée après sa création                                            |
| Une entrée de journal ne peut pas être supprimée manuellement                                                |
| Si une bière est supprimée, ses entrées de journal le sont aussi (CASCADE)                                   |
| L'enregistrement dans le journal est déclenché automatiquement par la base de données, pas par l'application |

| Avis Bière                                                               |
| ------------------------------------------------------------------------ |
| Un avis peut avoir un commentaire (facultatif)                           |
| Un avis doit concerner une seule bière                                   |
| Un avis doit avoir obligatoirement une note                              |
| La note d'un avis doit être comprise entre 1 et 10                       |
| Un avis ne peut être émis que par un utilisateur                         |
| Un même utilisateur ne peut pas laisser plusieurs avis sur la même bière |

| Avis Brasserie                                                               |
| ---------------------------------------------------------------------------- |
| Un avis peut avoir un commentaire (facultatif)                               |
| Un avis doit concerner une seule brasserie                                   |
| Un avis doit avoir obligatoirement une note                                  |
| La note d'un avis doit être comprise entre 1 et 10                           |
| Un avis ne peut être émis que par un utilisateur                             |
| Un même utilisateur ne peut pas laisser plusieurs avis sur la même brasserie |
