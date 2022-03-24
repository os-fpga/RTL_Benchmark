/*********************************************************************************************/
/* MODULE ANALYSEUR                                                                          */
/* Ce module a pour but de parcourir le fichier assembleur en effectuant la correspondance   */
/* du code source avec la syntaxe accept�e par le langage. La lecture se fait lex�me par     */
/* lex�me en utilisant le pr�processeur.                                                     */
/* Il se charge de g�n�rer la pile de pr�code qu sera utilis�e par le synt�thiseur pour      */
/* g�n�rer le code final.                                                                    */
/*********************************************************************************************/

#include "analyseur.h"

/* Inclusion des autres modules du projet utilis�s.                                          */
#include <debogueur.h>
#include <parametres.h>
#include <dialogue.h>
#include <formateur.h>
#include <preprocesseur.h>
#include <adaptateur.h>

type_precode * file_precode=NULL, * fin_file_precode=NULL;

int nprc_alloc=0; /* Compteur du nombre de pr�codes allou�s.                                 */

/* fonctions de filtrage et de comparaison des lex�mes (sensibles ou non � la casse).        */
#define filtre(l, filtre)       filtre_lexeme(l, filtre, casse_sens)
#define compare_lexeme(l1, l2)  (casse_sens ? lexid(l1, l2) : lexcaseid(l1,l2))

/* Pointeur sur la file de lex�mes composant l'argument courant.                             */
static type_file_lexeme * ptr_arg=NULL;

/* ajoute le lex�me sur la pile de lex�mes locale (instruction en cours).                    */
void push_local(type_lexeme * l)
{
        type_file_lexeme * nouv;

        nouv = (type_file_lexeme *) malloc(sizeof(type_file_lexeme));
        if (nouv==NULL) DIALOGUE("analyseur(push_local)", 0, F_ERR_MEM);

        nouv->suivant=ptr_arg;
        nouv->lexeme=l;
        ptr_arg=nouv;
}

/* Fonction r�cursive d'analyse du code assembleur.                                          */
type_feuille * analyse_rec(type_noeud * n_cour)
{
        type_lexeme * l_cour;
        type_noeud * fils_cour;

        l_cour=pop_lexeme();    /* Lecture d'un lex�me par le pr�processeur.                 */
        fils_cour=n_cour->ptr_fils;

        while (fils_cour!=NULL && l_cour!=NULL)
        {
                if (filtre(l_cour, &(fils_cour->lexeme)))
                { /* Les lex�mes sont compatibles.                                           */
                        type_feuille * rescur;
                        rescur=analyse_rec(fils_cour);
                        if (rescur!=NULL) 
                        {  /* Validation de la transition.                                   */
                                push_local(l_cour);     /* Ajout dans la file locale.        */
                                return rescur;
                        }
                }
                /* La transition n'est pas valid�e.                                          */
                fils_cour=fils_cour->ptr_frere; /* On passe � la transition suivante.        */
        }
        
        push_lexeme(l_cour);            /* Le lex�me est rendu au pr�processeur.             */
        return (n_cour->ptr_feuille);   /* Si la feuille est valide, l'instruction l'est.    */
}

/*********************************************************************************************/
/*                                                                                           */
/* Point d'entr�e principal du module, fonction d'analyse. Les donn�es analys�es sont celles */
/* fournies par le pr�processeur qui doit �tre pr�alablement initialis�.                     */
/*                                                                                           */
/*********************************************************************************************/

/* Macro d'initialisation d'un nouveau pr�code.                                              */
#define INIT_PRECODE(precode)   \
{\
        ALLOC_PREC(precode)\
        precode->fichier_orig=f_orig;\
        precode->ligne_orig=l_orig;\
        precode->pco=pco;\
}

/* Macro d'ajout d'un pr�code en queue de la file.                                           */
#define EMPILE_PRECODE(precode) \
{\
        if (file_precode==NULL)\
        {\
                file_precode=precode;\
                fin_file_precode=precode;\
        }\
        else\
        {\
                fin_file_precode->suivant=precode;\
                fin_file_precode=precode;\
        }\
}

