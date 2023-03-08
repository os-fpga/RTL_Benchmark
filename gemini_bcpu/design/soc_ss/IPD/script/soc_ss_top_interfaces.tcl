    set prjName soc_ss_prj
    project::setCurrentProject  $prjName

    ## clock
    # Set the bus definition
    set busDef_clock_Vendor  rapidsilicon
    set busDef_clock_Library gemini
    set busDef_clock_Name    clock_soc
    set busDef_clock_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_clock_Vendor $busDef_clock_Library $busDef_clock_Name $busDef_clock_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_clock_Name
    busdefinition::setProperty direct_connection true    
    # Saving
    busdefinition::save

    ## reset
    # Set the bus definition
    set busDef_reset_Vendor  rapidsilicon
    set busDef_reset_Library gemini
    set busDef_reset_Name    reset_soc
    set busDef_reset_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_reset_Vendor $busDef_reset_Library $busDef_reset_Name $busDef_reset_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_reset_Name
    # Saving
    busdefinition::save

    ## PLL
    # Set the bus definition
    set busDef_pll_Vendor  rapidsilicon
    set busDef_pll_Library gemini
    set busDef_pll_Name    pll_soc
    set busDef_pll_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_pll_Vendor $busDef_pll_Library $busDef_pll_Name $busDef_pll_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_pll_Name
    # Saving
    busdefinition::save    


    ## UART
    # Set the bus definition
    set busDef_uart_Vendor  rapidsilicon
    set busDef_uart_Library gemini
    set busDef_uart_Name    uart
    set busDef_uart_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_uart_Vendor $busDef_uart_Library $busDef_uart_Name $busDef_uart_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_uart_Name
    # Saving
    busdefinition::save    

    ## I2C
    # Set the bus definition
    set busDef_i2c_Vendor  rapidsilicon
    set busDef_i2c_Library gemini
    set busDef_i2c_Name    i2c
    set busDef_i2c_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_i2c_Vendor $busDef_i2c_Library $busDef_i2c_Name $busDef_i2c_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_i2c_Name
    # Saving
    busdefinition::save      

    ## SPI
    # Set the bus definition
    set busDef_spi_Vendor  rapidsilicon
    set busDef_spi_Library gemini
    set busDef_spi_Name    spi
    set busDef_spi_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_spi_Vendor $busDef_spi_Library $busDef_spi_Name $busDef_spi_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_spi_Name
    # Saving
    busdefinition::save      

    ## GPIO
    # Set the bus definition
    set busDef_gpio_Vendor  rapidsilicon
    set busDef_gpio_Library gemini
    set busDef_gpio_Name    gpio
    set busDef_gpio_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_gpio_Vendor $busDef_gpio_Library $busDef_gpio_Name $busDef_gpio_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_gpio_Name
    # Saving
    busdefinition::save     

    # ## GPT
    # # Set the bus definition
    # set busDef_gpt_Vendor  rapidsilicon
    # set busDef_gpt_Library gemini
    # set busDef_gpt_Name    gpt
    # set busDef_gpt_Version 1.0
    # # Create the bus definition
    # project::createResource busdefinition $prjName $busDef_gpt_Vendor $busDef_gpt_Library $busDef_gpt_Name $busDef_gpt_Version
    # # Set current bus definition
    # busdefinition::setCurrentBusDefinition $busDef_gpt_Name
    # # Saving
    # busdefinition::save      

    ## GBE
    # Set the bus definition
    set busDef_gbe_Vendor  rapidsilicon
    set busDef_gbe_Library gemini
    set busDef_gbe_Name    gbe
    set busDef_gbe_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_gbe_Vendor $busDef_gbe_Library $busDef_gbe_Name $busDef_gbe_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_gbe_Name
    # Saving
    busdefinition::save    

    ## USB
    # Set the bus definition
    set busDef_usb_Vendor  rapidsilicon
    set busDef_usb_Library gemini
    set busDef_usb_Name    usb
    set busDef_usb_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_usb_Vendor $busDef_usb_Library $busDef_usb_Name $busDef_usb_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_usb_Name
    # Saving
    busdefinition::save             

    ## FCB
    # Set the bus definition
    set busDef_fcb_Vendor  rapidsilicon
    set busDef_fcb_Library gemini
    set busDef_fcb_Name    fcb
    set busDef_fcb_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_fcb_Vendor $busDef_fcb_Library $busDef_fcb_Name $busDef_fcb_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_fcb_Name
    # Saving
    busdefinition::save  

    ## JTAG
    # Set the bus definition
    set busDef_jtag_Vendor  rapidsilicon
    set busDef_jtag_Library gemini
    set busDef_jtag_Name    jtag
    set busDef_jtag_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_jtag_Vendor $busDef_jtag_Library $busDef_jtag_Name $busDef_jtag_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_jtag_Name
    # Saving
    busdefinition::save      

    ## DDR
    # Set the bus definition
    set busDef_ddr_Vendor  rapidsilicon
    set busDef_ddr_Library gemini
    set busDef_ddr_Name    ddr
    set busDef_ddr_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_ddr_Vendor $busDef_ddr_Library $busDef_ddr_Name $busDef_ddr_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_ddr_Name
    # Saving
    busdefinition::save       

    ## FPGA IRQ
    # Set the bus definition
    set busDef_fpga_irq_Vendor  rapidsilicon
    set busDef_fpga_irq_Library gemini
    set busDef_fpga_irq_Name    fpga_irq
    set busDef_fpga_irq_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_fpga_irq_Vendor $busDef_fpga_irq_Library $busDef_fpga_irq_Name $busDef_fpga_irq_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_fpga_irq_Name
    # Saving
    busdefinition::save        

    ## FPGA DMA
    # Set the bus definition
    set busDef_fpga_dma_Vendor  rapidsilicon
    set busDef_fpga_dma_Library gemini
    set busDef_fpga_dma_Name    fpga_dma
    set busDef_fpga_dma_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_fpga_dma_Vendor $busDef_fpga_dma_Library $busDef_fpga_dma_Name $busDef_fpga_dma_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_fpga_dma_Name
    # Saving
    busdefinition::save       

    ## FPGA Configuration interface
    # Set the bus definition
    set busDef_fpga_cfg_Vendor  rapidsilicon
    set busDef_fpga_cfg_Library gemini
    set busDef_fpga_cfg_Name    fpga_cfg
    set busDef_fpga_cfg_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_fpga_cfg_Vendor $busDef_fpga_cfg_Library $busDef_fpga_cfg_Name $busDef_fpga_cfg_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_fpga_cfg_Name
    # Saving
    busdefinition::save     

    ## isolation cell control interface
    # Set the bus definition
    set busDef_fpga_cfg_Vendor  rapidsilicon
    set busDef_fpga_cfg_Library gemini
    set busDef_fpga_cfg_Name    iso_cntl
    set busDef_fpga_cfg_Version 1.0
    # Create the bus definition
    project::createResource busdefinition $prjName $busDef_fpga_cfg_Vendor $busDef_fpga_cfg_Library $busDef_fpga_cfg_Name $busDef_fpga_cfg_Version
    # Set current bus definition
    busdefinition::setCurrentBusDefinition $busDef_fpga_cfg_Name
    # Saving
    busdefinition::save    
    

    # # Create logical ports and set their properties
    # abstractiondefinition::setCurrentAbstractionDefinition AXILite_rtl

    # set portName    ARREADY
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       1
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   out

    # set portName    AWREADY
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       1
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   out  
    
    # set portName    BRESP
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      2
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       2
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   out    

    # set portName    BVALID
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       1
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   out     

    # set portName    RDATA
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   out  

    # set portName    RRESP
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      2
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       2
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   out   

    # set portName    RVALID
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       1
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

    # set portName    WREADY
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       1
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   out                      

    # set portName    ARADDR
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster                true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width          32
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction      out
    # abstractiondefinition::setPortProperty  $portName   onslave                 true
    # abstractiondefinition::setPortProperty  $portName   onslave-width           32
    # abstractiondefinition::setPortProperty  $portName   onslave-direction       in
    # abstractiondefinition::setPortProperty  $portName   qualifier-is_address    true

    # set portName    ARVALID
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       1
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   in 

    # set portName    AWADDR
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster                true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width          32
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction      out
    # abstractiondefinition::setPortProperty  $portName   onslave                 true
    # abstractiondefinition::setPortProperty  $portName   onslave-width           32
    # abstractiondefinition::setPortProperty  $portName   onslave-direction       in
    # abstractiondefinition::setPortProperty  $portName   qualifier-is_address    true    

    # set portName    AWVALID
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       1
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   in     

    # set portName    BREADY
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       1
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   in  

    # set portName    RREADY
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       1
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   in 

    # set portName    WDATA
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   in         

    # set portName    WVALID
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       1
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   in             

    # set portName    ARPROT
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      2
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       2
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   in      

    #     set portName    AWPROT
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      2
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       2
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   in      

    #     set portName    WSTRB
    # abstractiondefinition::createPort   $portName   wire_port
    # abstractiondefinition::setPortProperty  $portName   onmaster            true
    # abstractiondefinition::setPortProperty  $portName   onmaster-width      3
    # abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    # abstractiondefinition::setPortProperty  $portName   onslave             true
    # abstractiondefinition::setPortProperty  $portName   onslave-width       3
    # abstractiondefinition::setPortProperty  $portName   onslave-direction   in      

    # Saving
    abstractiondefinition::save


    #Create UART abs def
    project::createResource abstractiondefinition soc_ss_prj andes gemini UART_rtl 1.0
    abstractiondefinition::setProperty bus_type [list $busDef_uart_Vendor $busDef_uart_Library $busDef_uart_Name $busDef_uart_Version]
    abstractiondefinition::setCurrentAbstractionDefinition UART_rtl

    set portName    SOUT
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in 

    set portName    SIN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

    set portName    CTSN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

    set portName    RTSN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in 
        abstractiondefinition::save




    #Create I2C abs def
    project::createResource abstractiondefinition soc_ss_prj andes gemini I2C_rtl 1.0
    abstractiondefinition::setProperty bus_type [list $busDef_i2c_Vendor $busDef_i2c_Library $busDef_i2c_Name $busDef_i2c_Version]
    abstractiondefinition::setCurrentAbstractionDefinition I2C_rtl
    set portName    SCL_O
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in 

    set portName    SDA_O
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in 

     set portName    SCL_I
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 
    
    set portName    SDA_I
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out  
    abstractiondefinition::save


    #Create SPI abs def
    project::createResource abstractiondefinition soc_ss_prj andes gemini QSPI_rtl 1.0
    abstractiondefinition::setProperty bus_type [list $busDef_spi_Vendor $busDef_spi_Library $busDef_spi_Name $busDef_spi_Version]
    abstractiondefinition::setCurrentAbstractionDefinition QSPI_rtl

        set portName    CS_N_IN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

        set portName    HOLD_N_IN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

    set portName    HOLD_N_OE
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in

    set portName    HOLD_N_OUT
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in     

        set portName    WP_N_IN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out     

    set portName    WP_N_OE
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in

    set portName    WP_N_OUT
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in     

        set portName    CLK_IN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out  

        set portName    CLK_OE
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in

        set portName    CLK_OUT
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in

        set portName    CS_N_OE
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in

        set portName    CS_N_OUT
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in       

        set portName    MISO_IN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

    set portName    MISO_OE
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in

    set portName    MISO_OUT
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in     

        set portName    MOSI_IN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

    set portName    MOSI_OE
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in

    set portName    MOSI_OUT
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in  
    abstractiondefinition::save

    #Create GPIO abs def
    project::createResource abstractiondefinition soc_ss_prj andes gemini GPIO_rtl 1.0
    abstractiondefinition::setProperty bus_type [list $busDef_gpio_Vendor $busDef_gpio_Library $busDef_gpio_Name $busDef_gpio_Version]
    abstractiondefinition::setCurrentAbstractionDefinition GPIO_rtl


    set portName    GPIO_PULLDOWN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      32
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       32
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in

    set portName    GPIO_PULLUP
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      32
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       32
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in

        set portName    GPIO_OE
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      32
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       32
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in

        set portName    GPIO_OUT
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      32
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       32
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in    

        set portName    GPIO_IN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      32
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       32
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out     
    abstractiondefinition::save


    #Create GbE abs def
    project::createResource abstractiondefinition soc_ss_prj rapidsilicon gemini GBE_rtl 1.0
    abstractiondefinition::setProperty bus_type [list $busDef_gbe_Vendor $busDef_gbe_Library $busDef_gbe_Name $busDef_gbe_Version]
    abstractiondefinition::setCurrentAbstractionDefinition GBE_rtl

        set portName    RGMII_TXD
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      4
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       4
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in 

        set portName    RGMII_TX_CTL
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in 

        set portName    RGMII_RXD
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      4
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       4
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

        set portName    RGMII_RX_CTL
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

        set portName    RGMII_RXC
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

        set portName    MDIO_MDC
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in 

        set portName    MDIO_DATA
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  inout
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   inout         
    abstractiondefinition::save

    #Create USB abs def
    project::createResource abstractiondefinition soc_ss_prj rapidsilicon gemini USB_rtl 1.0
    abstractiondefinition::setProperty bus_type [list $busDef_usb_Vendor $busDef_usb_Library $busDef_usb_Name $busDef_usb_Version]
    abstractiondefinition::setCurrentAbstractionDefinition USB_rtl

        set portName    DP
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  inout
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   inout 

        set portName    DN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      32
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  inout
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       32
    abstractiondefinition::setPortProperty  $portName   onslave-direction   inout 

            set portName    XTAL_IN
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  in
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   out 

            set portName    XTAL_OUT
    abstractiondefinition::createPort   $portName   wire_port
    abstractiondefinition::setPortProperty  $portName   onmaster            true
    abstractiondefinition::setPortProperty  $portName   onmaster-width      1
    abstractiondefinition::setPortProperty  $portName   onmaster-direction  out
    abstractiondefinition::setPortProperty  $portName   onslave             true
    abstractiondefinition::setPortProperty  $portName   onslave-width       1
    abstractiondefinition::setPortProperty  $portName   onslave-direction   in 
        abstractiondefinition::save


