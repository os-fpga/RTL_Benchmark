#ifndef __L2C_H
#define __L2C_H

#include <inttypes.h>
#include "general.h"


// ======================================================
// L2C register definition
// ======================================================
// L2C registers


#ifdef NDS_L2C_CCTL_MAP_V1
typedef struct {
	__I  uint64_t CONFIG;		// (0x00) L2 configuration
	__IO uint64_t CTRL;		// (0x08) L2 control register
	__IO uint64_t HPM_CTRL0;	// (0x10) L2 HPM Control 0 Register
	__IO uint64_t HPM_CTRL1;	// (0x18) L2 HPM Control 1 Register
	__IO uint64_t HPM_CTRL2;	// (0x20) L2 HPM Control 2 Register
	__IO uint64_t HPM_CTRL3;	// (0x28) L2 HPM Control 3 Register
	__IO uint64_t ASYNCERR;		// (0x30) L2 asynchronous error 
	__IO uint64_t ECC_ERR;		// (0x38) L2 ECC error
	__IO uint64_t M0_CCTL_CMD;  	// (0x40)
	__IO uint64_t M0_CCTL_ACC;	// (0x48)
	__IO uint64_t M0_PADDING[6]; 	// (0x50~0x78)
	__IO uint64_t CCTL_ST;		// (0x80)
	__IO uint64_t RESERVED0;	// (0x88) Reserved
	__IO uint64_t TGT_DATA[8];	// (0x90~0xc8) 	TGT Data 0~7 Register
	__IO uint64_t TGT_ECC;	        // (0xd0~0xd7) 	TGT Write ECC Register
	__IO uint64_t RESERVED1[37];	// (0xd8~0x1f8) Reserved
	__IO uint64_t HPM_CNT_ENT[32];	// (0x200~0x2f8) L2 HPM counter event0~31
	__IO uint64_t RESERVED2[424];	// (0x300~0x1038)

	__IO uint64_t M1_CCTL_CMD;  	// (0x1040)
	__IO uint64_t M1_CCTL_ACC;	// (0x1048)
	__IO uint64_t M1_PADDING[6]; 	// (0x1050~0x1078)
	__IO uint64_t M1_CCTL_ST;	// (0x1080)
	__IO uint64_t PADDING1[503];	// (0x1088~0x2038)

	__IO uint64_t M2_CCTL_CMD;  	// (0x2040)
	__IO uint64_t M2_CCTL_ACC;	// (0x2048)
	__IO uint64_t M2_PADDING[6]; 	// (0x2050~0x2078)
	__IO uint64_t M2_CCTL_ST;	// (0x2080)
	__IO uint64_t PADDING2[503];	// (0x2088~0x3038)

	__IO uint64_t M3_CCTL_CMD;  	// (0x3040)
	__IO uint64_t M3_CCTL_ACC;	// (0x3048)
	__IO uint64_t M3_PADDING[6]; 	// (0x3050~0x3078)
	__IO uint64_t M3_CCTL_ST;	// (0x3080)
	__IO uint64_t PADDING3[503];	// (0x3088~0x4038)

	__IO uint64_t M4_CCTL_CMD;  	// (0x4040)
	__IO uint64_t M4_CCTL_ACC;	// (0x4048)
	__IO uint64_t M4_PADDING[6]; 	// (0x4050~0x4078)
	__IO uint64_t M4_CCTL_ST;	// (0x4080)
	__IO uint64_t PADDING4[503];	// (0x4088~0x5038)

	__IO uint64_t M5_CCTL_CMD;  	// (0x5040)
	__IO uint64_t M5_CCTL_ACC;	// (0x5048)
	__IO uint64_t M5_PADDING[6]; 	// (0x5050~0x5078)
	__IO uint64_t M5_CCTL_ST;	// (0x5080)
	__IO uint64_t PADDING5[503];	// (0x5088~0x6038)

	__IO uint64_t M6_CCTL_CMD;  	// (0x6040)
	__IO uint64_t M6_CCTL_ACC;	// (0x6048)
	__IO uint64_t M6_PADDING[6]; 	// (0x6050~0x6078)
	__IO uint64_t M6_CCTL_ST;	// (0x6080)
	__IO uint64_t PADDING6[503];	// (0x6088~0x7038)

	__IO uint64_t M7_CCTL_CMD;  	// (0x7040)
	__IO uint64_t M7_CCTL_ACC;	// (0x7048)
	__IO uint64_t M7_PADDING[6]; 	// (0x7050~0x7078)
	__IO uint64_t M7_CCTL_ST;	// (0x7080)
} L2C_RegDef;
#else
typedef struct {
	__I  uint64_t CONFIG;		// (0x00) L2 configuration
	__IO uint64_t CTRL;		// (0x08) L2 control register
	__IO uint64_t HPM_CTRL0;	// (0x10) L2 HPM Control 0 Register
	__IO uint64_t HPM_CTRL1;	// (0x18) L2 HPM Control 1 Register
	__IO uint64_t HPM_CTRL2;	// (0x20) L2 HPM Control 2 Register
	__IO uint64_t HPM_CTRL3;	// (0x28) L2 HPM Control 3 Register
	__IO uint64_t ASYNCERR;		// (0x30) L2 asynchronous error 
	__IO uint64_t ECC_ERR;		// (0x38) L2 ECC error
	__IO uint64_t M0_CCTL_CMD;	// (0x40) M0 L2 CCTL Command Register
	__IO uint64_t M0_CCTL_ACC;	// (0x48) M0 L2 CCTL Access Line Register
	__IO uint64_t M1_CCTL_CMD;	// (0x50) M1 L2 CCTL Command Register
	__IO uint64_t M1_CCTL_ACC;	// (0x58) M1 L2 CCTL Access Line Register
	__IO uint64_t M2_CCTL_CMD;	// (0x60) M2 L2 CCTL Command Register
	__IO uint64_t M2_CCTL_ACC;	// (0x68) M2 L2 CCTL Access Line Register
	__IO uint64_t M3_CCTL_CMD;	// (0x70) M3 L2 CCTL Command Register
	__IO uint64_t M3_CCTL_ACC;	// (0x78) M3 L2 CCTL Access Line Register
	__IO uint64_t CCTL_ST;		// (0x80) L2 CCTL Status Register
	__IO uint64_t RESERVED0;	// (0x88) Reserved
	__IO uint64_t TGT_DATA[8];	// (0x90~0xc8) 	TGT Data 0~7 Register
	__IO uint64_t TGT_ECC;	        // (0xd0~0xd7) 	TGT Write ECC Register
	__IO uint64_t RESERVED1[37];	// (0xd8~0x1f8) Reserved
	__IO uint64_t HPM_CNT_ENT[32];	// (0x200~0x2f8) L2 HPM counter event0~31
} L2C_RegDef;
#endif
// L2C config register (RO)
// Skip checking the default value if l2c cache size and l2c ecc type 
// - these are assigned from parameters
// Datasheet version AndesCore_AX45MP_DS185_V1.2
#define L2C_CONFIG_SIZE_MASK			(BIT_MASK(15, 0))	// l2c cache size
#define L2C_CONFIG_SIZE_OFFSET			(0)
#define L2C_CONFIG_SIZE_DEFAULT			()
#define L2C_CONFIG_ECC_MASK			(BIT_MASK(19, 16))	// l2c ecc type
#define L2C_CONFIG_ECC_OFFSET			(16)
#define L2C_CONFIG_ECC_DEFAULT			()
#define L2C_CONFIG_MAP_MASK			(BIT_MASK(20, 20))	// l2c map type
#define L2C_CONFIG_MAP_OFFSET			(20)
#define L2C_CONFIG_MAP_DEFAULT			()
#define L2C_CTRL_ECCEN_MASK			(BIT_MASK(7, 7))	
#define L2C_CTRL_ECCEN_OFFSET			(7)			


