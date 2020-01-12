library verilog;
use verilog.vl_types.all;
entity VIP_YCbCr444_RGB888 is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        per_frame_vsync : in     vl_logic;
        per_frame_href  : in     vl_logic;
        per_frame_clken : in     vl_logic;
        per_img_Y       : in     vl_logic_vector(7 downto 0);
        per_img_Cb      : in     vl_logic_vector(7 downto 0);
        per_img_Cr      : in     vl_logic_vector(7 downto 0);
        post_frame_vsync: out    vl_logic;
        post_frame_href : out    vl_logic;
        post_frame_clken: out    vl_logic;
        post_img_red    : out    vl_logic_vector(7 downto 0);
        post_img_green  : out    vl_logic_vector(7 downto 0);
        post_img_blue   : out    vl_logic_vector(7 downto 0)
    );
end VIP_YCbCr444_RGB888;
