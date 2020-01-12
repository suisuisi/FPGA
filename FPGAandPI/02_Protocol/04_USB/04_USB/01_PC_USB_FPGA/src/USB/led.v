module  led(
        input                   CLCOK                     ,
        input                   rst_n                   ,
        //usb interface
        input      [3: 0]             cmd_led_data                  ,
        //receive cmd from pc
        output  [3:0]     led                 
);






reg[3:0]led_r;

always @(posedge CLCOK or negedge rst_n)begin
    if(!rst_n)begin
        led_r <= 0;
    end
    else 
		case ( cmd_led_data )
		
		0000://--led1
			led_r<=1110;
		0010://=>	--led2
			led_r<=1101;
		0011://=>	--led3
			led_r<=1011;
		0100://=>	--led4
			led_r<=0111;
		0101://=>	--led run
			led_r<=1111;
			//led_r(3 downto 1)<= led_r(2 downto 0);
			//led_r(0)<= led_r(3);
		//when "0110"=>	--led reset
			//led_r<="1111";
		//when others =>
		default:
			led_r<=0000;
	   endcase
     end
 //    end
assign led = cmd_led_data;	  
	  
endmodule