#ifdef DEBUG
#ifndef M_DEBUG_FLAG
#define M_DEBUG_FLAG

/* La biblioth�que standard doit �tre incluse avant de d�ffinir les macros de remplacement   */
/* de malloc et free sinon leurs d�clarations deviennt fausses.                              */
#include <stdlib.h>
#include <stdio.h>

/* "Surcharge" des fonctions malloc et free.                                                 */
#define malloc(taille)  alloc_debug(taille, __LINE__, __FILE__)
#define free(ptr)       free_debug(ptr, __LINE__, __FILE__)

void * alloc_debug(int size, int lg, char * fc);
void free_debug(void * ptr, int lg, char * fc);
void print_mem(FILE * f);
extern int nalloc;

/* D�finition d'une macro pour l'enregistrement des pointeurs dans un fichier.               */
#define FPRINT_MALLOC   \
{\
        FILE * f;\
        f=fopen("malloc.debug", "wb");\
        print_mem(f);\
        fclose(f);\
}

#endif
#endif
