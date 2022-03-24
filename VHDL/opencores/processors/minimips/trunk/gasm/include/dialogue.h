/*********************************************************************************************/
/* MODULE DIALOGUE                                                                           */
/* ce module a pour but d'afficher les erreurs rencontr�es lors de l'ex�cution du programme. */
/* Il peut s'agir d'erreurs fatales, correspondant � un plantage, ou d'erreurs de syntaxe    */
/* correspondant � une erreur de l'utilisateur, par exemple dans un fichier source.          */
/* Sont �galement g�r�s les avertissements et les indications en mode verbose.               */
/*                                                                                           */
/* Le module exporte des noms symboliques pour tous les codes d'erreurs et dispose de deux   */
/* points d'entr�es pour les deux types d'erreurs                                            */
/*                                                                                           */
/*********************************************************************************************/

#ifndef M_ERREUR_FLAG
#define M_ERREUR_FLAG

/*********************************************************************************************
 *   Identification de l'erreur                                                              *
 *********************************************************************************************/

/* Ce drapeau doit etre positionn� � chaque erreur rencontr�e                                */
extern int err_code;

/* Il faut garder � l'esprit que rien n'empeche un module d'utiliser les codes d'erreurs     *
 * qui ont � l'origine �t� cr��s pour un autre module.                                       */

#define NO_ERR 0        /* Pas d'erreur d�tect�e.                                            */

/* Erreurs fatales                                                                           */
#define F_FLUX_NULL     1       /* Tentative de lecture dans un flux NULL                    */
#define F_ERR_LECT      2       /* Erreur de lecture impr�visible                            */
#define F_ERR_OUV       3       /* Erreur d'ouverture de fichier impr�visible                */
#define F_ERR_MEM       4       /* Erreur d'allocation, m�moire insuffisante ?               */

/* Erreurs plutot du formateur                                                               */
#define S_ERR_FORMAT    301
#define S_INT_INVALID   302     /* Entier invalide                                           */
#define S_ALPHA_LONG    303     /* Alpha trop long                                           */
#define S_ALPHA_INVALID 304
#define S_CAR_INVALID   305

/* Erreurs plutot du pr�processeur                                                           */
#define S_CIRCULAR_FILE         401     /* Inclusion circulaire de fichiers                  */
#define S_CIRCULAR_MACRO        402     /* Appel circulaire de macros                        */
#define S_FICH_NON_TROUVE       403     /* Fichier sp�cifi� en argument introuvable          */
#define S_DEF_MACRO_EOF         404     /* Trois�me accolade fermante non rencontr�e         */
#define S_USE_MACRO_EOF         405     /* Trois�me accolade fermante non rencontr�e         */
#define S_NOM_MAC_INVALID       406     /* Nom de la macro dans sa d�claration invalide      */
#define S_NOM_INCFICH_INVALID   407     /* Nom du fichier � inclure invalide                 */
#define S_MAC_NO_MATCH          408     /* Macro incompatible avec sa d�finition             */
#define S_MAC_TROP_PARAM        409     /* Param�tres non utlis�s par la macro               */

/* Erreurs plutot du du preparateur                                                          */
#define S_ERR_DCL       501
#define S_DCL_VIDE      502
#define S_DCL_NON_TERM  503
#define S_BAD_PROP      504
#define S_BAD_VAL       505
#define S_BAD_FUN       506
#define S_BAD_ARG       507
#define S_DEP_SST       508     /* D�passement de la capacit� des sous-types.                */
#define S_DEP_FUNC_NB   510     /* D�passement du nombre maximal de fonctions allouables.    */
#define S_BAD_SST_DEC   511     /* D�claration du nb de sous-type manquante ou insuffisante. */
#define S_SEC_SST_DEC   512     /* Second appel � la commande SET SSTNUM non autoris�.       */
#define S_REDEF_INS     513     /* Une instruction est red�finie dans le fichier Syntaxe.    */

/* Erreurs pultot de l'analyseur                                                             */
#define S_SYN_ERR       601     /* Erreur de syntaxe dans le fichier source.                 */
#define S_FUN_ERR       602     /* Erreur lors de l'application des fonctions de l'adapt.    */
#define S_ADAP_ERR      603     /* Erreur de positionnement du eval_code par l'adaptateur.   */

