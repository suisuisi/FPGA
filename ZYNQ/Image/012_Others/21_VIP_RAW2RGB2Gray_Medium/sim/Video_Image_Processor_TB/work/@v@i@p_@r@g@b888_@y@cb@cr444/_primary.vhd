library verilog;
use verilog.vl_types.all;
entity VIP_RGB888_YCbCr444 is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        per_frame_vsync : in     vl_logic;
        per_frame_href  : in     vl_logic;
        per_frame_clken : in     vl_logic;
        per_img_red     : in     vl_logic_vector(7 downto 0);
        per_img_green   : in     vl_logic_vector(7 downto 0);
        per_img_blue    : in     vl_logic_vector(7 downto 0);
        post_frame_vsync: out    vl_logic;
        post_frame_href : out    vl_logic;
        post_frame_clken: out    vl_logic;
        post_img_Y      : out    vl_logic_vector(7 downto 0);
        post_img_Cb     : out    vl_logic_vector(7 downto 0);
        post_img_Cr     : out    vl_logic_vector(7 downto 0)
    );
end VIP_RGB888_YCbCr444;
