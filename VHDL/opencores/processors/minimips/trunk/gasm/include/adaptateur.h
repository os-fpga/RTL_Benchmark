/* Module adaptateur */
#ifndef M_ADAPTATEUR_FLAG
#define M_ADAPTATEUR_FLAG

/* Autres modules du projet utilis�s.                                                        */
#include <parametres.h>
#include <stdio.h>

/*********************************************************************************************/
/*                                 DEFINITION DU TYPE MASQUE                                 */
/* D�finition du type mask                                                                   */
/*********************************************************************************************/

typedef short int type_taille_mask;
typedef unsigned long type_valeur_mask;
typedef struct
{
        type_taille_mask taille;        /* taille du masque en octets.                       */
        type_valeur_mask valeur;        /* valeur du masque sur 64 bits.                     */
} type_mask;

/* Comme l'allocation de masques sera une op�ration tr�s fr�quente, on pourra utiliser la    */
/* macro suivante pour simplifier le code.                                                   */
#define ALLOC_MASK(msk) {\
                                msk = ((type_mask *) malloc(sizeof(type_mask)));\
                        }

#define FREE_MASK(msk)  {\
                                free(msk);\
                        }

/*********************************************************************************************/
/*                        EXPORTATION DES FONCTIONS DE L'ADAPTATEUR                          */
/*********************************************************************************************/

/* D�finition du type pointeur vers une fonction g�n�ratrice de masque.                      */
typedef type_mask *((*type_ptr_fgm)());

type_ptr_fgm alias(char *);     /* Retourne le pointeur sur la fonction � partir du nom.     */
void clear_adaptateur();        /* Fonction de cloture de l'adaptateur.                      */
void write_data(FILE * f_lst);  /* Ecriture d'informations dans la lsite.                    */

extern int eval_code;           /* Drapeau pour le r�sultat de l'�valuation d'une fgm.       */

/* D�finition des diff�rents types d'erreur d'�valuation.                                    */
#define EVAL_REUSSIE    0       /* Evaluation r�ussie.                                       */
#define EVAL_IMPOSSIBLE 1       /* Evaluation impossible (fonction de seconde passe ?)       */
#define EVAL_ERREUR     2       /* Erreur lors de l'�valuation (fichier Syntaxe incorrect ?) */

#endif
