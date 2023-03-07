AC_INIT(riscv-tests, 1.0)

cross_compiling=yes
AC_PROG_CC

AC_ARG_WITH(xlen,
        [AS_HELP_STRING([--with-xlen=XLEN],
                [Set XLEN, the X-register bit width (default is 64)])],
        AC_SUBST(XLEN, $withval),
        AC_SUBST(XLEN, 64)
        )

AC_ARG_WITH(ilm_base,
        [AS_HELP_STRING([--with-ilm-base=ILM_BASE],
                [Set ILM_BASE, the ilm base (default is 0)])],
        AC_SUBST(ILM_BASE, $withval),
        AC_SUBST(ILM_BASE, 0)
        )

AC_ARG_WITH(ilm_size,
        [AS_HELP_STRING([--with-ilm-size=ILM_SIZE],
                [Set ILM_SIZE, the ilm size (default is 1024)])],
        AC_SUBST(ILM_SIZE, $withval),
        AC_SUBST(ILM_SIZE, 1024)
        )

AC_ARG_ENABLE(rvc,
        AS_HELP_STRING([--enable-rvc=RVC],
		[Set RVC (default is no)]),
	AC_SUBST(RVC, $enableval),
	AC_SUBST(RVC, no)
        )
AC_ARG_ENABLE(rva,
        AS_HELP_STRING([--enable-rva=RVA],
		[Set RVA (default is no)]),
	AC_SUBST(RVA, $enableval),
	AC_SUBST(RVA, no)
        )
AC_ARG_ENABLE(rvf,
        AS_HELP_STRING([--enable-rvf=RVF],
		[Set RVF (default is no)]),
	AC_SUBST(RVF, $enableval),
	AC_SUBST(RVF, no)
        )
AC_ARG_ENABLE(rvd,
        AS_HELP_STRING([--enable-rvd=RVD],
		[Set RVD (default is no)]),
	AC_SUBST(RVD, $enableval),
	AC_SUBST(RVD, no)
        )
AC_ARG_ENABLE(s_mode,
        AS_HELP_STRING([--enable-s_mode=S_MODE],
		[Set S_MODE (default is no)]),
	AC_SUBST(S_MODE, $enableval),
	AC_SUBST(S_MODE, no)
        )
AC_ARG_ENABLE(mmu,
        AS_HELP_STRING([--enable-mmu=MMU],
		[Set MMU (default is no)]),
	AC_SUBST(MMU, $enableval),
	AC_SUBST(MMU, no)
        )

AC_OUTPUT(
    Makefile
)
