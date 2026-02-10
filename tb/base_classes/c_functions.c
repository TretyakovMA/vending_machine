#ifndef C_FUNCTIONS
#define C_FUNCTIONS

#include <svdpi.h>
#include <time.h>

const char* get_simulation_start_time() {
    time_t now = time(NULL);
    struct tm* timeinfo = localtime(&now);
        
    static char time_buffer[80];
    strftime(time_buffer, sizeof(time_buffer), 
            "%d-%m-%Y %H:%M:%S", timeinfo);
        
    return time_buffer;
}
#endif