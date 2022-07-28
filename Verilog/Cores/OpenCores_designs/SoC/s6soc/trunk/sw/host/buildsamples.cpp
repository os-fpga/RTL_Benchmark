////////////////////////////////////////////////////////////////////////////////
//
// Filename: 	buildsamples.cpp
//
// Project:	CMod S6 System on a Chip, ZipCPU demonstration project
//
// Purpose:	This program converts an 8kHz, 16t, mono- sound data file into
//		samples that can be read and understood by the C compiler and
//	hence included in a S6SoC project as the ``doorbell'' audio sound.
//
//	To use this, first convert your sound file to 8kHz, 16t, raw mono
//	format.  The sox utility works well for this purpose.
//
//	Then, run this program wih the single argument being the name of that
//	sound file.   The standard output will be the resulting C-code 
//	representing/recreating that sound file.  Pipe this into a file for
//	inclusion in your program.  You can then reference both the number of
//	samples from that file, as well as the number of words those samples
//	are stored in, as well as what those samples are.
//
//	The samples themselves can then be placed in a flash partition, and
//	read like any memory from within your program.
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2015-2016, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of  the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory, run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define	SLEN	512
#define	ILEN	(SLEN/2)

int	main(int argc, char **argv) {
	FILE	*fp, *legal;

	char	cbuf[SLEN];
	short	sbuf[SLEN];
	int	nread = 0, nr;

	if (argc != 1) {
		fprintf(stderr, 
"Usage:\tbuildsamples samplefile\n"
"\n"
"\twhere 'samplefile' is a sound data file consisting of 16-bit samples\n"
"\tthat have been sampled at 8kHz.  The sample file should have no\n"
"\theader, and should only reference a mono (not stereo) output.\n"
"\n"
"\tThe result is a C program fragment that can be redirected to a file for\n"
"\tlater inclusion in your project.\n");
		exit(EXIT_SUCCESS);
	}

	fp = fopen(argv[1], "rb");
	if (!fp) {
		fprintf(stderr, "Could not open %s for reading\n", argv[1]);
		exit(EXIT_FAILURE);
	}

	/*
	legal = fopen("../legal.txt", "r");
	if (!legal)
		legal = fopen("../../legal.txt", "r");
	*/
	legal = NULL;
	if (legal) {
		while(fgets(cbuf, SLEN, legal)) {
			if (strncmp(cbuf, "// Filename:", 12)==0)
				printf("// Filename:\tsamples.c\n");
			else	printf("%s", cbuf);
		} fclose(legal);
	} else {
		printf("// This file should be copyrighted but I can't find\n");
		printf("// the copyright statement.\n//\n");
	}

	printf(
"// This file is computer generated--DO NOT EDIT IT!  The generator file can\n"
"// be found in trunk/sw/host/%s\n"
"//\n"
"//\n"
"#ifndef\tSOUND_DATA_H\n"
"#define\tSOUND_DATA_H\n\n"
"const\tint\tsound_data[] = {\n", __FILE__);

	while((nr = fread(sbuf, sizeof(short), SLEN, fp))>0) {
		int	pos = 0;
		nread += nr;
		while(pos < nr) {
			printf("\t");
			for(int i=0; (pos<((nr+1)&-2))&&(i<8); i+=2) {
				int iv = (sbuf[pos]<<16)|(sbuf[pos+1] & 0x0ffff);
				printf("0x%08x, ", iv);
				pos+=2;
			} printf("\n");
		}
	} printf("\t0\n};\n");

	printf("\n\n"
"#define\tNSAMPLES\t%d\n"
"#define\tNSAMPLE_WORDS\t%d\n"
"\n\n#endif\n", nread, 1+((nread+1)>>1));

}

