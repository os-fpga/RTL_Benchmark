#include <gtest/gtest.h>
#include <string>

#include "ethlc.hpp"

//TEST_F(TestDev, test_1)
TEST(TestDev, test_1)
{
    // dec vars
    std::string dev_addr;
    std::string details;
    bool result;
    
    // prep WRONG ipv4-addr
    dev_addr = "192.168.43.6";
    
    // proc
    try {
        ethlc dev(dev_addr);
        // if there are here == ERR
        FAIL() << "-> ethlc-init problem#1" << std::endl;
    }
    catch (int val) { // no device found == OK
        SUCCEED();
    }
    // Final
}
