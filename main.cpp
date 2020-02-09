#include <predef.h>
#include <stdio.h>
#include <ctype.h>
#include <startnet.h>
#include <autoupdate.h>
#include <dhcpclient.h>
#include <smarttrap.h>
#include <taskmon.h>
#include <NetworkDebug.h>
#include <sim.h>

#include <iostream>
#include <functional>

extern "C" {
void UserMain(void * pd);
}

// defines declared in CMakeLists.txt
const char * AppName = PROJECT_NAME PROJECT_VERSION;

void UserMain(void * pd) {
    EnableOSStackProtector(); // TODO: Uncomment #define UCOS_STACKOVERFLOW in predef.h, rebuild libraries
    InitializeStack();
    GetDHCPAddressIfNecessary();
    OSChangePrio(MAIN_PRIO);
    EnableAutoUpdate();
    StartHTTP();
    EnableTaskMonitor();

    #ifndef _DEBUG
    EnableSmartTraps();
    #endif

    #ifdef _DEBUG
    InitializeNetworkGDB_and_Wait();
    #endif

    sim2.scm.cwcr &= 0xFF7F; // Disable WatchDog

    printf("Application started\n");

    std::cout << "Hello from GCC" <<  __VERSION__ << "!\n"
                 "Build " << __DATE__ << " " << __TIME__ << '\n';

    while (1) {
        OSTimeDly(TICKS_PER_SECOND);
    }
}
