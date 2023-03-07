/**********************************************************/
/* Date: Mon, 10 Mar 1997 07:38:18 -0500                  */
/* From: Roy Longbottom <Roy_Longbottom@compuserve.com>   */
/* Subject: WHET02.txt                                    */
/* To: "Alfred A. Aburto Jr." <aburto@cts.com>            */
/**********************************************************/

/*
 *     C/C++ Whetstone Benchmark Single or Double Precision
 *
 *     Original concept        Brian Wichmann NPL      1960's
 *     Original author         Harold Curnow  CCTA     1972
 *     Self timing versions    Roy Longbottom CCTA     1978/87
 *     Optimisation control    Bangor University       1987/90
 *     C/C++ Version           Roy Longbottom          1996
 *     Compatibility & timers  Al Aburto               1996
 *
 ************************************************************
 *
 *              Official version approved by:
 *
 *         Harold Curnow  100421.1615@compuserve.com
 *
 *      Happy 25th birthday Whetstone, 21 November 1997
 *
 ************************************************************
 *
 *     The program normally runs for about 100 seconds
 *     (adjustable in main - variable duration). This time
 *     is necessary because of poor PC clock resolution.
 *     The original concept included such things as a given
 *     number of subroutine calls and divides which may be
 *     changed by optimisation. For comparison purposes the
 *     compiler and level of optimisation should be identified.
 *
 ************************************************************
 *
 *     The original benchmark had a single variable I which
 *     controlled the running time. Constants with values up
 *     to 899 were multiplied by I to control the number
 *     passes for each loop. It was found that large values
 *     of I could overflow index registers so an extra outer
 *     loop with a second variable J was added.
 *
 *     Self timing versions were produced during the early
 *     days. The 1978 changes supplied timings of individual
 *     loops and these were used later to produce MFLOPS and
 *     MOPS ratings.
 *
 *     1987 changes converted the benchmark to Fortran 77
 *     standards and removed redundant IF statements and
 *     loops to leave the 8 active loops N1 to N8. Procedure
 *     P3 was changed to use global variables to avoid over-
 *     optimisation with the first two statements changed from
 *     X1=X and Y1=Y to X=Y and Y=Z. A self time calibrating
 *     version for PCs was also produced, the facility being
 *     incorporated in this version.
 *
 *     This version has changes to avoid worse than expected
 *     speed ratings, due to underflow, and facilities to show
 *     that consistent numeric output is produced with varying
 *     optimisation levels or versions in different languages.
 *
 *     Some of the procedures produce ever decreasing numbers.
 *     To avoid problems, variables T and T1 have been changed
 *     from 0.499975 and 0.50025 to 0.49999975 and 0.50000025.
 *
 *     Each section now has its own double loop. Inner loops
 *     are run 100 times the loop constants. Calibration
 *     determines the number of outer loop passes. The
 *     numeric results produced in the main output are for
 *     one pass on the outer loop. As underflow problems were
 *     still likely on a processor 100 times faster than a 100
 *     MHZ Pentium, three sections have T=1.0-T inserted in the
 *     outer loop to avoid the problem. The two loops avoid
 *     index register overflows.
 *
 *     The first section is run ten times longer than required
 *     for accuracy in calculating MFLOPS. This time is divided
 *     by ten for inclusion in the MWIPS calculations.
 *
 *     This version has facilities for typing in details of the
 *     particular run. This information is appended to file
 *     whets.res along with the results. The input section can
 *     be avoided using a command line parameter N (for example
 *     Whets.exe N).
 *
 *     Roy Longbottom  101323.2241@compuserve.com
 *
 ************************************************************
 *
 *     Whetstone benchmark results are available in whets.tbl
 *     from ftp.nosc.mil/pub/aburto. The results include
 *     further details of the benchmarks.
 *
 ************************************************************
 *
 *     Source code is available in C/C++, Fortran, Basic and
 *     Visual Basic in the same format as this version. Pre-
 *     compiled versions for PCs are also available via C++.
 *     These comprise optimised and non-optimised versions
 *     for DOS, Windows and NT.
 *
 *     This version compiles and runs correctly either as a
 *     C or CPP program with a WATCOM and Borland compiler.
 *
 ************************************************************
 *
 * Example of initial calibration display (Pentium 100 MHz)
 *
 * Single Precision C/C++ Whetstone Benchmark
 *
 * Calibrate
 *      0.17 Seconds          1   Passes (x 100)
 *      0.77 Seconds          5   Passes (x 100)
 *      3.70 Seconds         25   Passes (x 100)
 *
 * Use 676  passes (x 100)
 *
 * 676 passes are used for an approximate duration of 100
 * seconds, providing an initial estimate of a speed rating
 * of 67.6 MWIPS.
 *
 * This is followed by the table of results as below. Input
 * statements are then supplied to type in the run details.
 *
 ************************************************************
 *
 * Examples of results from file whets.res
 *
 * Whetstone Single  Precision Benchmark in C/C++
 *
 * Month run         4/1996
 * PC model          Escom
 * CPU               Pentium
 * Clock MHz         100
 * Cache             256K
 * H/W Options       Neptune chipset
 * OS/DOS            Windows 95
 * Compiler          Watcom C/C++ 10.5  Win386
 * Options           No optimisation
 * Run by            Roy Longbottom
 * From              UK
 * Mail              101323.2241@compuserve.com
 *
 * Loop content                 Result            MFLOPS     MOPS   Seconds
 *
 * N1 floating point    -1.12475025653839100      19.971              0.274
 * N2 floating point    -1.12274754047393800      11.822              3.240
 * N3 if then else       1.00000000000000000               11.659     2.530
 * N4 fixed point       12.00000000000000000               13.962     6.430
 * N5 sin,cos etc.       0.49904659390449520                2.097    11.310
 * N6 floating point     0.99999988079071040       3.360             45.750
 * N7 assignments        3.00000000000000000                2.415    21.810
 * N8 exp,sqrt etc.      0.75110864639282230                1.206     8.790
 *
 * MWIPS                                          28.462            100.134
 *
 * Whetstone Single  Precision Benchmark in C/C++
 *
 * Compiler          Watcom C/C++ 10.5  Win386
 * Options           -otexan -zp4 -om -fp5 -5r
 *
 * Loop content                 Result            MFLOPS     MOPS   Seconds
 *
 * N1 floating point    -1.12475025653839100      26.751              0.478
 * N2 floating point    -1.12274754047393800      17.148              5.220
 * N3 if then else       1.00000000000000000               19.922     3.460
 * N4 fixed point       12.00000000000000000               15.978    13.130
 * N5 sin,cos etc.       0.49904659390449520                2.663    20.810
 * N6 floating point     0.99999988079071040      10.077             35.650
 * N7 assignments        3.00000000000000000               22.877     5.380
 * N8 exp,sqrt etc.      0.75110864639282230                1.513    16.370
 *
 * MWIPS                                          66.270            100.498
 *
 *
 * Whetstone Double  Precision Benchmark in C/C++
 *
 * Compiler          Watcom C/C++ 10.5 Win32NT
 * Options           -otexan -zp4 -om -fp5 -5r
 *
 * Loop content                 Result           MFLOPS      MOPS   Seconds
 *
 * N1 floating point    -1.12398255667391900     26.548               0.486
 * N2 floating point    -1.12187079889284400     16.542               5.460
 * N3 if then else       1.00000000000000000               19.647     3.540
 * N4 fixed point       12.00000000000000000               15.680    13.500
 * N5 sin,cos etc.       0.49902937281515140                3.019    18.520
 * N6 floating point     0.99999987890802820      9.977              36.330
 * N7 assignments        3.00000000000000000               22.620     5.490
 * N8 exp,sqrt etc.      0.75100163018457870                1.493    16.740
 *
 * MWIPS                                         67.156             100.066
 *
 *  Note different numeric results to single precision. Slight variations
 *  are normal with different compilers and sometimes optimisation levels.
 *
 *
 *             Example Single Precision Optimised Results
 *
 *     MWIPS   MFLOPS  MFLOPS  MFLOPS  COS     EXP     FIXPT    IF    EQUAL
 * PC            1       2       3     MOPS    MOPS    MOPS    MOPS    MOPS
 *
 * P3  5.68    0.928   0.884   0.673   0.461   0.275   2.36    2.16   0.638
 * P4  16.4    5.09    4.03    2.66    0.526   0.342   6.36    6.00    5.28
 * P5  66.3    26.8    17.1    10.1    2.66    1.51    16.0    19.9    22.9
 * P6  161     50.3    45.2    31.5    4.46    2.77    102     20.6    119
 *
 *            Example Single Precision Non-optimised Results
 *
 * P3  3.07    0.860   0.815   0.328   0.355   0.160   1.70    1.32   0.264
 * P4  10.0    4.68    3.51    1.27    0.482   0.298   5.73    5.20    1.18
 * P5  28.5    20.0    11.8    3.36    2.10    1.21    14.0    11.7    2.42
 * P6  81.7    47.5    37.8    10.9    3.91    2.43    51.2    42.8    7.85
 *
 *        Summary results as in whets.tbl at ftp.nosc.mil/pub/aburto
 *
 *           MFLOPS   = Geometric Mean of three MFLOPS loops
 *           VAX MIPS = 5 * Geometric Mean of last three items above
 *
 *                                                                     VAX
 * PC System  CPU/Options               Cache   MHz   MWIPS   MFLOPS  MIPS
 *
 * P3 Clone   AM80386DX with 387        128K    40    5.68    0.820   7.40
 * P4 Escom   80486DX2 CIS chipset      128K    66    16.4    3.79    29.3
 * P5 Escom   Pentium Neptune chipset   256K   100    66.3    16.7    96.9
 * P6 Dell    PentiumPro 440FX PCIset   256K   200    161     41.5    315
 *
 * P3 Clone   AM80386DX with 387        128K    40    3.07    0.613   4.20
 * P4 Escom   80486DX2 CIS chipset      128K    66    10.0    2.75    16.4
 * P5 Escom   Pentium Neptune chipset   256K   100    28.5    9.26    36.6
 * P6 Dell    PentiumPro 440FX PCIset   256K   200    81.7    26.9    129
 *
 **************************************************************************
 *
 *                       Running Instructions
 *
 *      1.  In order to compile successfully, include timer option as
 *          indicated below.
 *      2.  If pre-compiled codes are to be distributed, compile with the
 *          -DPRECOMP option or uncomment #define PRECOMP at PRECOMPILE
 *          below. Also insert compiler name and optimisation details
 *          at #define precompiler and #define preoptions.
 *      3.  Compile and run for single precision results. Include run
 *          time parameter N to bipass typing in hardware details etc.
 *      4.  Compile with -DDP option or uncomment #define DP at PRECISION
 *          below and run for double precision results.
 *      5.  Run with maximum and no optimisation (minimum debug)
 *      6.  Notify Roy Longbottom of other necessary changes
 *      7.  Send results file whets.res to Roy Longbottom - with one
 *          sample of each run and system details fully completed
 *
 *      Roy Longbottom  101323.2241@compuserve.com    6 November 1996
 *
 **************************************************************************
 */

 #include <math.h>       /* for sin, exp etc.           */
 #include <stdio.h>      /* standard I/O                */
 #include <string.h>     /* for strcpy - 3 occurrences  */
 #include <stdlib.h>     /* for exit   - 1 occurrence   */
