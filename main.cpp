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

// define declared in CMakeLists.txt
#ifdef PROJECT_NAME
    #define APP_NAME PROJECT_NAME
#else
    #define APP_NAME "Unknown-project"
#endif

extern "C" {
void UserMain(void * pd);
}

const char * AppName = APP_NAME;

void UserMain(void * pd) {
    EnableOSStackProtector(); // TODO: Uncomment #define UCOS_STACKOVERFLOW in predef.h, rebuild libraries
    InitializeStack();
    GetDHCPAddressIfNecessary();
    OSChangePrio(MAIN_PRIO);
    EnableAutoUpdate();
    EnableTaskMonitor();
    StartHTTP();

    #ifndef _DEBUG
    EnableSmartTraps();
    #endif

    #ifdef _DEBUG
       InitializeNetworkGDB_and_Wait();
    #endif

    sim2.scm.cwcr &= 0xFF7F; // Disable WatchDog

    printf("Application %s started\n", AppName);

    std::cout << "Hello from GCC " <<  __VERSION__ << "!\n"
                 "Build " << __DATE__ << " " << __TIME__ << '\n';

    while (1) {
        OSTimeDly(TICKS_PER_SECOND);
    }
}
