module oled_control_module(
  input CLOCK,
  input RST_n,
  input init_done_sig,
  input write_done_sig,
  output init_start_sig,
  output write_start_sig
);

reg [3:0] i;
reg isinit;
reg iswrite;
always @(posedge CLOCK or negedge RST_n)
begin
  if(!RST_n)
    begin
      i <= 4'd0;
      isinit <= 1'b0;
      iswrite <= 1'b0;
    end
  else
  begin
    case(i)
      4'd0:
        if(init_done_sig)
        begin
          isinit<=1'b0;
          i<=i+1'b1;
        end
        else
          isinit <= 1'b1;
      4'd1:
		//iswrite<=1'b1;
	  
        if(write_done_sig)
        begin
          iswrite<=1'b0;
          i<=i+1'b1;
        end
        else
          iswrite<=1'b1;
      4'd2:
        i <= 4'd2;
		//iswrite<=1'b1;
	
      endcase
   end
end
assign init_start_sig=isinit;
assign write_start_sig=iswrite;
endmodule

