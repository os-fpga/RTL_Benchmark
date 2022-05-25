#ifndef _ETHLC_HPP_
#define _ETHLC_HPP_

#include <cstdio>
#include <iostream>
#include <sstream>
#include <string>

class ethlc {
public:
    
    ethlc(const std::string& addr); // contr+init
    virtual ~ethlc();
    
    bool ethlc_proc(void);
    void ethlc_gdet(std::string& pdetails);
    
private:
// PROC:
    ethlc(); // 'hide' std-constr
    
    bool exec_shell_cmd(const std::string&  command,
                        std::string&        output,
                        const std::string&  mode);
// DATA:
    std::string address;
    std::string details;
};

#endif // _ETHLC_HPP_