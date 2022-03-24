/*********************************************************************************************/
/* MODULE PREPARATEUR                                                                        */
/* ce module a pour but de lire le fichier Syntaxe du programme et de g�n�rer l'arbre des    */
/* lex�mes qui lui correspond.                                                               */
/*                                                                                           */
/* Le seul point d'acc�s de ce module est la fonction init_arbre qui re�oit le nom du        */
/* fichier Syntaxe � utiliser.                                                               */
/*                                                                                           */
/*********************************************************************************************/

#include "preparateur.h"

/* Inclusion des modules de la biblioth�que standard.                                        */
#include <stdio.h>
#include <string.h>

/* Inclusion des autres modules utilis�s du projet.                                          */
#include <debogueur.h>
#include <parametres.h>
#include <dialogue.h>
#include <formateur.h>
#include <adaptateur.h>

/* Ces macros sont utilis�es pour les comparaisons de chaines. Leur valeur d�termine la     */
/* sensibilit� ou non du pr�parateur � la casse lors de la lecture du fichier Syntaxe.      */
#define string_comp     strcasecmp
#define lexeme_comp     lexcaseid       

type_noeud *root = NULL;        /* D�finition de la racine de l'arbre des lex�mes.           */

/* Num�ro de ligne et fichier Syntaxe courant.                                               */
static int ligne=1;
static char * n_fich;
static FILE * f_syn;

/*********************************************************************************************/
/*                                                                                           */
/* D�finition des objets d�crivant la syntaxe et l'organisation du fichier Syntaxe. On       */
/* trouve :                                                                                  */
/*                                                                                           */
/*      la table des mots clefs, qui contient les valeurs sp�cifiant un type de lex�me.      */
/*      la table des propri�t�s, regroupant le nom des diff�rentes propri�t�s.               */
/*      la table des fonctions qui peuvent �tre ex�cut�es � la lecture du fichier Syntaxe.   */
/*                                                                                           */
/*********************************************************************************************/
        
        
/* TABLES DES MOTS CLEF                                                                      */
typedef struct 
{
        char * nom;
        type_type_lex code;
} type_table;

/* Table statique des mots clefs correspondant aux types de base.                            */
#define NUM_KEYWORD     2       /* Nombre de mots clef reconnus par le pr�parateur.          */
static type_table table_clef_base[NUM_KEYWORD] =
        { { "alpha"     , ALPHA}
        , { "int"       , NUM}
        };

/* Table dynamique des mots clefs correspondant aux sous types.                              */
static type_table * table_clef_sst=NULL;


/* TABLE DES PROPRIETES                                                                      */
#define NUM_PROP        3
static char *prop_table[NUM_PROP] =
        {       "TMO"
        ,       "MSK"
        ,       "FUN"
        };
enum {TMO, MSK, FUN}; /* Codes symboliques pour les diff�rentes propri�t�s.                 */


/* TABLE DES FONCTIONS                                                                      */
/* D�finition des fonctions de param�trage du preparateur. Elles seront ex�cut�es � la      */
/* demande du fichier Syntaxe lors de la rencontre de l'instruction SET.                    */

/* En cas d'erreur, ces fonctions renvoient 1 et positionnent la variable errcode du module */
/* erreur. La fonction appelante se charge de l'affichage de l'erreur.                      */

int casse()
{
        casse_sens = 1;
        DIALOGUE(NULL, 0, B_CASSE);
        return 0;
}

int nocasse()
{
        casse_sens = 0;
        DIALOGUE(NULL, 0, B_NOCASSE);
        return 0;
}

