library verilog;
use verilog.vl_types.all;
entity VIP_Matrix_Generate_3X3_8Bit is
    generic(
        IMG_HDISP       : vl_logic_vector(9 downto 0) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        IMG_VDISP       : vl_logic_vector(9 downto 0) := (Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        per_frame_vsync : in     vl_logic;
        per_frame_href  : in     vl_logic;
        per_img_Y       : in     vl_logic_vector(7 downto 0);
        matrix_frame_vsync: out    vl_logic;
        matrix_frame_href: out    vl_logic;
        matrix_p11      : out    vl_logic_vector(7 downto 0);
        matrix_p12      : out    vl_logic_vector(7 downto 0);
        matrix_p13      : out    vl_logic_vector(7 downto 0);
        matrix_p21      : out    vl_logic_vector(7 downto 0);
        matrix_p22      : out    vl_logic_vector(7 downto 0);
        matrix_p23      : out    vl_logic_vector(7 downto 0);
        matrix_p31      : out    vl_logic_vector(7 downto 0);
        matrix_p32      : out    vl_logic_vector(7 downto 0);
        matrix_p33      : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IMG_HDISP : constant is 2;
    attribute mti_svvh_generic_type of IMG_VDISP : constant is 2;
end VIP_Matrix_Generate_3X3_8Bit;