#define L2C_CONFIG_VER_MASK			(BIT_MASK(31, 24))	// l2c version
#define L2C_CONFIG_VER_OFFSET			(24)
#define L2C_CONFIG_VER_DEFAULT			(0x10)
#define L2C_CONFIG_DEFAULT			(\
						L2C_DEFAULT(CONFIG, VER)\
						)
#define L2C_CONFIG_MASK				(\
				 		L2C_CONFIG_VER_MASK\
						)

// L2C control register (RW)
// CEN
#define L2C_CTRL_EN_MASK			(BIT_MASK(0, 0))	
#define L2C_CTRL_EN_OFFSET			(0)
#define L2C_CTRL_EN_DEFAULT			(0x1)			
// PFTHRES
#define L2C_CTRL_DIS_PF_THR_MASK		(BIT_MASK(1, 2))	
#define L2C_CTRL_DIS_PF_THR_OFFSET		(1)
#define L2C_CTRL_DIS_PF_THR_DEFAULT		(0x0)			
// IPFDPT
#define L2C_CTRL_INS_PF_DEPTH_MASK		(BIT_MASK(4, 3))	
#define L2C_CTRL_INS_PF_DEPTH_OFFSET		(3)			
#ifdef BOOT_EN_L2C_PREFETCH
	#define L2C_CTRL_INS_PF_DEPTH_DEFAULT		(0x3)			
