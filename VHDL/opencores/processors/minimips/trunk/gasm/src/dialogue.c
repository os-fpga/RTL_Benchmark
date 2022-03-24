#include "dialogue.h"

#include <stdio.h>
#include <stdlib.h>

#include <debogueur.h>

int err_code=0;

int verbose=0;

/* Texte de l'aide en ligne.                                                                 */
char help[]="\n\
Assembleur pour le microprocesseur miniMIPS version 1.0\n\
Utilisation : asmips [options] [fichier]\n\
\n\
        Exemple : asmips -vo a.obj -l a.lst source.asm\n\
\n\
Options disponibles :\n\
\n\
        -v              active le mode verbeux\n\
\n\
        -n              d�sactive la liste d'assemblage\n\
\n\
        -o nom_fichier  nom du fichier de sortie, par d�faut a.obj\n\
\n\
        -p              assemble vers la sortie standard\n\
\n\
        -l nom_fichier  nom du fichier pour la liste d'assemblage\n\
                        par d�faut, a.lst est utilis�\n\
\n\
        -s nom_fichier  nom du fichier de syntaxe, par d�faut \'Syntaxe\'\n\
\n\
        -m nom_fichier  nom du fichier de macros par d�faut, contenant les\n\
                        pseudo-instructions de l'assembleur\n\
\n\
Notes d'utilisation :\n\
\n\
        Si aucun fichier d'entr�e n'est sp�cifi�, asmips tente d'assembler\n\
        l'entr�e standard. Ce mode n'est pas encore compatible avec la liste\n\
        d'assemblage qui sera donc automatiquement d�sactiv�e.\n\
\n\
        La s�lection du fichier de macro en ligne de commande est prioritaire\n\
        par rapport au fichier sp�cifi� par la syntaxe qui sera donc ignor�.\n\
\n\
Merci de signaler les �ventuels bugs � :\n\
\n\
        shangoue@enserg.fr\n\
        lmouton@enserg.fr\n\
";


typedef struct
{
        int code;
        char * chaine;
} type_paire_msg;

static type_paire_msg message[] =

