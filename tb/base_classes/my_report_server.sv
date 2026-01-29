`ifndef MY_REPORT_SERVER
`define MY_REPORT_SERVER


import "DPI-C" function string get_simulation_start_time();

class my_report_server extends uvm_default_report_server;

    // ANSI-коды цветов для терминала
    localparam string RED             = "\033[31;0m";
    localparam string RED_BOLD        = "\033[31;1m";
    localparam string RED_BACKGROUND  = "\033[30;41m";
    localparam string YELLOW_BOLD     = "\033[33;1m";
    localparam string CYAN            = "\033[36m";
    localparam string CYAN_UNDERLINED = "\033[36;4m";
    localparam string BLACK           = "\033[30m";
    localparam string PURPLE          = "\033[35m";
    localparam string BLUE            = "\033[34m";
    localparam string BLUE_ITALIC     = "\033[34;3m";
    localparam string BLUE_BOLD       = "\033[34;1m";
    localparam string BRIGHT_CYAN     = "\033[96m";

    localparam string DEFAULT         = "\033[0m";

    


    // Переменные для цветов 
    string info_color    = BLUE_BOLD;
    string warning_color = YELLOW_BOLD;
    string error_color   = RED_BOLD;
    string fatal_color   = RED_BACKGROUND;
    
    string time_color    = CYAN;
    string id_color      = CYAN_UNDERLINED;
    string msg_color     = DEFAULT;
    string reset         = DEFAULT;




    bit    no_color      = 0;      // Флаг отключения цветов



    protected int errors_fd;       // Дескриптор файла для логирования
    protected int sim_log_fd;      // Дескриптор файла для sim_log

    string test_name = "UNKNOWN";  // Имя теста
    string run_count = "0";        // Номер запуска
    string sim_log_file;           // Имя файла sim_log
    string start_time_sim;         // Время старта симуляции
    string log_header;
    int    seed;
    bit    has_errors = 0;
    

    function new();
        uvm_cmdline_processor clp = uvm_cmdline_processor::get_inst();
        string clp_args[$];

        // Получаем флаг отключения цветов
        if (clp.get_arg_matches("+UVM_REPORT_NOCOLOR", clp_args)) begin
            no_color = 1;
        end

        // Получаем имя теста из +UVM_TESTNAME
        if (clp.get_arg_value("+UVM_TESTNAME=", test_name) == 0) begin
            test_name = "UNKNOWN";
        end

        // Получаем номер запуска из +RUN_COUNT
        if (clp.get_arg_value("+RUN_COUNT=", run_count) == 0) begin
            run_count = "0";
        end

        // Получаем значение seed
        seed = $get_initial_random_seed();

        // Получаем время старта симуляции из C-функции
        start_time_sim = get_simulation_start_time();
        

        // Формируем имя файла sim_log
        sim_log_file = $sformatf("sim_log_%s_%s.log", test_name, run_count);

        
        errors_fd = $fopen("errors.log", "a");
        if (errors_fd == 0) begin
            uvm_report_fatal("REPORT_SERVER", "Failed to open errors.log for logging!");
        end

        // Открываем файл sim_log
        sim_log_fd = $fopen(sim_log_file, "w");
        if (sim_log_fd == 0) begin
            uvm_report_fatal("REPORT_SERVER", $sformatf("Failed to open %s for logging!", sim_log_file));
        end

        
        log_header = $sformatf("---------- Test: %s, Run: %s, Seed: %0d, Start time: %s ----------\n", 
                              test_name, run_count, seed, start_time_sim);
        $fdisplay(sim_log_fd, "%s", log_header);
        $fflush(sim_log_fd);

        //$fdisplay(errors_fd, "%s", log_header);
        //$fflush(errors_fd);
        
    endfunction

    virtual function void execute_report_message(uvm_report_message report_message, string composed_message);
        // Убираем ANSI-коды цветов для файла
        string plain_message = remove_ansi_codes(composed_message);
        
        // Запись в sim_log_*.txt для всех сообщений
        $fdisplay(sim_log_fd, "%s", plain_message);
        $fflush(sim_log_fd);

        if (report_message.get_severity() inside {UVM_WARNING, UVM_ERROR, UVM_FATAL}) begin
            if (has_errors == 0) begin
                $fdisplay(errors_fd, "%s", log_header);
                $fflush(errors_fd);
            end

            has_errors = 1;
            $fdisplay(errors_fd, "%s", plain_message);
            $fflush(errors_fd);  // Сбрасываем буфер для гарантии записи
        end
        super.execute_report_message(report_message, composed_message);
    endfunction: execute_report_message

    

    // Вспомогательная функция для удаления ANSI-кодов (чтобы лог в файле был без "мусора")
    protected function string remove_ansi_codes(string s);
        string result = "";
        bit in_ansi = 0;
        foreach (s[i]) begin
            if (s[i] == "\033") in_ansi = 1;
            else if (in_ansi && (s[i] == "m")) in_ansi = 0;
            else if (!in_ansi) result = {result, s[i]};
        end
        return result;
    endfunction

    virtual function string compose_report_message( 
        uvm_report_message report_message,
        string             report_object_name = "" 
    );
        string result;

        uvm_severity severity = report_message.get_severity();
        string name           = report_message.get_report_object().get_type_name();
        string id             = report_message.get_id();
        string message        = report_message.get_message();
        string filename       = report_message.get_filename();
        int    line           = report_message.get_line();

        string sev_str, time_str, id_str, msg_str, file_str;

        if (no_color) begin
            sev_str  = {severity.name(), "\n"};

            if (filename == "")
                file_str = "";
            else
                file_str = $sformatf("%s |Line: %2d\n", filename, line);

            time_str   = {"Time: ", $sformatf("%0t", $time)};
            id_str     = id;
            msg_str    = {"Message: ", message, "\n\n"};
        end 
        else begin
            string sev_color;

            case (severity)
                UVM_INFO:    sev_color = info_color;
                UVM_WARNING: sev_color = warning_color;
                UVM_ERROR:   sev_color = error_color;
                UVM_FATAL:   sev_color = fatal_color;
                default:     sev_color = reset;
            endcase
            
            sev_str    = {sev_color, severity.name(), DEFAULT, "\n"};

            if (filename == "")
                file_str = "";
            else
                file_str = $sformatf("%s |Line: %2d\n", filename, line);
            
            time_str   = {"Time: ", $sformatf("%s%0t%s",time_color, $time, DEFAULT)};
            id_str     = {id_color, id, DEFAULT};
            
            msg_str = {BLUE_ITALIC, "Message: ", DEFAULT, msg_color, message, DEFAULT, "\n\n"};
        end

        result = $sformatf("%s%s%s | %-21s | %s: \n%s",
                        sev_str,
                        file_str,
                        time_str,
                        name,
                        id_str,
                        msg_str
        ); 

        return result;
    endfunction: compose_report_message

    virtual function void report_summarize(UVM_FILE file=0);
        super.report_summarize(file);
        if (file != 0) begin
            $fclose(file);
        end
        

        $fclose(errors_fd);
        $fclose(sim_log_fd);
    endfunction: report_summarize

endclass
`endif