`ifdef ATCGPIO100_CONFIG_VH
`else
`define ATCGPIO100_CONFIG_VH

//-------------------------------------------------
// GPIO Channel Number
//-------------------------------------------------
// Available value: 1~32
`define ATCGPIO100_GPIO_NUM 32

//-------------------------------------------------
// GPIO Pull Option
//-------------------------------------------------
`define ATCGPIO100_PULL_SUPPORT

//-------------------------------------------------
// GPIO Interrupt Option
//-------------------------------------------------
`define ATCGPIO100_INTR_SUPPORT

//-------------------------------------------------
// GPIO Debounce Option
//-------------------------------------------------
`define ATCGPIO100_DEBOUNCE_SUPPORT

`endif // ATCGPIO100_CONFIG_VH