{{ NO_ERR, "Pas d'erreur trouv�e" }
/* Erreurs g�n�riques :                                                                     */
,{ F_FLUX_NULL, "Tentative de lecture/�criture dans un flux NULL" }
,{ F_ERR_LECT, "Erreur de lecture impr�visible dans le flux" }
,{ F_ERR_OUV, "Erreur d'ouverture du fichier" }
,{ F_ERR_MEM, "Erreur d'allocation (m�moire insuffisante ?)" }
/* Erreurs du formateur :                                                                   */
,{ S_ERR_FORMAT, "Mauvaise utilisation d'un caract�re" }
,{ S_CAR_INVALID, "Caract�re non reconnu" }
,{ S_ALPHA_LONG, "Lex�me de type ALPHA trop long" }
,{ S_ALPHA_INVALID, "Caract�re non valide dans l'identificateur" }
,{ S_INT_INVALID, "Caract�re non valide dans l'entier" }
/* Erreurs du pr�processeur :                                                               */
,{ S_CIRCULAR_FILE, "Inclusion circulaire de fichier(s)" }
,{ S_CIRCULAR_MACRO, "Inclusion circulaire de macro" }
,{ S_FICH_NON_TROUVE, "Impossible d'ouvrir le fichier indiqu�" }
,{ S_DEF_MACRO_EOF, "Fin du fichier inattendue lors de la d�finition de macro" }
,{ S_USE_MACRO_EOF, "Fin du fichier inattendue lors de l'utlisation d'une macro" }
,{ S_NOM_MAC_INVALID, "Nom de la macro dans sa d�claration invalide" }
,{ S_NOM_INCFICH_INVALID, "Nom du fichier � inclure invalide" }
,{ S_MAC_NO_MATCH , "L'utilisation de la macro est incompatible avec sa d�finition" }
,{ S_MAC_TROP_PARAM, "Param�tre(s) non utlis�(s) dans la macro" }
/* Erreurs du pr�parateur :                                                                 */
,{ S_ERR_DCL, "D�claration incorrecte" }
,{ S_DCL_VIDE, "D�claration d'instruction vide" }
,{ S_DCL_NON_TERM, "D�claration d'instruction non termin�e '}' manquante" }
,{ S_REDEF_INS, "Instruction d�j� existante, la nouvelle d�claration sera ignor�e" }
,{ S_BAD_PROP, "Propri�t� incorrecte" }
,{ S_BAD_VAL, "Valeur de la propri�t� incorrecte" }
,{ S_BAD_FUN, "Fonction non d�finie" }
,{ S_BAD_ARG, "Mauvais argument pour la commande SET" }
,{ S_BAD_SST_DEC, "D�claration du nombre de sous-types absente ou insuffisante" }
,{ S_DEP_FUNC_NB, "D�passement de la capacit� d'enregistrement des fonctions" }
,{ S_DEP_SST, "D�passement de la capacit� de codage des sous-types" }
,{ S_SEC_SST_DEC, "R�p�tition de la commande SSTNUM non autoris�e" }
/* Erreurs de l'analyseur :                                                                 */
,{ S_SYN_ERR, "Erreur de syntaxe" }
,{ S_FUN_ERR, "Masques incompatibles dans la d�finition d'une instruction" }
,{ S_ADAP_ERR, "Erreur dans la valeur de retour d'une fonction de l'adaptateur" }
/* Erreurs de l'adaptateur :                                                                */
,{ S_FUN_INAP, "Fonction g�n�ratrice de masque inapplicable" }
,{ S_ARG_INCOMP, "Inad�quation des arguments avec une fonction de l'adaptateur" }
,{ S_SIGNED_TL, "Entier trop long pour le codage sign� sur les bits disponibles" }
,{ S_UNSIGNED_TL, "Entier trop long pour le codage non sign� sur les bits disponibles" }
,{ S_UNSIGNED_EXPECTED, "Entier non sign� attendu" }
,{ S_REDEF_ETIQ, "Red�finition d'�tiquette non prise en compte" }
,{ S_BAD_ETIQ, "Etiquette inexistante" }
,{ S_ADR_INCONNUE, "L'adresse d'implantation est ind�termin�e" }
,{ S_BAD_ALIGN, "Saut � une �tiquette non align�e sur 32 bits" }
,{ S_TOO_FAR, "Saut � une adresse n'appartenant pas � la r�gion courante de 256 Mo" }
/* Erreurs du synthetiseur.                                                                 */

/* Warnings :                                                                               */
,{ W_SEPLEX_INIT, "Valeur du s�parateur d'instruction non initialis� dans fichier Syntaxe" }
,{ W_REGLE_TYPAGE, "Regle de sous-typage invalide dans le fichier Syntaxe; elle est ignor�e" }
,{ W_ARG_INC, "Argument incorrect" }
,{ W_FICH_DEF_MACRO, "Le fichier des macros par d�faut n'a pas �t� trouv�" }
,{ W_MACRO_MANQ, "Auncun fichier des macros par d�faut charg�" }
,{ W_NO_LIST_INC, "L'utilisation des inclusions d�sactive la liste d'assemblage" }
,{ W_NO_LIST_STDIN, "La lecture dans le flux standard interdit la liste d'assemblage" }
,{ W_NO_SYNTAX, "Pas de fichier de syntaxe" }
,{ W_SRCE_MOD, "Flux source modifi�. Echec de la cr�ation de la liste d'assemblage" } 
,{ W_REDEF_MAC, "Red�finition d'une macro" }
,{ W_UNDEF_NOMAC, "Tentative de suppression d'une macro non d�finie" }
,{ W_REDEF_CODE, "R�utilisation du code, les sous-types seront confondus" }
,{ W_REDEF_SST, "Nom de sous-type existant, seule la premi�re d�finition sera accessible" }

/* Commentaires                                                                              */

/* Main                                                                                      */
,{ B_INIT_SYNTAX, "Initialisation de la syntaxe de l'assembleur..." }
,{ B_INIT_MACRO, "Chargement des pseudo-instructions..." }
,{ B_LECT_SRC, "Lecture des sources..." }
,{ B_STR_OBJ, "Enregistrement du fichier objet..." }
,{ B_STR_LST, "Creation de la liste d'assemblage..." }
,{ B_ERR_REP, "Rapport d'erreurs :" }
,{ B_NBR_ERR_SYN, "\tErreurs d�tect�es lors de la synth�se :" }
,{ B_NBR_ERR_ANA, "\tErreurs d�tect�es lors de l'analyse :" }
,{ B_SYN, "Synth�se..." }
,{ B_ANA, "Analyse du code..." }
/* Preparateur                                                                               */
,{ B_CASSE, "Basculement en mode sensible � la casse" }
,{ B_NOCASSE, "Basculement en mode insensible � la casse" }
,{ B_MAC_DEF, "D�tection d'un fichier de pseudo-instructions par d�faut dans la syntaxe" }
,{ B_INIT_D, "Activation du support des macros" }
,{ B_INIT_U, "Activation du support de la supression de macros" }
,{ B_INIT_I, "Activation du support de l'inclusion de fichiers" }
,{ B_INIT_SEP, "Initialisation du s�parateur d'instructions" }
,{ B_PREP_SST, "Pr�paration pour l'ajout de sous-types" }
,{ B_ADD_SST, "Nouveau sous-type d�tect�" }
/* Preprocesseur                                                                             */
,{ B_NO_MACRO, "Aucune macro d�finie." }
,{ B_MACRO_DISPO, "Macros disponibles :" }
/* Adaptateur                                                                                */
,{ B_TABLAB, "Table des �tiquettes :" }

/* Terminateur de la table, ne pas supprimer !                                               */
,{ 0, NULL }
};

