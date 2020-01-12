library verilog;
use verilog.vl_types.all;
entity CMOS_Capture_RGB565 is
    generic(
        CMOS_FRAME_WAITCNT: vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi1, Hi0)
    );
    port(
        clk_cmos        : in     vl_logic;
        rst_n           : in     vl_logic;
        cmos_pclk       : in     vl_logic;
        cmos_xclk       : out    vl_logic;
        cmos_vsync      : in     vl_logic;
        cmos_href       : in     vl_logic;
        cmos_data       : in     vl_logic_vector(7 downto 0);
        cmos_frame_vsync: out    vl_logic;
        cmos_frame_href : out    vl_logic;
        cmos_frame_data : out    vl_logic_vector(15 downto 0);
        cmos_frame_clken: out    vl_logic;
        cmos_fps_rate   : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CMOS_FRAME_WAITCNT : constant is 1;
end CMOS_Capture_RGB565;