int macrofile() /* Cette fonction lit le nom du fichier macro par d�faut et l'enregistre.    */
{       
        long pos=ftell(f_syn);
        type_lexeme * l;
        
        DIALOGUE(NULL, 0, B_MAC_DEF);

        l=get_lexeme(f_syn);
        if (l==NULL) 
        {
                err_code=S_BAD_ARG;
                return 1;
        }
        if (!TYPE_IS(l, ALPHA) || !LIT_MPV(l->type))
        {
                FREE_LEX(l);
                fseek(f_syn,pos-ftell(f_syn),SEEK_CUR); /* On "remet" le lex�me.             */
                err_code=S_BAD_ARG;
                return 1;
        }
        
        if (fich_macro_def!=NULL) free(fich_macro_def);
        fich_macro_def=l->valeur.alpha;
        /* On supprime la valeur du lex�me pour que la chaine ne soit pas lib�r�e.           */
        l->type=RET_MPV(l->type);
        FREE_LEX(l);
        
        err_code = NO_ERR;
        return 0;
}

int setdefine()
{
        long pos=ftell(f_syn);
        type_lexeme * lex;

        DIALOGUE(NULL, 0, B_INIT_D);
        
        lex=get_lexeme(f_syn);
        if (lex==NULL) 
        { /* Erreur de lecture de l'argument.                                                */
                err_code=S_BAD_ARG;
                return 1;
        }
        if (!TYPE_IS(lex,ALPHA)) 
        { /* L'argument n'a pas le bon type.                                                 */
                FREE_LEX(lex);
                fseek(f_syn,pos-ftell(f_syn),SEEK_CUR); /* On "remet" le lex�me.             */
                err_code=S_BAD_ARG;
                return 1;
        }
        if (define_str!=NULL) free(define_str);
        define_str=malloc(strlen(lex->valeur.alpha)+1);
        strcpy(define_str, lex->valeur.alpha);
        FREE_LEX(lex);

        err_code = NO_ERR;
        return 0;
}

int setundef()
{
        long pos=ftell(f_syn);
        type_lexeme * lex;

        DIALOGUE(NULL, 0, B_INIT_U);
        
        lex=get_lexeme(f_syn);
        if (lex==NULL) 
        { /* Erreur de lecture de l'argument.                                                */
                err_code=S_BAD_ARG;
                return 1;
        }
        if (!TYPE_IS(lex,ALPHA)) 
        { /* L'argument n'a pas le bon type.                                                 */
                FREE_LEX(lex);
                fseek(f_syn,pos-ftell(f_syn),SEEK_CUR); /* On "remet" le lex�me.             */
                err_code=S_BAD_ARG;
                return 1;
        }
        if (undef_str!=NULL) free(undef_str);
        undef_str=malloc(strlen(lex->valeur.alpha)+1);
        strcpy(undef_str, lex->valeur.alpha);
        FREE_LEX(lex);

        err_code = NO_ERR;
        return 0;
}

int setinclude()
{
        long pos=ftell(f_syn);
        type_lexeme * lex;
        
        DIALOGUE(NULL, 0, B_INIT_I);

        lex=get_lexeme(f_syn);
        if (lex==NULL) 
        {
                err_code=S_BAD_ARG;
                return 1; /* Erreur de lecture de l'argument.                                */
        }
        if (!TYPE_IS(lex,ALPHA)) /* L'argument n'a pas le bon type.                          */
        {
                FREE_LEX(lex);
                fseek(f_syn,pos-ftell(f_syn),SEEK_CUR); /* On "remet" le lex�me.             */
                err_code=S_BAD_ARG;
                return 1;
        }
        
        if (include_str!=NULL) free(include_str);
        include_str=malloc(strlen(lex->valeur.alpha)+1);
        strcpy(include_str, lex->valeur.alpha);
        FREE_LEX(lex);

        err_code = NO_ERR;
        return 0;
}

int setsep()
{
        type_lexeme * lex;
        lex=get_lexeme(f_syn);
        
        DIALOGUE(NULL, 0, B_INIT_SEP);
        
        if (lex==NULL)
        { 
                err_code=S_BAD_ARG;
                return 1;
        }
        if (seplex!=NULL) FREE_LEX(seplex);
        if (TYPE_IS(lex, OP) && lex->valeur.op==NL) ligne++;
        seplex=lex;

        err_code = NO_ERR;
        return 0;
}