#include <inttypes.h>

/***************************************************************/
/* Timer options. You MUST uncomment one of the options below  */
/* or compile, for example, with the '-DUNIX' option.          */
/***************************************************************/
/* #define Amiga       */
//#define UNIX
//#define MIPS
 /* #define UNIX_Old    */
/* #define VMS         */
/* #define BORLAND_C   */
/* #define MSC         */
/* #define MAC         */
/* #define IPSC        */
/* #define FORTRAN_SEC */
/* #define GTODay      */
//#define CTimer
/* #define UXPM        */
/* #define MAC_TMgr    */
/* #define PARIX       */
//#define POSIX
/* #define WIN32       */
//#define POSIX1
#define NDS_SIM
//#define N1N2N6ONLY
//#define DP
//#define TRACE_DUMP
/***********************/

/*PRECISION PRECISION PRECISION PRECISION PRECISION PRECISION PRECISION*/

 /* #define DP */

 #ifdef DP
    #define SPDP double
    #define SPDP_HEX uint64_t
    #define Precision "Double"
    #define FCONST(c) (c)       // default is double
 #else
    #define SPDP float
    #define SPDP_HEX uint32_t
    #define Precision "Single"
    #define atan atanf
    #define sin sinf
    #define cos cosf
    #define sqrt sqrtf
    #define exp expf
    #define log logf
    //#define FCONST(c) (c ## F)  // declare as single constant
    #define FCONST(c) (c)  // declare as single constant
 #endif

