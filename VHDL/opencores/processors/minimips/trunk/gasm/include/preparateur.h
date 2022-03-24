/*********************************************************************************************/
/* MODULE PREPARATEUR                                                                        */
/* ce module a pour but de lire le fichier Syntaxe du programme et de g�n�rer l'arbre des    */
/* lex�mes qui lui correspond.                                                               */
/*                                                                                           */
/* Le seul point d'acc�s de ce module est la fonction init_arbre qui re�oit le nom du        */
/* fichier Syntaxe � utiliser.                                                               */
/*                                                                                           */
/*********************************************************************************************/

#ifndef M_PREPA_FLAG
#define M_PREPA_FLAG

#include <formateur.h>
#include <parametres.h>
#include <adaptateur.h>

/*********************************************************************************************/
/*                              DEFINITION DE L'ARBRE DE LEXEMES                             */
/* D�finition de l'arbre de lex�mes g�n�r� par le pr�parateur et des autres types auquels il */
/* se rapporte.                                                                              */
/*********************************************************************************************/

/* D�finition de la feuille de l'arbre.                                                      */
typedef struct
{
        type_mask * mask_primaire;      /* masque primaire du codage.                        */
        char nbr_func;                  /* nombre de fonctions.                              */
        type_ptr_fgm * ptr_func;        /* adresse du d�but du tableau des fonctions.        */
} type_feuille;

/* D�finition de la structure arbre elle-m�me.                                               */
typedef struct noeud_arbre
{
        type_lexeme lexeme;
        struct noeud_arbre * ptr_fils;
        struct noeud_arbre * ptr_frere;
        type_feuille * ptr_feuille;
} type_noeud;

#define ALLOC_FEUILLE(feuille)  \
{\
        feuille=(type_feuille *) malloc(sizeof(type_feuille));\
        if (feuille==NULL) DIALOGUE(msg_orig, 0, F_ERR_MEM);\
        feuille->mask_primaire=NULL;\
        feuille->nbr_func=0;\
        feuille->ptr_func=NULL;\
}

#define FREE_FEUILLE(feuille)   \
{\
        if (feuille->mask_primaire!=NULL) FREE_MASK(feuille->mask_primaire);\
        if (feuille->ptr_func!=NULL) free(feuille->ptr_func);\
        free(feuille);\
}       

#define ALLOC_NOEUD(noeud)      \
{\
        noeud=(type_noeud *) malloc(sizeof(type_noeud));\
        if (noeud==NULL) DIALOGUE(msg_orig, 0, F_ERR_MEM);\
        noeud->lexeme.type=0;\
        noeud->lexeme.valeur.op=0;\
        noeud->ptr_fils=NULL;\
        noeud->ptr_frere=NULL;\
        noeud->ptr_feuille=NULL;\
}

#define FREE_NOEUD(noeud)       \
{\
        if (noeud->ptr_feuille!=NULL) FREE_FEUILLE(noeud->ptr_feuille);\
        free(noeud);\
}


/* Exportation de la racine de l'arbre des lex�mes.                                          */
extern type_noeud * root;


/* Nombre maximal de fonctions pour une instruction dans le fichier Syntaxe.                 */
#define MAX_FONCTIONS           16

int init_arbre(char * fichier_syntaxe);
void clear_preparateur();

#endif
