`ifndef BASE_MACROS
`define BASE_MACROS

    `define START_TEST_STR {\
        "\n",{50{"#"}},\
        "   \033[35mStart Test\033[0m   ",\
        {50{"#"}}\
    }

    `define SEND_TR_STR(TR) {\
        "\n", \
        {46{"*"}}, \
        "   Send transaction   ", \
        {46{"*"}},\
        "\nDriver->DUT:\n", \
        TR.convert2string(), \
        "\n", \
        {114{"*"}}\
    }

    `define GET_TR_STR(TR) {\
        "\n",\
        {47{"*"}},\
        "   Get transaction   ",\
        {46{"*"}},\
        "\nDUT->Scoreboard:\n", \
        TR.convert2string(), \
        "\n", \
        {114{"*"}}\
    }

    `define EXP_TR_STR(TR) {\
        "\n",\
        {44{"*"}},\
        "   Expected transaction   ",\
        {44{"*"}},\
        "\n",\
        TR.convert2string(), \
        "\n", \
        {114{"*"}}\
    }

    `define RES_STR_1 {"\n", {51{"!"}}, "   Result   ", {51{"!"}}, "\n"}
    `define RES_STR_2 {"\n", {114{"!"}}}

    `define RES_SUC_STR{\
        `RES_STR_1, \
        {49{" "}}, \
        "\033[32mTest successful\033[0m", \
        `RES_STR_2\
    }

    `define RES_FAILD_STR{\
        `RES_STR_1, \
        {51{" "}}, \
        "\033[31mTest faild\033[0m", \
        `RES_STR_2\
    }

    `define END_TEST_STR {\
        "\n", \
        {51{"#"}},\
        "   \033[35mEnd Test\033[0m   ", \
        {51{"#"}}\
    }

`endif