#ifdef DP
typedef int64_t udiff_t;
union ufloat {
  double   f;
  uint64_t u;
   int64_t i;
};
typedef int64_t udiff_t;
typedef union ufloat ufloat_t;
#else
union ufloat {
  float    f;
  uint32_t u;
   int32_t i;
};
typedef int32_t udiff_t;
typedef union ufloat ufloat_t;
#endif


/*PRECOMPILE  PRECOMPILE  PRECOMPILE  PRECOMPILE  PRECOMPILE  PRECOMPILE*/

 /* #define PRECOMP */

 #ifdef PRECOMP
    #define precompiler "INSERT COMPILER NAME HERE"
    #define preoptions  "INSERT OPTIMISATION OPTIONS HERE"
 #endif


// use different set of result for Precision and Fused (FMA) operations
#  if defined (DP) &&  defined (FUSED)
        #define REF_ENTRY(SECTION, DP, SP, FUSED_DP, FUSED_SP) (FUSED_DP)
#elif defined (DP) && !defined (FUSED)
        #define REF_ENTRY(SECTION, DP, SP, FUSED_DP, FUSED_SP) (DP)
#elif                  defined (FUSED)
        #define REF_ENTRY(SECTION, DP, SP, FUSED_DP, FUSED_SP) (FUSED_SP)
#else
        #define REF_ENTRY(SECTION, DP, SP, FUSED_DP, FUSED_SP) (SP)
#endif

static SPDP_HEX refarr[] = {
//REF_ENTRY(                   DP,         SP,           FUSED DP,   FUSED SP),
  REF_ENTRY(0, 0x0000000000000000, 0x00000000, 0x0000000000000000, 0x00000000), // dummy entry
  REF_ENTRY(1, 0xbff2222225a893f9, 0xbf911111, 0xbff2222225a893f9, 0xbf911111),
  REF_ENTRY(2, 0xbff222221ad3d6e3, 0xbf911110, 0xbff222221ad3d6e3, 0xbf911110),
  REF_ENTRY(3, 0x3ff0000000000000, 0x3f800000, 0x3ff0000000000000, 0x3f800000),
  REF_ENTRY(4, 0x4028000000000000, 0x41400000, 0x4028000000000000, 0x41400000),
  REF_ENTRY(5, 0x3fe000001ffd9c63, 0x3f000001, 0x3fe000001ffd9c63, 0x3f000001),
  REF_ENTRY(6, 0x3fefffffc3cfd420, 0x3f7ffffd, 0x3fefffffc3cfd420, 0x3f7ffffd),
  REF_ENTRY(7, 0x4008000000000000, 0x40400000, 0x4008000000000000, 0x40400000),
  REF_ENTRY(8, 0x3fe800d25edaa115, 0x3f400743, 0x3fe800d25edaa115, 0x3f400743),
};


 void whetstones(long xtra, long x100, int calibrate) __attribute__ ((noinline));
 void pa(SPDP e[4], SPDP t, SPDP t2);
 void po(SPDP e1[4], long j, long k, long l);
 void p3(SPDP *x, SPDP *y, SPDP *z, SPDP t, SPDP t1, SPDP t2);
 void pout(char title[18], float ops, int type, SPDP checknum,
		  SPDP time, int calibrate, int section) __attribute__ ((noinline));

 static SPDP loop_time[9];
 static SPDP loop_mops[9];
 static SPDP loop_mflops[9];
 static SPDP TimeUsed;
 static SPDP mwips;
 static char headings[9][18];
 static SPDP Check;
 static SPDP results[9];
 static int year;
 static int month;
 static int day;

    /* DATE DATE DATE DATE DATE DATE DATE DATE DATE DATE DATE DATE DATE */
    #include <time.h>   /* for following date functions only */
    void what_date()
     {
       /* Linux Gcc */
       time_t curtime;
       struct tm *loctime;

       /* Get the current time. */
       curtime = time(NULL);

       /* Convert it to local time representation. */
       loctime = localtime(&curtime);

       /* Set day, month, and year */
       month = (1 + loctime->tm_mon);
       year = (1900 + loctime->tm_year);
       day = loctime->tm_mday;

       return;
     }