int sst_max=0; /* Nombre maximal de sous-types r�serv�s dans la table.                       */

int setnumsst()
{
        long pos=ftell(f_syn);
        type_lexeme * lex;

        DIALOGUE(NULL, 0, B_PREP_SST);

        if (table_clef_sst!=NULL) /* R�utilisation de SSTNUM.                                */
        {
                err_code = S_SEC_SST_DEC;
                return 1;
        }
        
        lex=get_lexeme(f_syn);
        if (lex==NULL) 
        { /* Erreur de lecture de l'argument.                                                */
                err_code=S_BAD_ARG;
                return 1;
        }
        if (!TYPE_IS(lex,NUM))   /* L'argument n'a pas le bon type.                          */
        {
                FREE_LEX(lex);
                fseek(f_syn,pos-ftell(f_syn),SEEK_CUR); /* On "remet" le lex�me.             */
                err_code=S_BAD_ARG;
                return 1;
        }
        sst_max=lex->valeur.num;

        FREE_LEX(lex);
        /* Allocation des tables locales et globale des sous types.                          */
        regle_typage = (type_paire *) malloc(sst_max*sizeof(type_paire));
        if (regle_typage==NULL) DIALOGUE("preparateur(setnumsst)", 0, F_ERR_MEM);
        table_clef_sst = (type_table*) malloc(sst_max*sizeof(type_table));
        if (table_clef_sst==NULL) DIALOGUE("preparateur(setnumsst)", 0, F_ERR_MEM);

        err_code = NO_ERR;
        return 0;
}

