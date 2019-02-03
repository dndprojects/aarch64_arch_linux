//
//  Hello World server in C++
//  Binds REP socket to tcp://*:5555
//  Expects "Hello" from client, replies with "World"
//
#include <zmq.hpp>
#include <string>
#include <iostream>
#include <unistd.h>


#define ZMQ_DELETED_FUNCTION = delete

int main () {
    //  Prepare our context and socket
    zmq::context_t context (1);
    zmq::socket_t socket (context, ZMQ_REP);
    socket.bind ("tcp://*:5555");
    zmq::message_t reply (10);
    //memcpy ((void *) reply.data (), "BAD" , 3);

   while (true) {
        zmq::message_t request;
        //  Wait for next request from client
        socket.recv (&request);
        std::string zrequest ((char*) request.data());
        std::string delimiter = ">=";
        std::string myreq = "";
        myreq = zrequest.substr(0, zrequest.find(delimiter));
        std::string option2 = zrequest.erase(0, myreq.length() + delimiter.length());
        std::string option = option2.substr(0, zrequest.find(delimiter));
        //std::cout << "Received --> " << myreq << std::endl;
        //std::cout << "Received --> " << option << std::endl;
        
        std::string str1 ("systemctl_restart");
        std::string str2 ("systemctl_start");
        std::string str3 ("systemctl_stop");
        std::string str4 ("playmusic");
        std::string str5 ("stopmusic");
        std::string str6 ("runscript");
        std::string str7 ("wake_up_pc");
        std::string str8 ("mm_check_db");
        std::string str9 ("mm_check_in");
		std::string str10 ("openssh");
		std::string str11 ("closessh");

		
	if (myreq.compare(str1) == 0) {
        system(("systemctl restart "+option+" &" ).c_str());
        }

        if (myreq.compare(str2) == 0) {
        system(("systemctl start "+option+" &" ).c_str());
        }

        if (myreq.compare(str3) == 0) {
        system(("systemctl stop "+option+" &" ).c_str());
        }

        if (myreq.compare(str4) == 0) {
        system(("/opt/domoticz/scripts/IR/play_music.csh "+option+" &" ).c_str());
        }

        if (myreq.compare(str5) == 0) {
        system("/opt/domoticz/scripts/IR/stop_music.csh &");
        }

        if (myreq.compare(str6) == 0) {
        system((" "+option+" &" ).c_str());
        }

        if (myreq.compare(str7) == 0) {
        system(("wol "+option).c_str());
        }

        if (myreq.compare(str8) == 0) {
        system("/home/home_ssh/dev/bin/mm_check_db.pl &");
        }

        if (myreq.compare(str9) == 0) {
        system("/home/home_ssh/dev/bin/mm_check_in.pl &");
        }
		if (myreq.compare(str10) == 0) {
        system("upnpc -e 'SSH on Raspberry Pi' -r 22 TCP &");
        }
		if (myreq.compare(str11) == 0) {
        system("upnpc -d 22 TCP &");
        }

        socket.send (reply);
    }
    return 0;

}