#ifdef NDS_SIM
/* Please select CYCLE_PER_MICRO_SECOND definition    */
/* to determine whetstone number for what MHz         */
#define CYCLE_PER_MICRO_SECOND 1
	void init_cycle();
#endif

int main(int argc, char *argv[])
{
    int i=0;
    int count = 10, calibrate = 1;
    long xtra = 10;
    int section;
    long x100 = 1;
    int duration = 100;
    char compiler[80] = " ", options[256] = " ", general[10][80] = {" "};
    char *endit = " ";
    char *getinput = "Yes";
    char time_unit[10];


#ifdef NDS_SIM
#ifndef UNIX
    init_cycle();  /* Initialize NDS CPU performance counter 0 to count total cycles */
#endif
#ifdef TRACE_DUMP
    x100 = 5;
#else
    x100 = 1;     /* Control running time */
#endif
    sprintf(general[3], "%d MHz", CYCLE_PER_MICRO_SECOND);
    strcpy(time_unit, "uSeconds");
#ifdef UNIX
    xtra = 10000;
#endif
#else
    strcpy(time_unit, "Seconds");
#endif

    printf("\n");
    printf("##########################################\n");
    printf("%s Precision C/C++ Whetstone Benchmark\n\n", Precision);

    if (argc > 1)
     {
	switch (argv[1][0])
	{
	     case 'N':
	       getinput = "No";
	       break;
	     case 'n':
	       getinput = "No";
	       break;
	}
     }
   if (getinput == "No")
    {
       printf ("No run time input data\n\n");
    }


    /* No need to calibrate for simulator */
#ifndef NDS_SIM

  printf("Calibrate\n");
  do
   {
    TimeUsed=0;

    whetstones(xtra,x100,calibrate);

    printf("%11.2f %s %10.0lf   Passes (x 100)\n",
				     TimeUsed,time_unit,(SPDP)(xtra));
    calibrate++;
    count--;

    if (TimeUsed > 2.0)
      {
       count = 0;
      }
       else
      {
       xtra = xtra * 5;
      }
   }

   while (count > 0);

   if (TimeUsed > 0) xtra = (long)((SPDP)(duration * xtra) / TimeUsed);
   if (xtra < 1) xtra = 1;

#endif

   calibrate = 0;

   printf("\nUse %d  passes (x 100)\n", xtra);

   printf("\n          %s Precision C/C++ Whetstone Benchmark",Precision);

   #ifdef PRECOMP
      printf("\n          Compiler  %s", precompiler);
      printf("\n          Options   %s\n", preoptions);
   #else
      printf("\n");
   #endif
   printf("\nLoop content                  Result              MFLOPS "
				"     MOPS    %s\n\n",time_unit);
   TimeUsed=0;

   for(i=0;i<2;i++){ //loop 2 times
   	whetstones(xtra,x100,calibrate);
   }

   printf("\nMWIPS            ");
   if (TimeUsed>0)
     {
      mwips=(float)(xtra) * (float)(x100) / (10 * TimeUsed);
     }
      else
     {
      mwips = 0;
     }

#ifdef NDS_SIM
#ifndef UNIX
	/* scale micro second to second */
	mwips = mwips*1000000L;
#endif
#endif
#ifdef UNIX
        TimeUsed = TimeUsed*1000000L;
#endif
#ifdef UNIX
   printf(" ; ; ; %39.10f;  %19.10f; %19.10f\n",mwips,TimeUsed,mwips/(float)3000);
#else
   printf(" ; ; ; %39.10f;  %19.10f; %19.10f\n",mwips,TimeUsed,mwips/(float)CYCLE_PER_MICRO_SECOND);
#endif
   if (Check == 0) printf("Wrong answer  ");

 return 0;
}

    void whetstones(long xtra, long x100, int calibrate)
      {

	long n1,n2,n3,n4,n5,n6,n7,n8,i,ix,n1mult;
	SPDP x,y,z;
	long j,k,l;
	SPDP e1[4],timea,timeb;
	SPDP dtime() __attribute__ ((noinline));

	SPDP t =  FCONST(0.49999975);
	SPDP t0 = t;
	SPDP t1 = FCONST(0.50000025);
	SPDP t2 = FCONST(2.0);

	Check=FCONST(0.0);

	n1 = 12*x100;
	n2 = 14*x100;
	n3 = 345*x100;
	n4 = 210*x100;
	n5 = 32*x100;
	n6 = 899*x100;
	n7 = 616*x100;
	n8 = 93*x100;
	n1mult = 10;

	/* Section 1, Array elements */

	e1[0] = FCONST( 1.0);
	e1[1] = FCONST(-1.0);
	e1[2] = FCONST(-1.0);
	e1[3] = FCONST(-1.0);
	timea = dtime();
	 {
	    for (ix=0; ix<xtra; ix++)
	      {
		for(i=0; i<n1*n1mult; i++)
		  {
		      e1[0] = (e1[0] + e1[1] + e1[2] - e1[3]) * t;
		      e1[1] = (e1[0] + e1[1] - e1[2] + e1[3]) * t;
		      e1[2] = (e1[0] - e1[1] + e1[2] + e1[3]) * t;
		      e1[3] = (-e1[0] + e1[1] + e1[2] + e1[3]) * t;
		  }
		t = FCONST(1.0) - t;
	      }
	    t =  t0;
	 }
	timeb = (dtime()-timea)/(SPDP)(n1mult);
	pout("N1 floating point\0",(float)(n1*16)*(float)(xtra),
			     1,e1[3],timeb,calibrate,1);
	/* Section 2, Array as parameter */

	timea = dtime();
	 {
	    for (ix=0; ix<xtra; ix++)
	      {
		for(i=0; i<n2; i++)
		  {
		     pa(e1,t,t2);
		  }
		t = FCONST(1.0) - t;
	      }
	    t =  t0;
	 }
	timeb = dtime()-timea;
	pout("N2 floating point\0",(float)(n2*96)*(float)(xtra),
			     1,e1[3],timeb,calibrate,2);

#ifndef N1N2N6ONLY
	/* Section 3, Conditional jumps */
	j = 1;
	timea = dtime();
	 {
	    for (ix=0; ix<xtra; ix++)
	      {
		for(i=0; i<n3; i++)
		  {
		     if(j==1)       j = 2;
		     else           j = 3;
		     if(j>2)        j = 0;
		     else           j = 1;
		     if(j<1)        j = 1;
		     else           j = 0;
		  }
	      }
	 }
	timeb = dtime()-timea;
        //printf("%d ",j);
	pout("N3 if then else  \0",(float)(n3*3)*(float)(xtra),
			2,(SPDP)(j),timeb,calibrate,3);

	/* Section 4, Integer arithmetic */
	j = 1;
	k = 2;
	l = 3;
	e1[0] = FCONST(0.0);
	e1[1] = FCONST(0.0);
	timea = dtime();
	 {
	    for (ix=0; ix<xtra; ix++)
	      {
		for(i=0; i<n4; i++)
		  {
		     j = j *(k-j)*(l-k);
		     k = l * k - (l-j) * k;
		     l = (l-k) * (k+j);
                     e1[l-2] = e1[l-2] + j + k + l;
                     e1[k-2] = e1[k-2] + j * k * l;
    //  was          e1[l-2] = j + k + l; and  e1[k-2] = j * k * l;
		  }
	      }
	 }
	timeb = dtime()-timea;
        x = (e1[0]+e1[1])/(SPDP)n4/(SPDP)xtra;   // was x = e1[0]+e1[1];
        //printf("%d ",x);
	pout("N4 fixed point   \0",(float)(n4*15)*(float)(xtra),
				 2,x,timeb,calibrate,4);

	/* Section 5, Trig functions */
	x = FCONST(0.5);
	y = FCONST(0.5);
	timea = dtime();
	 {
	    for (ix=0; ix<xtra; ix++)
	      {
		for(i=1; i<n5; i++)
		  {
		     x = t*atan(t2*sin(x)*cos(x)/(cos(x+y)+cos(x-y)-FCONST(1.0)));
		     y = t*atan(t2*sin(y)*cos(y)/(cos(x+y)+cos(x-y)-FCONST(1.0)));
		  }
		t = FCONST(1.0) - t;
	      }
	    t = t0;
	 }
	timeb = dtime()-timea;
	pout("N5 sin,cos etc.  \0",(float)(n5*26)*(float)(xtra),
				 2,y,timeb,calibrate,5);

#endif
	/* Section 6, Procedure calls */
	x = FCONST(1.0);
	y = FCONST(1.0);
	z = FCONST(1.0);
	timea = dtime();
	 {
	    for (ix=0; ix<xtra; ix++)
	      {
		for(i=0; i<n6; i++)
		  {
		     p3(&x,&y,&z,t,t1,t2);
		  }
	      }
	 }
	timeb = dtime()-timea;
	pout("N6 floating point\0",(float)(n6*6)*(float)(xtra),
				1,z,timeb,calibrate,6);

#ifndef N1N2N6ONLY
	/* Section 7, Array refrences */
	j = 0;
	k = 1;
	l = 2;
	e1[0] = FCONST(1.0);
	e1[1] = FCONST(2.0);
	e1[2] = FCONST(3.0);
	timea = dtime();
	 {
	    for (ix=0; ix<xtra; ix++)
	      {
		for(i=0;i<n7;i++)
		  {
		     po(e1,j,k,l);
		  }
	      }
	 }
	timeb = dtime()-timea;
	pout("N7 assignments   \0",(float)(n7*3)*(float)(xtra),
			    2,e1[2],timeb,calibrate,7);

	/* Section 8, Standard functions */
	x = FCONST(0.75);
	timea = dtime();
	 {
	    for (ix=0; ix<xtra; ix++)
	      {
		for(i=0; i<n8; i++)
		  {
		     x = sqrt(exp(log(x)/t1));
		  }
	      }
	 }
	timeb = dtime()-timea;
	pout("N8 exp,sqrt etc. \0",(float)(n8*4)*(float)(xtra),
				2,x,timeb,calibrate,8);

#endif
	return;
      }


    void pa(SPDP e[4], SPDP t, SPDP t2)
      {
	 long j;
	 for(j=0;j<6;j++)
	    {
	       e[0] = (e[0]+e[1]+e[2]-e[3])*t;
	       e[1] = (e[0]+e[1]-e[2]+e[3])*t;
	       e[2] = (e[0]-e[1]+e[2]+e[3])*t;
	       e[3] = (-e[0]+e[1]+e[2]+e[3])/t2;
	    }

	 return;
      }

    void po(SPDP e1[4], long j, long k, long l)
      {
	 e1[j] = e1[k];
	 e1[k] = e1[l];
	 e1[l] = e1[j];
	 return;
      }

    void p3(SPDP *x, SPDP *y, SPDP *z, SPDP t, SPDP t1, SPDP t2)
      {
	 *x = *y;
	 *y = *z;
	 *x = t * (*x + *y);
	 *y = t1 * (*x + *y);
	 *z = (*x + *y)/t2;
	 return;
      }