int setnewsst()
{
        long pos=ftell(f_syn);
        type_lexeme * lex;
        char * nom, *filtre;
        type_type_lex code;
        int i, bk=0;
        
        DIALOGUE(NULL, 0, B_ADD_SST);
        
        /* V�rification que la d�claration du nombre de sous-types est valide.               */
        if (regle_typage==NULL || table_clef_sst==NULL || nbr_sous_types>=sst_max)
        {
                err_code=S_BAD_SST_DEC;
                return 1;
        }
        
        /* Lecture du mot clef correspondant au sous-type.                                   */
        lex=get_lexeme(f_syn);
        if (lex==NULL) 
        {
                err_code=S_BAD_ARG;
                return 1; /* Erreur de lecture de l'argument.                                */
        }
        if (!TYPE_IS(lex,ALPHA)) /* L'argument n'a pas le bon type.                          */
        {
                FREE_LEX(lex);
                fseek(f_syn,pos-ftell(f_syn),SEEK_CUR); /* On "remet" le lex�me.             */
                err_code=S_BAD_ARG;
                return 1;
        }
        /* Ajout du mot clef.                                                                */
        nom = lex->valeur.alpha;
        /* On supprime la valeur pour qu'elle ne soit pas lib�r�e par FREE_LEX.              */
        lex->type=RET_MPV(lex->type);   
        FREE_LEX(lex);

        
        /* Lecture de la r�gle de typage correspondant au sous-type.                         */
        lex=get_lexeme(f_syn);
        if (lex==NULL) 
        {
                err_code=S_BAD_ARG;
                return 1; /* Erreur de lecture de l'argument.                                */
        }
        if (!TYPE_IS(lex,ALPHA)) /* L'argument n'a pas le bon type.                          */
        {
                FREE_LEX(lex);
                free(nom);
                fseek(f_syn,pos-ftell(f_syn),SEEK_CUR); /* On "remet" le lex�me.             */
                err_code=S_BAD_ARG;
                return 1;
        }
        /* Ajout de la r�gle � la table.                                                     */
        filtre=lex->valeur.alpha;
         /* On supprime la valeur pour qu'elle ne soit pas lib�r�e par FREE_LEX.             */
        lex->type=RET_MPV(lex->type);   
        FREE_LEX(lex);

        /* Lecture du code correspondant au sous-type.                                       */
        lex=get_lexeme(f_syn);
        if (lex==NULL) 
        {
                err_code=S_BAD_ARG;
                return 1; /* Erreur de lecture de l'argument.                                */
        }
        if (!TYPE_IS(lex,NUM))   /* L'argument n'a pas le bon type.                          */
        {
                FREE_LEX(lex);
                free(nom);
                free(filtre);
                fseek(f_syn,pos-ftell(f_syn),SEEK_CUR); /* On "remet" le lex�me.             */
                err_code=S_BAD_ARG;
                return 1;
        }
        /* V�rification de la valeur du code demand�.                                        */
        if (lex->valeur.num<0 || lex->valeur.num>MAX_SOUS_TYPES)
        { /* Le nombre de sous-types codables est limit�...                                  */
                FREE_LEX(lex);
                free(nom);
                free(filtre);
                err_code=S_DEP_SST;
                fseek(f_syn,pos-ftell(f_syn),SEEK_CUR); /* On "remet" le lex�me.             */
                return 1;
        }
        code=CODE_TYPE(lex->valeur.num);
        FREE_LEX(lex);
        
        for (i=0 ; i<nbr_sous_types ; i++) 
        { /* Avertissements �ventuels si il y a red�finition du nom ou du type.              */
                /* V�rifiction que le code n'est pas d�j� attribu� � un autre sous-type.     */
                if (!bk && table_clef_sst[i].code==code 
                                && string_comp(table_clef_sst[i].nom, nom))
                { /* Avertissement, le m�me sous-type a deux noms diff�rents.                */
                        DIALOGUE(nom, 0, W_REDEF_CODE);
                        bk=1; /* On s'assure que le message n'est affich� qu'uns fois.       */
                }

                /* V�rification que le nom n'est pas d�j� attribu�.                          */
                if (!bk && table_clef_sst[i].code!=code 
                                && !string_comp(table_clef_sst[i].nom, nom))
                { /* Avertissement, le nom est d�j� utilis�.                                 */
                        DIALOGUE(nom, 0, W_REDEF_SST);
                        bk=1; /* On s'assure que le message n'est affich� qu'uns fois.       */
                }
        }
        
        /* Mise � jour des valeurs lues dans les tables locale et globale.                   */
        table_clef_sst[nbr_sous_types].nom=nom;
        table_clef_sst[nbr_sous_types].code=code;
        regle_typage[nbr_sous_types].chaine=filtre;
        regle_typage[nbr_sous_types].code=code;
        
        nbr_sous_types++; /* Incr�mentation du nombre de sous types effectivement d�clar�s.  */
        
        err_code=NO_ERR;
        return 0;
}

#define SET             "SET"   /* Nom symbolique de la commande SET.                        */
#define NUM_FONC        9

/* Dans cette structure, on stocke les diff�rents couples commande/fonction. On peut ainsi   */
/* facilement ajouter de nouvelles commandes de description de la syntaxe sans avoir �       */
/* modifier la fonction principale de g�n�ration de l'arbre.                                 */
struct 
{
        char * nom;
        int (*fonction)();
} fonc_table[NUM_FONC] =
        {       { "CASSE"       , &casse}
        ,       { "NOCASSE"     , &nocasse}     
        ,       { "MACROFILE"   , &macrofile}
        ,       { "UNDEFSTR"    , &setundef}
        ,       { "DEFINESTR"   , &setdefine}
        ,       { "INCLUDESTR"  , &setinclude}
        ,       { "SEP"         , &setsep}
        ,       { "NUMSST"      , &setnumsst}
        ,       { "NEWSST"      , &setnewsst}
        };

/* Cette macro r�initialise les variables � positionner par le pr�parateur. Elle est appel�e */
/* � chaque initialisation d'arbre de lex�mes (lecture de fichier syntaxe).                  */

