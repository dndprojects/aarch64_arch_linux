//   Request-reply client in C++
//   Connects REQ socket to tcp://localhost:5559
//   Sends "Hello" to server, expects "World" back
//
// Olivier Chamoux <olivier.chamoux@fr.thalesgroup.com>

#include "zhelpers.hpp"
//#include <zmq.hpp>

std::string string_replace(std::string src, std::string const& target, std::string const& repl);



int main (int argc, char *argv[])
{
    zmq::context_t context(1);

    zmq::socket_t requester(context, ZMQ_REQ);
    requester.connect("tcp://127.0.0.1:5555");
    std::string sendtoserve = argv[1];
    int size = argc ;
     for( int i = 2; i < size; i++)
     {
       sendtoserve = sendtoserve+">="+argv[i];
     }
      std::cout << "Send  " << sendtoserve << std::endl;

//    sendtoserve = string_replace(sendtoserve, " ", ">=");

    for( int request = 1 ; request < 2 ; request++) {
        
        s_send (requester, sendtoserve+">=");
        std::string string = s_recv (requester);
        
        std::cout << "Received reply " << request << " [" << string << "]" << std::endl;
    }

}

std::string string_replace(std::string src, std::string const& target, std::string const& repl)
{
    // handle error situations/trivial cases

    if (target.length() == 0) {
        // searching for a match to the empty string will result in 
        //  an infinite loop
        //  it might make sense to throw an exception for this case
        return src;
    }

    if (src.length() == 0) {
        return src;  // nothing to match against
    }

    size_t idx = 0;

    for (;;) {
        idx = src.find( target, idx);
        if (idx == std::string::npos)  break;

        src.replace( idx, target.length(), repl);
        idx += repl.length();
    }

    return src;
}