// for pout() result comparison
udiff_t  unit_diff;
ufloat_t unit_result, unit_ref;

#ifdef DUMP_TCF // minimize pout() when doing power analysis
void pout(char title[18], float ops, int type, SPDP checknum,
          SPDP time, int calibrate, int section)
{
        unit_result.f = checknum; // NOTE: access global varialbe to avoid compiler optimizes out whole pout()
        return;
}
#else
    void pout(char title[18], float ops, int type, SPDP checknum,
	      SPDP time, int calibrate, int section)
      {
	SPDP mops,mflops;
        int fail = 0;
#ifdef NDS_SIM
#ifndef UNIX
	/* scale micro second to second */
	ops = ops*1000000L;
#endif
#endif
	Check = Check + checknum;
#ifdef UNIX
	loop_time[section] = time*1000000L;
#else
        loop_time[section] = time;
#endif
	strcpy (headings[section],title);
        TimeUsed =  TimeUsed + time;
	if (calibrate == 1)

	  {
	      results[section] = checknum;
	  }
	if (calibrate == 0)
	  {
#ifdef NDS_SIM
	    results[section] = checknum;
            unit_result.f = results[section];
            unit_ref.u    =  refarr[section];
            unit_diff = unit_result.i - unit_ref.i;
            // allow difference in ULP:
            //  - for N5, N8 because of library optimization
            fail = (unit_diff > 1) || (unit_diff < -1) || ((unit_diff != 0) && ((section != 8) && (section != 5)));
            if (fail) {
                   asm volatile("j trap_handler");
	    }
#endif
        printf("%s; results;    ",headings[section]);
	    if (type == 1)
	     {
		if (time>0)
		 {
		    mflops = ops/(1000000L*time);
		 }
		else
		 {
		   mflops = 0;
		 }
		loop_mops[section] = 99999;
		loop_mflops[section] = mflops;
		printf(" %9.10f;X          ;%9.10f;", loop_mflops[section], loop_time[section]);
#ifdef UNIX
        printf(" %9.10f\n",mflops/(float)3000);
#else
        printf(" %9.10f\n",mflops);
#endif
	     }
	    else
	     {
		if (time>0)
		 {
		   mops = ops/(1000000L*time);
		 }
		else
		 {
		   mops = 0;
		 }
		loop_mops[section] = mops;
		loop_mflops[section] = 0;
		printf("X         ;%f;  %f;",loop_mops[section], loop_time[section]);

#ifdef UNIX
                printf(" %9.10f\n",mops/(float)3000);
#else
		printf(" %9.10f\n",mops);
#endif
	     }
	  }

	return;
      }