#define REINIT  \
{\
        if (table_clef_sst!=NULL)\
        { /* Vidage de la table des sous types.                                             */\
                int i;\
                for (i=0 ; i<nbr_sous_types ; i++) free(table_clef_sst[i].nom);\
                free(table_clef_sst);\
        }\
        table_clef_sst=NULL;\
        if (fich_macro_def!=NULL) free(fich_macro_def);\
        fich_macro_def=NULL;\
        if (define_str!=NULL) free(define_str);\
        define_str=NULL;\
        if (undef_str!=NULL) free(undef_str);\
        undef_str=NULL;\
        if (include_str!=NULL) free(include_str);\
        include_str=NULL;\
        if (seplex!=NULL) FREE_LEX(seplex);\
        seplex=NULL;\
        if (regle_typage!=NULL)\
        {\
                for ( ; nbr_sous_types>0 ; nbr_sous_types--)\
                        free(regle_typage[nbr_sous_types-1].chaine);\
                free(regle_typage);\
                regle_typage=NULL;\
        }\
        casse_sens=1;\
        sst_max=0;\
        nbr_sous_types=0;\
}


/*********************************************************************************************/
/* FONCTION place_lexeme                                                                     */
/*                                                                                           */
/* type_noeud * place_lexeme(type_lexeme * l, type_noeud * cur_root)                         */
/*                                                                                           */
/* Cette fonction re�oit un lex�me et un noeud. Elle recherche le lex�me dans les fils du    */
/* noeud et si elle le trouve, elle renvoie un pointeur sur lui, sinon elle le cr�e et       */
/* renvoie ce nouveau pointeur.                                                              */
/*                                                                                           */
/*********************************************************************************************/

type_noeud * place_lexeme(type_lexeme * l, type_noeud * cur_root)
{
        char * msg_orig="pr�parateur(place_lexeme)";
        type_noeud * cur_fils = (cur_root->ptr_fils);

        while (cur_fils != NULL)
        {
                if (lexeme_comp(l, &(cur_fils->lexeme))) return cur_fils;
                cur_fils = cur_fils->ptr_frere;
        }
        ALLOC_NOEUD(cur_fils);
        cur_fils->ptr_frere = cur_root->ptr_fils;
        LEX_COPY(l, &(cur_fils->lexeme));
        cur_root->ptr_fils = cur_fils;
        return cur_fils;
}


/*********************************************************************************************/
/* FONCTION lit_feuille                                                                      */
/*                                                                                           */
/* type_feuille * lit_feuille(FILE * f_syn)                                                  */
/*                                                                                           */
/* Cette fonction re�oit le fichier Syntaxe ouvert � la bonne position et lit les            */
/* diff�rentes propri�t�s qui s'y trouve. A partir de cette lecture, elle cr�e une feuille   */
/* pour les enregistrer et renvoie un pointeur vers celle-ci. En cas d'erreur, un pointeur   */
/* NULL est retourn� et le fichier est laiss� � la position de l'erreur.                     */
/*                                                                                           */
/*********************************************************************************************/

#define OPERATEUR       (TYPE_IS(lex, OP))
#define VAL_OP          ((lex->valeur).op)
#define VAL_ALPHA       ((lex->valeur).alpha)

#define ERR_LF(val)     {\
                                if (lex!=NULL) FREE_LEX(lex);\
                                if (mask_ptr!=NULL) FREE_MASK(mask_ptr);\
                                DIALOGUE(n_fich, ligne, val);\
                                return NULL;\
                        }
/* Comme la lecture d'une feuille n'est pas sensible a la pr�sence de sauts de ligne, la    */
/* macro suivante se charge de les �liminer. La terminaison est assur�e par EOF.            */
/* La macro commence par lib�rer l'espace du lex�me pr�c�dent sauf si celui-ci est NULL.    */
#define LIT_LEXEME      {\
                                do\
                                {\
                                        if (lex!=NULL) FREE_LEX(lex);\
                                        lex=get_lexeme(f_syn);\
                                        if (lex==NULL) ERR_LF(err_code)\
                                        if (OPERATEUR && VAL_OP==NL) ligne++;\
                                }\
                                while (OPERATEUR && VAL_OP==NL);\
                        }