char sep_fich_inclus[] = " inclus depuis ";

char * search_msg()
{
        type_paire_msg * pmsg=message;
        while(pmsg->chaine!=NULL)
        {
                if (pmsg->code==err_code) return pmsg->chaine;
                pmsg++;
        }
        return message->chaine;
}

void affiche_message(char * origine, int ligne)
{
        if (err_code>=1000)     /* Warning                                                   */
        {
                if (origine && ligne)
                        fprintf(stderr, "Attention ! \'%s\' : %d : %s.\n"
                                        , origine, ligne, search_msg());
                else if (origine)
                        fprintf(stderr, "Attention ! \'%s\' : %s.\n",  origine, search_msg());
                else
                        fprintf(stderr, "Attention ! %s.\n",  search_msg());
        }
        else if (err_code < 0)  /* Commentaire                                               */
        {
                if (verbose)
                {
                        if (origine && ligne)
                                fprintf(stderr, "-- \'%s\' : %d : %s\n"
                                                , origine, ligne, search_msg());
                        else if (origine)
                                fprintf(stderr, "-- %s %s\n", search_msg(), origine);
                        else
                                fprintf(stderr, "-- %s\n",  search_msg());
                }
        }
        else if (err_code<100)  /* Fatal Error                                               */
        {
                if (origine && ligne)
                        fprintf(stderr, "Erreur fatale ! \'%s\' : %d : %s.\n"
                                        , origine, ligne, search_msg());
                else if (origine)
                        fprintf(stderr, "Erreur fatale ! \'%s\' : %s.\n"
                                        , origine, search_msg());
                else
                        fprintf(stderr, "Erreur fatale ! %s.\n",  search_msg());
                exit(err_code);
        }
        else    /* Erreur de Syntaxe                                                         */
        {
                if (origine && ligne)
                        fprintf(stderr, "\'%s\' : %d : %s.\n"
                                        , origine, ligne, search_msg());
                else if (origine)
                        fprintf(stderr, "\'%s\' : %s.\n",  origine, search_msg());
                else
                        fprintf(stderr, "%s.\n",  search_msg());
        }
}

void display_help()
{ /* fonction d'affichage de l'aide en ligne.                                                */
        fprintf(stderr, help);
}