#endif // DUMP_TCF


/*****************************************************/
/* Various timer routines.                           */
/* Al Aburto, aburto@nosc.mil, 18 Feb 1997           */
/*                                                   */
/* t = dtime() outputs the current time in seconds.  */
/* Use CAUTION as some of these routines will mess   */
/* up when timing across the hour mark!!!            */
/*                                                   */
/* For timing I use the 'user' time whenever         */
/* possible. Using 'user+sys' time is a separate     */
/* issue.                                            */
/*                                                   */
/* Example Usage:                                    */
/* [timer options added here]                        */
/* main()                                            */
/* {                                                 */
/*  double starttime,benchtime,dtime();              */
/*                                                   */
/*  starttime = dtime();                             */
/*  [routine to time]                                */
/*  benchtime = dtime() - starttime;                 */
/* }                                                 */
/*                                                   */
/* [timer code below added here]                     */
/*****************************************************/

/*********************************/
/* Timer code.                   */
/*********************************/
/*******************/
/*  Amiga dtime()  */
/*******************/
#ifdef Amiga
#include <ctype.h>
#define HZ 50

SPDP dtime()
{
 SPDP q;

 struct tt
       {
	long  days;
	long  minutes;
	long  ticks;
       } tt;

 DateStamp(&tt);

 q = ((SPDP)(tt.ticks + (tt.minutes * 60L * 50L))) / FCONST(HZ);

 return q;
}
#endif

