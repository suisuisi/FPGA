library verilog;
use verilog.vl_types.all;
entity Video_Image_Processor is
    generic(
        IMG_HDISP       : vl_logic_vector(9 downto 0) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        IMG_VDISP       : vl_logic_vector(9 downto 0) := (Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        per_frame_vsync : in     vl_logic;
        per_frame_href  : in     vl_logic;
        per_img_RAW     : in     vl_logic_vector(7 downto 0);
        post_frame_vsync: out    vl_logic;
        post_frame_href : out    vl_logic;
        post_img_red    : out    vl_logic_vector(7 downto 0);
        post_img_green  : out    vl_logic_vector(7 downto 0);
        post_img_blue   : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IMG_HDISP : constant is 2;
    attribute mti_svvh_generic_type of IMG_VDISP : constant is 2;
end Video_Image_Processor;
