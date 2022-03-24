#include "parametres.h"

#include <stdio.h>

#include <debogueur.h>
#include <formateur.h>

/* Variables d'environnement.                                                                */
int active_list=1;              /* Activation de la lsite d'assemblage.                      */
int pco=0; /* D�finition du pseudo compteur ordinal.                                         */

/* Variables positionn�es par le pr�parateur � la lecture du fichier syntaxe.                */
int casse_sens = 1;             /* Sensibilit� de la syntaxe � la casse.                     */
char * fich_macro_def=NULL;     /* Nom du fichier de macros par d�faut.                      */
char * define_str=NULL;         /* Chaine de caract�res pour la d�claration de macros.       */
char * include_str=NULL;        /* Chaine de caract�res pour la directive d'inclusion.       */
char * undef_str=NULL;          /* Chaine de caract�res pour la suppression de macros.       */
type_lexeme * seplex=NULL;      /* Lex�me s�parateur entre les diff�rentes instructions.     */
int nbr_sous_types=0;           /* Nombre de sous types admis par la syntaxe.                */
type_paire *regle_typage=NULL;  /* Table des r�gles et des codes de chaque sous-type.        */