/*****************************************************/
/*  UNIX dtime(). This is the preferred UNIX timer.  */
/*  Provided by: Markku Kolkka, mk59200@cc.tut.fi    */
/*  HP-UX Addition by: Bo Thide', bt@irfu.se         */
/*****************************************************/
#ifdef UNIX
#ifndef MIPS
#include <sys/time.h>
#include <sys/resource.h>

#ifdef hpux
#include <sys/syscall.h>
#define getrusage(a,b) syscall(SYS_getrusage,a,b)
#endif

struct rusage rusage;

SPDP dtime()
{
 SPDP q;

 getrusage(RUSAGE_SELF,&rusage);

 q = (SPDP)(rusage.ru_utime.tv_sec);
 q = q + (SPDP)(rusage.ru_utime.tv_usec) * 1.0e-06;

 return q;
}
#endif
#endif
/***************************************************/
/*  UNIX_Old dtime(). This is the old UNIX timer.  */
/*  Use only if absolutely necessary as HZ may be  */
/*  ill defined on your system.                    */
/***************************************************/
#ifdef UNIX_Old
#include <sys/types.h>
#include <sys/times.h>
#include <sys/param.h>

#ifndef HZ
#define HZ 60
#endif

struct tms tms;

SPDP dtime()
{
 SPDP q;

 times(&tms);

 q = (SPDP)(tms.tms_utime) / (SPDP)HZ;

 return q;
}
#endif

/*********************************************************/
/*  VMS dtime() for VMS systems.                         */
/*  Provided by: RAMO@uvphys.phys.UVic.CA                */
/*  Some people have run into problems with this timer.  */
/*********************************************************/
#ifdef VMS
#include time

#ifndef HZ
#define HZ 100
#endif

struct tbuffer_t
       {
	int proc_user_time;
	int proc_system_time;
	int child_user_time;
	int child_system_time;
       };
struct tbuffer_t tms;

SPDP dtime()
{
 SPDP q;

 times(&tms);

 q = (SPDP)(tms.proc_user_time) / (SPDP)HZ;

 return q;
}
#endif

/******************************/
/*  BORLAND C dtime() for DOS */
/******************************/
#ifdef BORLAND_C
#include <ctype.h>
#include <dos.h>
#include <time.h>

#define HZ 100
struct time tnow;

SPDP dtime()
{
 SPDP q;

 gettime(&tnow);

 q = 60.0 * (SPDP)(tnow.ti_min);
 q = q + (SPDP)(tnow.ti_sec);
 q = q + (SPDP)(tnow.ti_hund)/(SPDP)HZ;

 return q;
}
#endif

/***************************************/
/*  Microsoft C (MSC) dtime() for DOS  */
/*  Also suitable for Watcom C/C++ and */
/*  some other PC compilers            */
/***************************************/
#ifdef MSC
#include <time.h>
#include <ctype.h>

#define HZ CLOCKS_PER_SEC
clock_t tnow;

SPDP dtime()
{
 SPDP q;

 tnow = clock();
 q = (SPDP)tnow / (SPDP)HZ;
 return q;
}
#endif

/*************************************/
/*  Macintosh (MAC) Think C dtime()  */
/*************************************/
#ifdef MAC
#include <time.h>

#define HZ 60

SPDP dtime()
{
 SPDP q;

 q = (SPDP)clock() / (SPDP)HZ;

 return q;
}
#endif

/************************************************************/
/*  iPSC/860 (IPSC) dtime() for i860.                       */
/*  Provided by: Dan Yergeau, yergeau@gloworm.Stanford.EDU  */
/************************************************************/
#ifdef IPSC
extern double dclock();

SPDP dtime()
{
 SPDP q;

 q = dclock();

 return q;
}
#endif

/**************************************************/
/*  FORTRAN dtime() for Cray type systems.        */
/*  This is the preferred timer for Cray systems. */
/**************************************************/
#ifdef FORTRAN_SEC

fortran double second();

SPDP dtime()
{
 SPDP q;

 second(&q);

 return q;
}
#endif

/***********************************************************/
/*  UNICOS C dtime() for Cray UNICOS systems.  Don't use   */
/*  unless absolutely necessary as returned time includes  */
/*  'user+system' time.  Provided by: R. Mike Dority,      */
/*  dority@craysea.cray.com                                */
/***********************************************************/
#ifdef CTimer
#include <time.h>

SPDP dtime()
{
 SPDP q;
 clock_t   clock(void);

 q = (SPDP)clock() / (SPDP)CLOCKS_PER_SEC;

 return q;
}
#endif

/********************************************/
/* Another UNIX timer using gettimeofday(). */
/* However, getrusage() is preferred.       */
/********************************************/
#ifdef GTODay
#include <sys/time.h>

struct timeval tnow;

SPDP dtime()
{
 SPDP q;

 gettimeofday(&tnow,NULL);
 q = (SPDP)tnow.tv_sec + (SPDP)tnow.tv_usec * 1.0e-6;

 return q;
}
#endif

/*****************************************************/
/*  Fujitsu UXP/M timer.                             */
/*  Provided by: Mathew Lim, ANUSF, M.Lim@anu.edu.au */
/*****************************************************/
#ifdef UXPM
#include <sys/types.h>
#include <sys/timesu.h>
struct tmsu rusage;