#define INIT_MASK       {\
                                if (mask_ptr==NULL)\
                                {\
                                        ALLOC_MASK(mask_ptr);\
                                        mask_ptr->taille=0;\
                                        mask_ptr->valeur=0;\
                                }\
                                if (mask_ptr==NULL)\
                                        DIALOGUE("pr�parateur(lit_feuille)", 0, F_ERR_MEM);\
                        }

type_feuille * lit_feuille()
{
        char * msg_orig="preparateur(lit_feuille)";
        int i, c, tmo_lu=0, i_fun=0;
        type_valeur_mask tmp_msk=0;
        type_lexeme * lex=NULL;
        type_ptr_fgm fun_ptr[MAX_FONCTIONS];
        type_mask * mask_ptr=NULL;
        type_feuille * tmp_feuille;

        LIT_LEXEME /* Lit le premier lex�me diff�rent de NL.                                 */
        while (!OPERATEUR || (VAL_OP!=EOF && VAL_OP!=ACO))
        {
                if (!TYPE_IS(lex, ALPHA)) ERR_LF(S_BAD_PROP);
                /* D�termination de la propri�t�.                                            */
                i=-1;
                while (++i<NUM_PROP && string_comp(prop_table[i], VAL_ALPHA));
                if (i==NUM_PROP) ERR_LF(S_BAD_PROP); /* Propri�t� inexistante.               */
                switch (i)
                { /* lecture de la valeur de la propri�t�.                                   */
                        case TMO :      LIT_LEXEME;
                                        if (!TYPE_IS(lex,NUM)) ERR_LF(S_BAD_VAL);
                                        INIT_MASK;
                                        tmo_lu=1;
                                        mask_ptr->taille=(lex->valeur).num;
                                        break;
                        case MSK :      LIT_LEXEME;
                                        if (!TYPE_IS(lex,ALPHA)||VAL_ALPHA[0]!='_') 
                                                ERR_LF(S_BAD_VAL);
                                        INIT_MASK;
                                        i=1; tmp_msk=0;
                                        while ((c=VAL_ALPHA[i++])!='\0')
                                        {
                                                if (c!='0' && c!='1')
                                                {
                                                        if (c!='_') ERR_LF(S_BAD_VAL);
                                                }
                                                else
                                                {
                                                        tmp_msk<<=1;
                                                        tmp_msk+=(c-'0');
                                                }
                                        }
                                        (mask_ptr->valeur)|=tmp_msk;
                                        break;
                        case FUN :      if (i_fun==MAX_FONCTIONS) ERR_LF(S_DEP_FUNC_NB);
                                        LIT_LEXEME;
                                        if (!TYPE_IS(lex,ALPHA)) ERR_LF(S_BAD_VAL);
                                        fun_ptr[i_fun]=alias(VAL_ALPHA);
                                        if (fun_ptr[i_fun]==NULL)
                                        { /* Fonction inexistante.                          */
                                                ERR_LF(S_BAD_FUN); 
                                        }
                                        i_fun++;
                                        break;
                        default :       return NULL;
                }
                LIT_LEXEME;
        }

        FREE_LEX(lex);
        ALLOC_FEUILLE(tmp_feuille);
        if (!tmo_lu && mask_ptr!=NULL)
        { /* On ignore le masque si il n'a pas de taille sp�cifi�e.                          */
                FREE_MASK(mask_ptr);
                mask_ptr=NULL;
        }
        tmp_feuille->mask_primaire=mask_ptr;
        
        /* Recopie de la liste des fonctions de g�n�ration de masque.                        */
        tmp_feuille->nbr_func=i_fun;
        if (i_fun)
        {
                tmp_feuille->ptr_func=(type_ptr_fgm *) (malloc(i_fun*sizeof(type_ptr_fgm)));
                if (tmp_feuille->ptr_func==NULL) 
                        DIALOGUE("pr�parateur(lit_feuille)", 0, F_ERR_MEM);
                while ((i_fun--)>0) 
                {
                        tmp_feuille->ptr_func[i_fun] = fun_ptr[i_fun];
                }
        }
        else    tmp_feuille->ptr_func=NULL;
        
        return tmp_feuille;
}


