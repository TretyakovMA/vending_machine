#include "svdpi.h"
#include <ctime>
#include <string>

extern "C" {
    const char* get_simulation_start_time() {
        time_t now = time(nullptr);
        struct tm* timeinfo = localtime(&now);
        
        static char time_buffer[80];
        strftime(time_buffer, sizeof(time_buffer), 
                "%Y-%m-%d %H:%M:%S", timeinfo);
        
        return time_buffer;
    }
}