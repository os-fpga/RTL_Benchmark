#include <gtest/gtest.h>
#include <string>

#include "ethlc.hpp"

//TEST_F(TestDev, test_0)
TEST(TestDev, test_0)
{
    // dec vars
    std::string dev_addr;
    std::string details;
    bool result;
    
    // prep CORRECT ipv4-addr
    dev_addr = "192.168.43.5"; // ..\vtest\sw\dev\test_main\src\main\test_main.c
    
    // proc
    try {
        // ??
        ethlc dev(dev_addr); // auto-destr later / -> leave visibility-region
        
        // proc
        result = dev.ethlc_proc();
        dev.ethlc_gdet(details);
        ASSERT_EQ(result, true) << std::endl << details;
    }
    catch (int val) {
        FAIL() << "-> ethlc-init problem#0" << std::endl;
    }
    
    // Final
}