/*********************************************************************************************/
/* FONCTION init_arbre                                                                       */
/*                                                                                           */
/* int init_arbre(char * fichier_syntaxe)                                                    */
/*                                                                                           */
/* Cette fonction re�oit le nom du fichier Syntaxe, l'ouvre et y lit les informations. Elle  */
/* les utilise pour mettre � jour l'arbre des lex�mes d�fini dans le commun (root). Les      */
/* erreurs de format sont signal�es.                                                         */
/* La valeur de retour est le nombre d'erreurs rencontr�es.                                  */ 
/*                                                                                           */
/*********************************************************************************************/

int init_arbre(char * fichier_syntaxe)


#define ERREUR(val)     {\
                                DIALOGUE(fichier_syntaxe, ligne, val);\
                                err=1;\
                        }
/* Lecture d'un lex�me non NULL, au pire EOF, tout en comptant les lignes.                   */
/* Le lex�me pr�c�dent est lib�r� sauf s'il est NULL.                                        */
#define LIT_VALIDE      {\
                                if (lex!=NULL) FREE_LEX(lex);\
                                while ((lex=get_lexeme(f_syn))==NULL)\
                                {\
                                        err=1;\
                                        ERREUR(err_code);\
                                }\
                                if (OPERATEUR && VAL_OP==NL) ligne++;\
                        }
/* Recherche de la prochaine accolade ouvrante (instruction suivante)                        */
#define ACO_SUIV        do LIT_VALIDE while (!OPERATEUR || (VAL_OP!=ACO && VAL_OP!=EOF))
#define LIGNE_SUIV      do LIT_VALIDE while (!OPERATEUR || (VAL_OP!=NL  && VAL_OP!=EOF))