#else
	#define L2C_CTRL_INS_PF_DEPTH_DEFAULT		(0x0)			
#endif
// DPFDPT
#define L2C_CTRL_LS_PF_DEPTH_MASK		(BIT_MASK(6, 5))	
#define L2C_CTRL_LS_PF_DEPTH_OFFSET		(5)			
#ifdef BOOT_EN_L2C_PREFETCH
	#define L2C_CTRL_LS_PF_DEPTH_DEFAULT		(0x3)			
#else
	#define L2C_CTRL_LS_PF_DEPTH_DEFAULT		(0x0)			
#endif
// TRAMOCTL
#define L2C_CTRL_TAG_RAM_LATENCY_MASK		(BIT_MASK(9, 8))	
#define L2C_CTRL_TAG_RAM_LATENCY_OFFSET		(8)			
#define L2C_CTRL_TAG_RAM_LATENCY_DEFAULT	(0)
// TRAMICTL
#define L2C_CTRL_TAG_RAM_SETUP_MASK		(BIT_MASK(10, 10))	
#define L2C_CTRL_TAG_RAM_SETUP_OFFSET		(10)			
#define L2C_CTRL_TAG_RAM_SETUP_DEFAULT		()		
// DRAMOCTL
#define L2C_CTRL_DATA_RAM_LATENCY_MASK		(BIT_MASK(12, 11))	
#define L2C_CTRL_DATA_RAM_LATENCY_OFFSET	(11)			
#define L2C_CTRL_DATA_RAM_LATENCY_DEFAULT	()		
// DRAMICTL
#define L2C_CTRL_DATA_RAM_SETUP_MASK		(BIT_MASK(13, 13))	
#define L2C_CTRL_DATA_RAM_SETUP_OFFSET		(13)			
#define L2C_CTRL_DATA_RAM_SETUP_DEFAULT		()		
// INITSTATUS
#define L2C_CTRL_INITSTATUS_MASK		(BIT_MASK(14, 14))	
#define L2C_CTRL_INITSTATUS_OFFSET		(14)			
#define L2C_CTRL_INITSTATUS_DEFAULT		(0)
// COHERENT MODE
#define L2C_CTRL_COHERENT_MODE_MASK		(BIT_MASK(23, 16))	
#define L2C_CTRL_COHERENT_MODE_OFFSET		(16)			
#define L2C_CTRL_COHERENT_MODE_DEFAULT		(0x0)		

#define L2C_CTRL_DEFAULT			(\
						L2C_DEFAULT(CTRL, EN) |\
						L2C_DEFAULT(CTRL, DIS_PF_THR) |\
						L2C_DEFAULT(CTRL, INS_PF_DEPTH) |\
						L2C_DEFAULT(CTRL, LS_PF_DEPTH) |\
						L2C_DEFAULT(CTRL, TAG_RAM_LATENCY) |\
						L2C_DEFAULT(CTRL, INITSTATUS) |\
						L2C_DEFAULT(CTRL, COHERENT_MODE) \
						)
#define L2C_CTRL_MASK				(\
						L2C_CTRL_EN_MASK |\
						L2C_CTRL_DIS_PF_THR_MASK |\
						L2C_CTRL_INS_PF_DEPTH_MASK |\
						L2C_CTRL_LS_PF_DEPTH_MASK |\
						L2C_CTRL_TAG_RAM_LATENCY_MASK |\
						L2C_CTRL_INITSTATUS_MASK |\
						L2C_CTRL_COHERENT_MODE_MASK \
						)