SPDP dtime()
{
 SPDP q;

 timesu(&rusage);

 q = (SPDP)(rusage.tms_utime) * 1.0e-06;

 return q;
}
#endif

/**********************************************/
/*    Macintosh (MAC_TMgr) Think C dtime()    */
/*   requires Think C Language Extensions or  */
/*    #include <MacHeaders> in the prefix     */
/*  provided by Francis H Schiffer 3rd (fhs)  */
/*         skipschiffer@genie.geis.com        */
/**********************************************/
#ifdef MAC_TMgr
#include <Timer.h>
#include <stdlib.h>

static TMTask   mgrTimer;
static Boolean  mgrInited = false;
static SPDP     mgrClock;

#define RMV_TIMER RmvTime( (QElemPtr)&mgrTimer )
#define MAX_TIME  1800000000L
/* MAX_TIME limits time between calls to */
/* dtime( ) to no more than 30 minutes   */
/* this limitation could be removed by   */
/* creating a completion routine to sum  */
/* 30 minute segments (fhs 1994 feb 9)   */

static void Remove_timer( )
{
 RMV_TIMER;
 mgrInited = false;
}

SPDP dtime( )
{
 if( mgrInited ) {
	RMV_TIMER;
	mgrClock += (MAX_TIME + mgrTimer.tmCount)*1.0e-6;
 } else {
	if( _atexit( &Remove_timer ) == 0 ) mgrInited = true;
	mgrClock = 0.0;
}
	if( mgrInited ) {
		mgrTimer.tmAddr = NULL;
		mgrTimer.tmCount = 0;
		mgrTimer.tmWakeUp = 0;
		mgrTimer.tmReserved = 0;
		InsTime( (QElemPtr)&mgrTimer );
		PrimeTime( (QElemPtr)&mgrTimer, -MAX_TIME );
	}
	return( mgrClock );
}
#endif

/***********************************************************/
/*  Parsytec GCel timer.                                   */
/*  Provided by: Georg Wambach, gw@informatik.uni-koeln.de */
/***********************************************************/
#ifdef PARIX
#include <sys/time.h>

SPDP dtime()
{
 SPDP q;

 q = (SPDP) (TimeNowHigh()) / (SPDP) CLK_TCK_HIGH;

 return q;
}
#endif

/************************************************/
/*  Sun Solaris POSIX dtime() routine           */
/*  Provided by: Case Larsen, CTLarsen.lbl.gov  */
/************************************************/
#ifdef POSIX
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/rusage.h>

#ifdef __hpux
#include <sys/syscall.h>
#endif

struct rusage rusage;

SPDP dtime()
{
 SPDP q;

 getrusage(RUSAGE_SELF,&rusage);

 q = (SPDP)(rusage.ru_utime.tv_sec);
 q = q + (SPDP)(rusage.ru_utime.tv_nsec) * 1.0e-09;

 return q;
}
#endif


/****************************************************/
/*  Windows NT (32 bit) dtime() routine             */
/*  Provided by: Piers Haken, piersh@microsoft.com  */
/****************************************************/
#ifdef WIN32
#include <windows.h>

SPDP dtime(void)
{
 SPDP q;

 q = (SPDP)GetTickCount() * 1.0e-03;

 return q;
}
#endif

/*****************************************************/
/* Time according to POSIX.1  -  <J.Pelan@qub.ac.uk> */
/* Ref: "POSIX Programmer's Guide"  O'Reilly & Assoc.*/
/*****************************************************/
#ifdef POSIX1
#define _POSIX_SOURCE 1
#include <unistd.h>
#include <limits.h>
#include <sys/times.h>

struct tms tms;

SPDP dtime()
{
 SPDP q;
 times(&tms);
 q = (SPDP)tms.tms_utime / (SPDP)sysconf(_SC_CLK_TCK);
 return q;
}
#endif

/******************************************************/
/* Cycle according to NDS CPU simulator               */
/* <chchang@andestech.com>                            */
/* Ref: AndeStar Privileged Architecture spec         */
/*      Performance monitoring mechanism              */
/******************************************************/
#ifdef NDS_SIM
#ifdef MIPS
SPDP dtime()
{
  return 0;
}
#else
#ifndef UNIX
SPDP dtime()
{
  unsigned int q;
  SPDP res,res2;

  asm volatile ("nop"::);
  //asm volatile ("mfusr %0, $pfr0" : "=r" (q));
  //asm volatile ("fmtsr %1, %0" : "=f" (res) : "r" (q));
  //asm volatile ("fui2s %0, %1" : "=f" (res2) : "f" (res));
  //asm volatile("fmfsr %0, %1" : "=r" (res) : "f" (temp));

  //asm volatile ("mfusr %0, $pfr0" : "=r" (q));

  //return (res2);
  //res = (SPDP) q / (SPDP) CYCLE_PER_MICRO_SECOND;
  //return res;
  //return 1.0;
  return 0;	//this function isn't used
}

void init_cycle()
{
  int value = 65; /* value = 0x41 */
  int zero = 0;
  //asm volatile ("mtusr %0, $pfr0" :: "r" (zero));
  //asm volatile ("isb");
  //asm volatile ("mtusr %0, $pfr3" :: "r" (value));

}
#endif
#endif
#endif
