library verilog;
use verilog.vl_types.all;
entity Video_Image_Simulate_CMOS is
    generic(
        CMOS_VSYNC_VALID: vl_logic := Hi1;
        IMG_HDISP       : vl_logic_vector(10 downto 0) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        IMG_VDISP       : vl_logic_vector(10 downto 0) := (Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        rst_n           : in     vl_logic;
        cmos_xclk       : in     vl_logic;
        cmos_pclk       : out    vl_logic;
        cmos_vsync      : out    vl_logic;
        cmos_href       : out    vl_logic;
        cmos_data       : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CMOS_VSYNC_VALID : constant is 1;
    attribute mti_svvh_generic_type of IMG_HDISP : constant is 2;
    attribute mti_svvh_generic_type of IMG_VDISP : constant is 2;
end Video_Image_Simulate_CMOS;