// L2C HPF Control Register 0 ~ 3
// - HPM ctrl 0: sel0~7
// - HPM ctrl 1: sel8~15
// - HPM ctrl 2: sel16~23
// - HPM ctrl 3: sel24~31
#define L2C_HPM_CTRL_MASK			0x000000000000FFFF
#define L2C_HPM_CTRL_OFFSET		        (0)			
#define L2C_HPM_CTRL_DEFAULT			(0xFFFFFFFFFFFFFFF)
#define L2C_HPM_CTRL_DEFAULT_NO_EXIST		(0x0000000000000000)

// L2C asynchronous error register (RO/WC)
#define L2C_ASYNCERR_MASK			(BIT_MASK(0, 0))	
#define L2C_ASYNCERR_OFFSET			(0)
#define L2C_ASYNCERR_DEFAULT			(0x0)			

// L2 ECC error (RO/WC)
#define L2C_ECC_ERR_IDX_MASK			(BIT_MASK(15, 0))	
#define L2C_ECC_ERR_IDX_OFFSET			(0)			
#define L2C_ECC_ERR_IDX_DEFAULT			(0x0)			
#define L2C_ECC_ERR_WAY_MASK			(BIT_MASK(19, 16))	
#define L2C_ECC_ERR_WAY_OFFSET			(16)			
#define L2C_ECC_ERR_WAY_DEFAULT			(0x0)			
#define L2C_ECC_ERR_RAMID_MASK			(BIT_MASK(23, 20))	
#define L2C_ECC_ERR_RAMID_OFFSET		(20)			
#define L2C_ECC_ERR_RAMID_DEFAULT		(0x0)			
#define L2C_ECC_ERR_BUS_ERR_MASK		(BIT_MASK(29, 29))	
#define L2C_ECC_ERR_BUS_ERR_OFFSET		(29)			
#define L2C_ECC_ERR_BUS_ERR_DEFAULT		(0x0)			
#define L2C_ECC_ERR_MORE_ERR_MASK		(BIT_MASK(30, 30))	
#define L2C_ECC_ERR_MORE_ERR_OFFSET		(30)			
#define L2C_ECC_ERR_MORE_ERR_DEFAULT		(0x0)			
#define L2C_ECC_ERR_VALID_MASK			(BIT_MASK(31, 31))	
#define L2C_ECC_ERR_VALID_OFFSET		(31)
#define L2C_ECC_ERR_VALID_DEFAULT		(0x0)			
#define L2C_ECC_ERR_DEFAULT			(\
						L2C_DEFAULT(ECC_ERR, IDX) |\
						L2C_DEFAULT(ECC_ERR, WAY) |\
						L2C_DEFAULT(ECC_ERR, RAMID) |\
						L2C_DEFAULT(ECC_ERR, BUS_ERR) |\
						L2C_DEFAULT(ECC_ERR, MORE_ERR) |\
						L2C_DEFAULT(ECC_ERR, VALID) \
						)
#define L2C_ECC_ERR_MASK			(\
						L2C_ECC_ERR_IDX_MASK |\
						L2C_ECC_ERR_WAY_MASK |\
						L2C_ECC_ERR_RAMID_MASK |\
						L2C_ECC_ERR_BUS_ERR_MASK |\
						L2C_ECC_ERR_MORE_ERR_MASK |\
						L2C_ECC_ERR_VALID_MASK \
						)

// L2 CCTL Command Register (RW)
#define L2C_CCTL_CMD_MASK			(BIT_MASK(4, 0))	
#define L2C_CCTL_CMD_OFFSET			(0)			
#define L2C_CCTL_CMD_DEFAULT			(0x0)			
#define L2C_CCTL_CMD_WBINVAL_ALL		(0x12)			

