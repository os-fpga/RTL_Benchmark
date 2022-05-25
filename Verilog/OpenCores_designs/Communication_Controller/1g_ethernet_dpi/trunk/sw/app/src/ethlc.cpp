#include "ethlc.hpp"

/**
 * @brief   private: Execute Generic Shell Command
 *
 * @param[in]   command Command to execute.
 * @param[out]  output  Shell output.
 * @param[in]   mode read/write access
 *
 * @return 0 for success, 1 otherwise.
 *
*/
bool ethlc::exec_shell_cmd( const std::string&  command,
                            std::string&        output,
                            const std::string&  mode = "r")
{
    // Create the stringstream
    std::stringstream sout;
    // Run Popen
    FILE *in;
    char buff[512];
    // Test output
    if(!(in = popen(command.c_str(), mode.c_str()))){
        return 1;
    }
    // Parse output
    while(fgets(buff, sizeof(buff), in)!=NULL){
        sout << buff;
    }
    // Close
    int exit_code = pclose(in);
    // set output
    output = sout.str();
    // Return exit code
    return exit_code;
}



/**
 * @brief   public: Open-dev / class-constr /
 *
 * @param[in] address   dev IPv4-addr
 *
 * @return 0 for success, 1 otherwise.
 *
*/
ethlc::ethlc(const std::string& addr)
{
    // dec vars
    int code_sim, code_hw;
    std::string command;
    std::string details_sim, details_hw;

    // record addr
    address = addr;

    // ARPING it / sim
    command = "arping -c 1 " + address + " -I tap0"+ " 2>&1"; // !!!redirecting stderr to stdout
    code_sim = exec_shell_cmd(command, details_sim);

    // ARPING it / hw
    command = "arping -c 1 " + address + " -I eth0"+ " 2>&1"; // ..
    code_hw = exec_shell_cmd(command, details_hw);

    // final deal
    if ((code_hw != 0) && (code_sim != 0)) { // no device found
        std::cout << "no device found - 'ethlc::ethlc'" << std::endl;
        throw 7;
    } else {
        // if we are here - OK
        if (code_hw == -1) {
            details = details_sim;
        } else {
            details = details_hw;
        }
    }
}

/**
 * @brief   public: Close-dev / class-destr /
 *
 * @return 0 for success, 1 otherwise.
 *
*/
ethlc::~ethlc()
{
    // placeholder
}


/**
 * @brief   public: Work with dev
 *
 * @return 0 for success, 1 otherwise.
 *
*/
bool ethlc::ethlc_proc(void)
{
    // just PING it / ;)
    std::string command = "ping -c 1 " + address + " 2>&1"; // !!!redirecting stderr to stdout
    int code = exec_shell_cmd(command, details);
    return (code == 0);
}


/**
 * @brief   public: Out2usr detailes of shell output
 *
 * @param[out]  output  Shell output.
 *
*/
void ethlc::ethlc_gdet(std::string& pdetails)
{
    pdetails = details;
}
