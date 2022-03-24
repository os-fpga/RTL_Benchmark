/*********************************************************************************************/
/* MODULE ANALYSEUR                                                                          */
/* Ce module a pour but de parcourir le fichier assembleur en effectuant la correspondance   */
/* du code source avec la syntaxe accept�e par le langage. La lecture se fait lex�me par     */
/* lex�me en utilisant le pr�processeur.                                                     */
/* Il se charge de g�n�rer la pile de pr�code qu sera utilis�e par le synt�thiseur pour      */
/* g�n�rer le code final.                                                                    */
/*********************************************************************************************/
#ifndef M_ANALYSEUR_FLAG
#define M_ANALYSEUR_FLAG

#include <parametres.h>
#include <adaptateur.h>
#include <preparateur.h>

typedef struct file_pcd_tmp
{
        type_mask * mask;               /* Masque d�j� g�n�r� � la premi�re passe.           */
        char nbr_func;                  /* Nombre de fonctions restant � appliquer.          */
        type_ptr_fgm * func;            /* Tableau des pointeurs vers ces fonctions.         */
        type_file_lexeme * param;       /* File de lex�mes ayant valid� l'intruction.        */
        char * fichier_orig;            /* Nom du fichier d'origine de l'instruction.        */
        int ligne_orig;                 /* Num�ro de la ligne de l'instruction.              */
        struct file_pcd_tmp * suivant;  /* Pointeur vers la suite de la file de precode.     */
        int erreur;                     /* Code d'erreur rencontr�.                          */
        int pco;                        /* Adresse d'implantation.                           */
} type_precode;


extern type_precode * file_precode;     /* Pointeur vers la file de pr�code g�n�r�e.         */

int analyse();                          /* Point d'entr�e principal du module.               */
void clear_analyseur();                 /* Fonction de nettoyage/r�initialisation du module. */

/* Macro d'allocation et d'initialisation d'un pr�code.                                      */
#define ALLOC_PREC(prec)        \
{\
        prec = (type_precode *) malloc(sizeof(type_precode));\
        if (prec==NULL) DIALOGUE(msg_orig, 0, F_ERR_MEM);\
        prec->fichier_orig=NULL;\
        prec->ligne_orig=0;\
        prec->mask=NULL;\
        prec->nbr_func=0;\
        prec->func=NULL;\
        prec->param=NULL;\
        prec->suivant=NULL;\
        prec->erreur=NO_ERR;\
}

/* Cette macro lib�re l'espace allou� pour une file de lex�mes.                              */
#define FREE_ARGS(args) \
{\
        type_file_lexeme * courant=args, * suivant;\
        while (courant!=NULL)\
        {\
                suivant=courant->suivant;\
                FREE_LEX(courant->lexeme);\
                free(courant);\
                courant=suivant;\
        }\
        args=NULL;\
}

/* Cette macro lib�re l'espace allou� pour un pr�code.                                       */
#define FREE_PRECODE(precode)   \
{\
        if (precode->mask) FREE_MASK(precode->mask);\
        if (precode->nbr_func!=0 && precode->func!=NULL) free(precode->func);\
        FREE_ARGS(precode->param);\
        if (precode->fichier_orig) free(precode->fichier_orig);\
        if (precode->func) free(precode->func);\
        free(precode);\
}

/* Cette macro efface et lib�re le contenu d'un pr�code mais pas la structure elle_m�me.     */
/* On conserve toutefois les informations sur l'origine.                                     */
#define CLEAR_PRECODE(precode)  \
{\
        if (precode->mask) FREE_MASK(precode->mask);\
        precode->mask=NULL;\
        if (precode->nbr_func!=0 && precode->func!=NULL) free(precode->func);\
        precode->func=NULL;\
        FREE_ARGS(precode->param);\
        precode->param=NULL;\
        precode->nbr_func=0;\
}       


/* Cette macro peut �tre utilis�e pour �crire un masque sous forme "lisible".                */
#define FPRINT_BIN(f, ptrmask)  \
{\
        int i;\
        if (ptrmask)\
        {\
                for (i=8*ptrmask->taille-1;i>=0;i--)\
                        fprintf(f, "%c",((ptrmask->valeur>>i) % 2) ? '1' : '0');\
        }\
}

#endif