// L2 CCTL Access Line Register(IX Format) (RW)
#define L2C_CCTL_ACC_IX_SET_MASK		(BIT_MASK(19, 6))	
#define L2C_CCTL_ACC_IX_SET_OFFSET		(6)			
#define L2C_CCTL_ACC_IX_SET_DEFAULT		(0x0)			
#define L2C_CCTL_ACC_IX_WAY_MASK		(BIT_MASK(31, 28))	
#define L2C_CCTL_ACC_IX_WAY_OFFSET		(28)			
#define L2C_CCTL_ACC_IX_WAY_DEFAULT		(0x0)			
#define L2C_CCTL_ACC_IX_DEFAULT			(\
	    	  	   			L2C_DEFAULT(CCTL_ACC_IX, SET) |\
	    	      				L2C_DEFAULT(CCTL_ACC_IX, WAY) \
	    	      				)
#define L2C_CCTL_ACC_IX_MASK			(\
						L2C_CCTL_ACC_IX_SET_MASK |\
						L2C_CCTL_ACC_IX_WAY_MASK \
						)

// L2 CCTL Access Line Register(PA Format) (RW)
#define L2C_CCTL_ACC_PA_MASK			0xFFFFFFFFFFFFFFFF	
#define L2C_CCTL_ACC_PA_OFFSET			(0)			
#define L2C_CCTL_ACC_PA_DEFAULT			(0x0)			

// L2 CCTL Access Line Register(TGT Format)
#define L2C_CCTL_ACC_TGT_SET_MASK		(BIT_MASK(19, 6))	
#define L2C_CCTL_ACC_TGT_SET_OFFSET		(6)			
#define L2C_CCTL_ACC_TGT_SET_DEFAULT		(0x0)			
#define L2C_CCTL_ACC_TGT_RAM_MASK		(BIT_MASK(27, 26))	
#define L2C_CCTL_ACC_TGT_RAM_OFFSET		(26)			
#define L2C_CCTL_ACC_TGT_RAM_DEFAULT		(0x0)			
#define L2C_CCTL_ACC_TGT_WAY_MASK		(BIT_MASK(31, 28))	
#define L2C_CCTL_ACC_TGT_WAY_OFFSET		(28)			
#define L2C_CCTL_ACC_TGT_WAY_DEFAULT		(0x0)			
#define L2C_CCTL_ACC_TGT_DEFAULT		(\
	    	  	   			L2C_DEFAULT(CCTL_ACC_TGT, SET) |\
	    	  	   			L2C_DEFAULT(CCTL_ACC_TGT, RAM) |\
	    	      				L2C_DEFAULT(CCTL_ACC_TGT, WAY) \
	    	      				)
#define L2C_CCTL_ACC_TGT_MASK			(\
						L2C_CCTL_ACC_TGT_SET_MASK |\
						L2C_CCTL_ACC_TGT_RAM_MASK |\
						L2C_CCTL_ACC_TGT_WAY_MASK \
						)

// L2 CCTL Status Register (RO)
#define L2C_CCTL_ST_M0_MASK			(BIT_MASK(3, 0))	
#define L2C_CCTL_ST_M0_OFFSET			(0)			
#define L2C_CCTL_ST_M0_DEFAULT			(0x0)			
#define L2C_CCTL_ST_M1_MASK			(BIT_MASK(7, 4))	
#define L2C_CCTL_ST_M1_OFFSET			(4)			
#define L2C_CCTL_ST_M1_DEFAULT			(0x0)			
#define L2C_CCTL_ST_M2_MASK			(BIT_MASK(11, 8))	
#define L2C_CCTL_ST_M2_OFFSET			(8)			
#define L2C_CCTL_ST_M2_DEFAULT			(0x0)			
#define L2C_CCTL_ST_M3_MASK			(BIT_MASK(15, 12))	
#define L2C_CCTL_ST_M3_OFFSET			(12)			
#define L2C_CCTL_ST_M3_DEFAULT			(0x0)			
#define L2C_CCTL_ST_DEFAULT			(\
	    	  	   			L2C_DEFAULT(CCTL_ST, M0) |\
	    	  	   			L2C_DEFAULT(CCTL_ST, M1) |\
	    	  	   			L2C_DEFAULT(CCTL_ST, M2) |\
	    	      				L2C_DEFAULT(CCTL_ST, M3) \
	    	      				)