{
        char * msg_orig="preparateur(init_arbre)";
        type_lexeme * lex=NULL;
        int err=0,gblerr=0; /* err est vrai lors d'une erreur, gblerr s'il y a eu une erreur */
        type_noeud * courant;
        type_feuille * feuille=NULL;

        /* R�initialisation des diff�rentes variables locales et globales.                   */
        REINIT;
        ALLOC_NOEUD(root);
                
        f_syn=fopen(fichier_syntaxe, "rb"); /* ouverture du fichier Syntaxe.                     */
        if (f_syn==NULL)
        {
                DIALOGUE(NULL, 0, W_NO_SYNTAX);
                return 0;
        }
        
        n_fich = fichier_syntaxe; /* Positionne  la variable commune au module.              */
        ligne=1; /* Initialisation du num�ro de ligne au d�but du fichier.                   */

        do  /* Lecture du fichier Syntaxe jusqu'� la premi�re accolade ouvrante.             */
        {
                LIT_VALIDE;
                if (TYPE_IS(lex, ALPHA) && !string_comp(VAL_ALPHA, SET))
                { /* On a rencontr� une commande SET, lecture des arguments.                 */
                        int i=-1;
                        LIT_VALIDE;
                        if (!TYPE_IS(lex, ALPHA)) 
                        {
                                ERREUR(S_BAD_ARG);
                                gblerr++;
                                LIGNE_SUIV;
                        }
                        else 
                        {
                                while (++i<NUM_FONC && /* Recherche de la fonction.          */ 
                                        string_comp(fonc_table[i].nom, VAL_ALPHA));
                                if (i==NUM_FONC) 
                                { /* La fonction demand�e n'existe pas.                      */
                                        ERREUR(S_BAD_ARG);
                                        gblerr++;
                                        LIGNE_SUIV;
                                }
                                else if (fonc_table[i].fonction()) 
                                { /* Les param�tres de la fonction sont mal sp�cifi�s.       */
                                        affiche_message(fichier_syntaxe, ligne);
                                        gblerr++;
                                        LIGNE_SUIV;
                                }
                        }
                }
                else if (!OPERATEUR || (VAL_OP!=ACO && VAL_OP!=EOF && VAL_OP!=NL)) 
                { /* Si on a un lex�me interdit (erreur dans le fichier Syntaxe).            */
                        gblerr++;
                        ERREUR(S_SYN_ERR);
                        LIGNE_SUIV; /* On ne tient pas compte de la ligne erron�e.           */
                }
        } while (!OPERATEUR || (VAL_OP!=ACO && VAL_OP!=EOF));

        do /* Lecture des diff�rentes instructions.                                          */
        {
                courant=root;   
                err=0;
                LIT_VALIDE;
                if (OPERATEUR && VAL_OP==EOF) err=2;
                if (OPERATEUR && VAL_OP==ACF) ERREUR(S_DCL_VIDE) /* D�claration vide.        */
                else while ((!OPERATEUR || VAL_OP!=ACF) && !err)
                { /* Placer les lex�mes dans l'arbre jusqu'� ACF.                            */
                        if (LIT_MPV(lex->type) && TYPE_IS(lex, ALPHA))
                        { /* Si on a un mot clef, on ajuste le type (on supprime la valeur)  */
                                int i, key=0;
                                /* Recherche dans les mots clef de base.                     */
                                for (i=0 ; i<NUM_KEYWORD && !key ; i++)
                                if (!string_comp(table_clef_base[i].nom, VAL_ALPHA))
                                {
                                        lex->type=table_clef_base[i].code;
                                        key=1;
                                }
                                /* Recherche dans les mots clef des sous-types.              */
                                for (i=0 ; i<nbr_sous_types && !key ; i++)
                                if (!string_comp(table_clef_sst[i].nom, VAL_ALPHA))
                                {
                                        lex->type=table_clef_sst[i].code;
                                        key=1;
                                }
                                if (key) free(lex->valeur.alpha);
                        }
                        courant = place_lexeme(lex, courant);
                        LIT_VALIDE;
                        if (OPERATEUR && VAL_OP==EOF) ERREUR(S_DCL_NON_TERM);
                }

                /* Red�finition d'une instruction d�j� lue.                                  */
                if (courant->ptr_feuille!=NULL) ERREUR(S_REDEF_INS);
                
                if (!err) feuille=lit_feuille(); /* Lecture de la feuille.                   */
                if (feuille==NULL) err=1; /* Le message d'erreur est g�r� � la lecture.      */
        
                /* Si la lecture est r�ussie, il faut m�moriser la nouvelle instruction.     */
                if (!err) courant->ptr_feuille=feuille;
                else ACO_SUIV; /* Erreur de lecture, on passe � l'instruction suivante.      */
                gblerr+=(err==1); /* Le code d'erreur est uniquement 1.                      */
        }
        while (!OPERATEUR ||  VAL_OP!=EOF);
        FREE_LEX(lex);
        fclose(f_syn);
        return gblerr;
}

/* Fonction de lib�ration des structures contenues dans un arbre.                            */
void free_arbre(type_noeud * courant)
{
        type_noeud * fils_courant;

        if (courant==NULL) return;
        fils_courant=courant->ptr_fils;
        while (fils_courant!=NULL)
        { /* On efface r�cursivement tous les sous arbres.                                   */
                free_arbre(fils_courant);
                fils_courant=fils_courant->ptr_frere;
        }
        /* On efface le champ valeur des lex�mes ALPHA.                                      */
        if (TYPE_IS(&(courant->lexeme), ALPHA) && LIT_MPV(courant->lexeme.type) 
                && (courant->lexeme.valeur.alpha!=NULL)) 
                free(courant->lexeme.valeur.alpha);
        FREE_NOEUD(courant);
}

/* Fonction de lib�ration des structures cr�es par init_arbre.                               */
void clear_preparateur()
{
        free_arbre(root);
        root=NULL; /* root a �t� lib�r� par la fonction free_arbre.                          */
        REINIT;
}