/* Erreurs plutot de l'adaptateur.                                                           */
#define S_FUN_INAP              701     /* Erreur, fonction non applicable.                  */
#define S_ARG_INCOMP            702     /* Args incompatbiles, erreur dans fichier Syntaxe.  */
#define S_SIGNED_TL             703     /* Entier trop long pour un codage sign�             */
#define S_UNSIGNED_TL           704     /* Entier trop long pour le codage non-sign�         */
#define S_REDEF_ETIQ            705     /* Etiquette d�j� exisante.                          */
#define S_BAD_ETIQ              706     /* L'�tiquette n'existe pas dans la table.           */
#define S_ADR_INCONNUE          707     /* L'adresse d'implantation est ind�termin�e.        */
#define S_UNSIGNED_EXPECTED     708     /* Entier non sign� attendu                          */
#define S_BAD_ALIGN		709	/* Saut � une �tiquette non align�e sur 32 bits      */
#define S_TOO_FAR               710     /* Saut � une adresse trop �loign�e                  */

/* Erreurs plutot du synthetiseur.                                                           */

/* Warnings                                                                                  */
#define W_REGLE_TYPAGE          4001    /* R�gle invalide, ignor�e                           */
#define W_NO_LIST_INC           4002    /* La fonctionalit� include d�sactive la liste       */
#define W_NO_LIST_STDIN         4003    /* La lecture dans le flux standard aussi            */
#define W_REDEF_MAC             4004    /* Red�finition d'une macro                          */
#define W_UNDEF_NOMAC           4005    /* Tentative de suppression d'une macro non d�finie  */
#define W_REDEF_CODE            5001    /* R�utilisation du code, les sst seront les m�mes   */
#define W_REDEF_SST             5002    /* R�utilisation du nom de sous-type                 */
#define W_NO_SYNTAX             5004    /* Pas de fichier Syntax trouv�                      */
#define W_SEPLEX_INIT           6001    /* seplex non initialis� dans fichier Syntaxe        */
#define W_SRCE_MOD              8001    /* Le flux source a �t� modifi�                      */
#define W_ARG_INC               9001    /* Mauvaise utilisation des arguments                */
#define W_FICH_DEF_MACRO        9002    /* Fichier macro principal non ouvert                */
#define W_MACRO_MANQ            9003    /* Auncun fichier des macros par d�faut charg�       */

/* Commentaires.                                                                             */

/* Main                                                                                      */
#define B_INIT_SYNTAX           -901    /* Initialisation de la syntaxe de l'assembleur      */
#define B_INIT_MACRO            -902    /* Initialisation des macros par d�faut              */
#define B_LECT_SRC              -903    /* Lecture des sources..                             */
#define B_STR_OBJ               -904    /* Enregistrement du fichier objet...                */
#define B_STR_LST               -905    /* Creation de la liste d'assemblage...              */
#define B_ERR_REP               -906    /* Rapport d'erreurs :                               */
#define B_NBR_ERR_SYN           -907    /* erreurs d�tect�es lors de la synth�se             */
#define B_NBR_ERR_ANA           -908    /* erreurs d�tect�es lors de l'analyse               */
#define B_SYN                   -909    /* Analyse du code..                                 */
#define B_ANA                   -910    /* Synth�se..                                        */

/* Preparateur                                                                               */
#define B_CASSE                 -600    /* Basculement en mode sensible � la casse           */
#define B_NOCASSE               -601    /* Basculement en mode insensible � la casse         */
#define B_MAC_DEF               -602    /* D�tection d'un fichier de pseudo-instructions     */
#define B_INIT_D                -603    /* Activation du support des macros                  */
#define B_INIT_U                -604    /* Activation du support de la supression de macros  */
#define B_INIT_I                -605    /* Activation du support de l'inclusion de fichiers  */
#define B_INIT_SEP              -606    /* Initialisation du s�parateur d'instructions       */
#define B_PREP_SST              -607    /* Pr�paration pour l'ajout de sous-types            */
#define B_ADD_SST               -608    /* Nouveau sous-type d�tect�                         */

/* Adaptateur                                                                                */
#define B_TABLAB                -700    /* Table des �tiquettes                              */

/* Preprocesseur                                                                             */
#define B_NO_MACRO              -401    /* Aucune macro d�finie                              */
#define B_MACRO_DISPO           -402    /* Voici la liste des macros disponibles             */

/*********************************************************************************************
 *   G�n�ration des messages d'erreur                                                        *
 *********************************************************************************************/

/* Exportation du controleur de blabla.                                                      */
extern int verbose;

extern char sep_fich_inclus[];  /* "Inclus depuis"                                           */
char * search_msg(); /* Fonction de recherche du message correspondant au code d'erreur.     */
void display_help(); /* Fonction d'affichage de l'aide en ligne.                             */

void affiche_message(char * orig, int ligne);

#define DIALOGUE(ptr_org, ligne, code)\
{\
        err_code=code;\
        affiche_message(ptr_org, ligne);\
}
        
#endif