#define L2C_CCTL_ST_MASK			(\
						L2C_CCTL_ST_M0_MASK |\
						L2C_CCTL_ST_M1_MASK |\
						L2C_CCTL_ST_M2_MASK |\
						L2C_CCTL_ST_M3_MASK \
						)

// TGT Data 0~7 Register (RW)
#define L2C_TGT_DATA_MASK			0xFFFFFFFFFFFFFFFF
#define L2C_TGT_DATA_OFFSET			(0)			
#define L2C_TGT_DATA_DEFAULT			(0x0)			


// TGT Write ECC Register (RW)
#define L2C_TGT_ECC_TGTECC0_MASK		(BIT_MASK(7, 0))	
#define L2C_TGT_ECC_TGTECC0_OFFSET		(0)		
#define L2C_TGT_ECC_TGTECC0_DEFAULT		(0x0)			
#define L2C_TGT_ECC_TGTECC1_MASK		(BIT_MASK(15, 8))	
#define L2C_TGT_ECC_TGTECC1_OFFSET		(8)			
#define L2C_TGT_ECC_TGTECC1_DEFAULT		(0x0)			
#define L2C_TGT_ECC_TGTECC2_MASK		(BIT_MASK(23, 16))	
#define L2C_TGT_ECC_TGTECC2_OFFSET		(16)			
#define L2C_TGT_ECC_TGTECC2_DEFAULT		(0x0)			
#define L2C_TGT_ECC_TGTECC3_MASK		(BIT_MASK(31, 24))	
#define L2C_TGT_ECC_TGTECC3_OFFSET		(24)			
#define L2C_TGT_ECC_TGTECC3_DEFAULT		(0x0)			
#define L2C_TGT_ECC_DEFAULT			(\
						L2C_DEFAULT(TGT_ECC, TGTECC0) |\
						L2C_DEFAULT(TGT_ECC, TGTECC1) |\
						L2C_DEFAULT(TGT_ECC, TGTECC2) |\
						L2C_DEFAULT(TGT_ECC, TGTECC3) \
						)
#define L2C_TGT_ECC_MASK			(\
						L2C_TGT_ECC_TGTECC0_MASK |\
						L2C_TGT_ECC_TGTECC1_MASK |\
						L2C_TGT_ECC_TGTECC2_MASK |\
						L2C_TGT_ECC_TGTECC3_MASK \
						)

// L2 HPM counter event0~31 (RW)
//#define L2C_HPM_CNT_ENT_MASK			(BIT_MASK(63, 0))	
#define L2C_HPM_CNT_ENT_MASK			0xFFFFFFFFFFFFFFFF
#define L2C_HPM_CNT_ENT_OFFSET			(0)			
#define L2C_HPM_CNT_ENT_DEFAULT			(0x0)			

// L2 cctl command definitions
#define L2_IX_INVAL				0
#define L2_IX_WB				1
#define L2_IX_WBINVAL				2
#define L2_PA_INVAL				8
#define L2_PA_WB				9
#define L2_PA_WBINVAL				10
#define L2_TGT_WRITE				16
#define L2_TGT_READ				17
#define L2_FLUSH				18

// ======================================================
// L2C access macro 
// ======================================================
#define L2C_SET_FIELD(var, reg, field, value)	SET_FIELD(var, L2C_##reg##_##field##_##MASK, L2C_##reg##_##field##_##OFFSET, value)
#define L2C_GET_FIELD(var, reg, field)		GET_FIELD(var, L2C_##reg##_##field##_##MASK, L2C_##reg##_##field##_##OFFSET)
#define L2C_TEST_FIELD(var, reg, field)	TEST_FIELD(var, L2C_##reg##_##field##_##MASK)

#define L2C_EXTRACT(reg, field, value)		EXTRACT_FIELD(value, L2C_##reg##_##field##_##MASK, L2C_##reg##_##field##_##OFFSET )
#define L2C_PREPARE(reg, field, value)		PREPARE_FIELD(value, L2C_##reg##_##field##_##MASK, L2C_##reg##_##field##_##OFFSET )

#define L2C_DEFAULT(reg, field)		PREPARE_FIELD(L2C_##reg##_##field##_##DEFAULT, L2C_##reg##_##field##_##MASK, L2C_##reg##_##field##_##OFFSET )

#endif // __L2C_H