int analyse()
{
        int err=0;
        char * msg_orig = "analyseur(analyse)";
        type_lexeme * lex;

        pco = 0; /* Initialisation du pseudo compteur ordinal.                               */

        if (seplex == NULL)
        { /* Utilisation du s�parateur par d�faut.                                           */
                DIALOGUE(NULL, 0, W_SEPLEX_INIT);
                seplex=(type_lexeme *) malloc(sizeof(type_lexeme));
                if (seplex==NULL) DIALOGUE(msg_orig, 0, F_ERR_MEM);
                seplex->type = POS_MPV(OP);
                seplex->valeur.op = NL;
        }

        while ((lex = pop_lexeme())!=NULL) /* Analyse jusqu'� la fin du fichier.             */
        {
                int l_orig = ligne_courante();  /* On conserve la ligne de l'instruction.    */
                char * f_orig = gen_orig_msg(); /* On conserve le fichier d'origine.         */
                type_feuille * feuille;

                push_lexeme(lex);               /* On rend le lex�me au pr�preocesseur.      */
                feuille = analyse_rec(root);    /* Analyse de l'instruction suivante.        */

                if (feuille==NULL)
                { /* L'instruction n'a pas �t� reconnue.                                     */
                        type_lexeme * lex_depile;
                        type_precode * err_pcd;
                        INIT_PRECODE(err_pcd);
                        err++;                  /* D�tection d'une erreur de syntaxe.        */
                        err_pcd->erreur=S_SYN_ERR; /* Mise � jour du code d'erreur.          */
                        EMPILE_PRECODE(err_pcd); /* Empilage du lex�me erreur.               */

                        DIALOGUE(f_orig, l_orig, S_SYN_ERR);

                        while ((lex_depile=pop_lexeme())!=NULL
                                        && !compare_lexeme(lex_depile, seplex))
                        { /* On recherche le prochain lex�me de s�paration.                  */
                                FREE_LEX(lex_depile);
                        }
                        if (lex_depile!=NULL) FREE_LEX(lex_depile); /* Efface le "seplex".   */
                }
                else
                { /* L'instruction a �t� valid�e. G�n�ration du pr�code.                     */
                        type_precode * pcd;
                        int p2f[MAX_FONCTIONS]; /* tableau des fonctions de seconde passe.   */
                        int i;
                        INIT_PRECODE(pcd);

                        /* Recopie de la file des lex�mes ayant valid� l'instruction.        */
                        pcd->param = ptr_arg;

                        /* Recopie du masque de la feuille.                                  */
                        if (feuille->mask_primaire==NULL) pcd->mask=NULL;
                        else
                        {
                                ALLOC_MASK(pcd->mask);
                                if (pcd->mask==NULL)
                                        DIALOGUE(msg_orig, 0, F_ERR_MEM);
                                pcd->mask->valeur=feuille->mask_primaire->valeur;
                                pcd->mask->taille=feuille->mask_primaire->taille;
                        }

                        for (i=0 ; i<feuille->nbr_func ; i++)
                        { /* Tentative d'application des fonctions de l'adaptateur.          */
                                type_mask *  res = (feuille->ptr_func)[i](ptr_arg);

                                /* Diff�rents cas de r�ponse de l'adaptateur.                */
                                switch (eval_code)
                                {
                                case EVAL_REUSSIE    :  /* Evalutation r�ussie.              */
                                        if (pcd->mask==NULL) 
                                        {
                                                pcd->mask=res; /* Pas encore de masque.      */
                                                res=NULL; /* Evite que le masque soit vid�.  */
                                                break;
                                        }
                                        if (res==NULL) break; /* Rien � faire.               */
                                        if (res->taille==pcd->mask->taille)
                                        { /* On ajoute le nouveau masque.                    */
                                                pcd->mask->valeur|=res->valeur;
                                                break;
                                        }
                                        /* Le masque retourn� est incompatible.              */
                                        DIALOGUE(f_orig, l_orig, S_FUN_ERR);
                                        CLEAR_PRECODE(pcd); /* Le pr�code est une erreur.    */
                                        pcd->erreur=S_FUN_ERR;
                                        err++;
                                        break;
                                case EVAL_IMPOSSIBLE :  /* Fonction de seconde passe.        */
                                        p2f[(int)(pcd->nbr_func)++]=i;
                                        break;
                                case EVAL_ERREUR     :  /* Erreur de l'adaptateur/Syntaxe.   */
                                        affiche_message(f_orig, l_orig);
                                        err++;
                                        CLEAR_PRECODE(pcd); /* Le pr�code est une erreur.    */
                                        pcd->erreur=err_code;
                                        break;
                                default              :  /* Erreur de l'adaptateur.           */
                                        DIALOGUE(f_orig, l_orig, S_ADAP_ERR);
                                        CLEAR_PRECODE(pcd);
                                        pcd->erreur=S_ADAP_ERR;
                                        err++;
                                        break;
                                }
                                if (res!=NULL) FREE_MASK(res); /* Suppression du masque.     */
                        }

                        if (pcd->nbr_func!=0) /* Recopie des pointeurs vers les p2f.         */
                        { /* Il reste des fonctions de seconde passe.                        */
                                pcd->func=(type_ptr_fgm*) /* On cr�e le tableau.             */
                                        malloc((pcd->nbr_func)*sizeof(type_ptr_fgm));
                                for (i=0; i<pcd->nbr_func; i++)
                                { /* On recopie les fonctions de seconde passe.              */
                                        (pcd->func)[i]=(feuille->ptr_func)[p2f[i]];
                                }
                        }
                        else 
                        { /* Plus de fonctions de seconde passe, effacement des arguments.   */
                                pcd->func = NULL;
                                FREE_ARGS(pcd->param);
                        }

                        if ((pcd->mask==NULL || pcd->mask->taille==0) && pcd->func==NULL
                                        && pcd->erreur==NO_ERR)
                        { /* On supprime le pr�code s'il est vide.                           */
                                FREE_PRECODE(pcd);
                        }
                        else 
                        {
                                EMPILE_PRECODE(pcd);
                                if (pcd->mask!=NULL) pco+=pcd->mask->taille;
                        }

                        ptr_arg=NULL; /* R�initialisation du pointeur de file de lex�mes.    */
                }
        }
        return err;
}

/* Cette fonction lib�re les structures de pr�code allou�es lors de l'analyse. Les donn�es   */
/* non �crites par le synth�tiseur seront perdues.                                           */
void clear_analyseur()
{
        while (file_precode!=NULL)
        {
                type_precode * pcd=file_precode;
                file_precode=pcd->suivant;
                FREE_PRECODE(pcd);
        }
        fin_file_precode=NULL;
}
