/* RISC-V ELF support for BFD.
   Copyright 2011-2015 Free Software Foundation, Inc.

   Contributed by Andrw Waterman <waterman@cs.berkeley.edu> at UC Berkeley.
   Based on MIPS ELF support for BFD, by Ian Lance Taylor.

   This file is part of BFD, the Binary File Descriptor library.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; see the file COPYING3. If not,
   see <http://www.gnu.org/licenses/>.  */

/* This file holds definitions specific to the RISCV ELF ABI.  Note
   that most of this is not actually implemented by BFD.  */

#ifndef _ELF_RISCV_H
#define _ELF_RISCV_H

#include "elf/reloc-macros.h"
#include "libiberty.h"

/* Relocation types.  */
START_RELOC_NUMBERS (elf_riscv_reloc_type)
  /* Relocation types used by the dynamic linker.  */
  RELOC_NUMBER (R_RISCV_NONE, 0)
  RELOC_NUMBER (R_RISCV_32, 1)
  RELOC_NUMBER (R_RISCV_64, 2)
  RELOC_NUMBER (R_RISCV_RELATIVE, 3)
  RELOC_NUMBER (R_RISCV_COPY, 4)
  RELOC_NUMBER (R_RISCV_JUMP_SLOT, 5)
  RELOC_NUMBER (R_RISCV_TLS_DTPMOD32, 6)
  RELOC_NUMBER (R_RISCV_TLS_DTPMOD64, 7)
  RELOC_NUMBER (R_RISCV_TLS_DTPREL32, 8)
  RELOC_NUMBER (R_RISCV_TLS_DTPREL64, 9)
  RELOC_NUMBER (R_RISCV_TLS_TPREL32, 10)
  RELOC_NUMBER (R_RISCV_TLS_TPREL64, 11)

  /* Relocation types not used by the dynamic linker.  */
  RELOC_NUMBER (R_RISCV_BRANCH, 16)
  RELOC_NUMBER (R_RISCV_JAL, 17)
  RELOC_NUMBER (R_RISCV_CALL, 18)
  RELOC_NUMBER (R_RISCV_CALL_PLT, 19)
  RELOC_NUMBER (R_RISCV_GOT_HI20, 20)
  RELOC_NUMBER (R_RISCV_TLS_GOT_HI20, 21)
  RELOC_NUMBER (R_RISCV_TLS_GD_HI20, 22)
  RELOC_NUMBER (R_RISCV_PCREL_HI20, 23)
  RELOC_NUMBER (R_RISCV_PCREL_LO12_I, 24)
  RELOC_NUMBER (R_RISCV_PCREL_LO12_S, 25)
  RELOC_NUMBER (R_RISCV_HI20, 26)
  RELOC_NUMBER (R_RISCV_LO12_I, 27)
  RELOC_NUMBER (R_RISCV_LO12_S, 28)
  RELOC_NUMBER (R_RISCV_TPREL_HI20, 29)
  RELOC_NUMBER (R_RISCV_TPREL_LO12_I, 30)
  RELOC_NUMBER (R_RISCV_TPREL_LO12_S, 31)
  RELOC_NUMBER (R_RISCV_TPREL_ADD, 32)
  RELOC_NUMBER (R_RISCV_ADD8, 33)
  RELOC_NUMBER (R_RISCV_ADD16, 34)
  RELOC_NUMBER (R_RISCV_ADD32, 35)
  RELOC_NUMBER (R_RISCV_ADD64, 36)
  RELOC_NUMBER (R_RISCV_SUB8, 37)
  RELOC_NUMBER (R_RISCV_SUB16, 38)
  RELOC_NUMBER (R_RISCV_SUB32, 39)
  RELOC_NUMBER (R_RISCV_SUB64, 40)
  RELOC_NUMBER (R_RISCV_GNU_VTINHERIT, 41)
  RELOC_NUMBER (R_RISCV_GNU_VTENTRY, 42)
  RELOC_NUMBER (R_RISCV_ALIGN, 43)
  RELOC_NUMBER (R_RISCV_RVC_BRANCH, 44)
  RELOC_NUMBER (R_RISCV_RVC_JUMP, 45)
  RELOC_NUMBER (R_RISCV_RVC_LUI, 46)
  RELOC_NUMBER (R_RISCV_GPREL_I, 47)
  RELOC_NUMBER (R_RISCV_GPREL_S, 48)
END_RELOC_NUMBERS (R_RISCV_max)

/* Processor specific flags for the ELF header e_flags field.  */

/* File may contain compressed instructions.  */
#define EF_RISCV_RVC 0x0001

/* File uses the soft-float calling convention.  */
#define EF_RISCV_SOFT_FLOAT 0x0002

#endif /* _ELF_RISCV_H */
