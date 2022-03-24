#ifndef M_PARAMETRES_FLAG
#define M_PARAMETRES_FLAG

#include <formateur.h>

/*********************************************************************************************/
/* MODULE CONTENANT LES VARIABLES D'ENVIRONNEMENT                                            */
/*********************************************************************************************/

/* D�claration de variables globales concernant la syntaxe de l'assembleur                   */

/* Sous-typage des lex�mes ALPHA :                                                           */
typedef struct
{
        type_type_lex code;
        char * chaine;
} type_paire;

extern type_paire * regle_typage;

#define MAX_SOUS_TYPES 15 /* Nombre maximum de sous types codables.                          */

/* Sensibilit� � la casse (oui par d�faut)                                                   */
extern int casse_sens;

/* Nom du fichier de macro � inclure par d�faut en d�but de code                             */
extern char * fich_macro_def;

/* Chaines de caract�res pour les directives pr�processeur.                                  */
extern char * include_str;
extern char * define_str;
extern char * undef_str;

/* Variables pour la d�finition des sous-types.                                              */
extern int nbr_sous_types;

/* Lex�me s�parateur d'instructions.                                                         */
extern type_lexeme * seplex;

/* Variables globales utilis�es par le programme.                                            */

/* Exportation du pseudo compteur ordinal.                                                   */
extern int pco;

/* Activation de la lsite d'assemblage.                                                      */
extern int active_list;

#endif
