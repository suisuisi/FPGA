library verilog;
use verilog.vl_types.all;
entity Line_Shift_RAM_8Bit is
    generic(
        RAM_Length      : vl_logic_vector(9 downto 0) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        clken           : in     vl_logic;
        clock           : in     vl_logic;
        shiftin         : in     vl_logic_vector(7 downto 0);
        shiftout        : out    vl_logic_vector(7 downto 0);
        taps0x          : out    vl_logic_vector(7 downto 0);
        taps1x          : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RAM_Length : constant is 2;
end Line_Shift_RAM_8Bit;
