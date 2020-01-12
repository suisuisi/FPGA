
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity sram_test is
	port(
		clk: in STD_LOGIC;		
		rst_n: in STD_LOGIC;		
		led: out STD_LOGIC;	
		sram_addr: buffer STD_LOGIC_VECTOR (14 downto 0);	
		sram_wr_n: out STD_LOGIC;	
		sram_data: inout STD_LOGIC_VECTOR (7 downto 0)
	);
end entity sram_test;

architecture sram_randw of sram_test is
	signal delay: STD_LOGIC_VECTOR (25 downto 0);	
	signal wr_data: STD_LOGIC_VECTOR (7 downto 0);
	signal rd_data: STD_LOGIC_VECTOR (7 downto 0);	
	signal sram_wr_req: STD_LOGIC;	
	signal sram_rd_req: STD_LOGIC;	
	signal cnt: STD_LOGIC_VECTOR (2 downto 0);	
	type state is (IDLE,WRT0,WRT1,REA0,REA1);
	signal cstate: state;
	signal nstate: state;
	signal sdlink: STD_LOGIC;	
begin
----------------------
	process(clk,rst_n)	
		begin
			if (rst_n = '0') then	
				delay <= "00" & x"000000";
			elsif (clk'event AND clk = '1') then	
				delay <= delay+1;	
			end if;
	end process;
	sram_wr_req <= '1' when (delay = 10#9999#) else 
				  '0';
	sram_rd_req <= '1' when (delay = 10#19999#) else
				  '0';
----------------------
	process(clk,rst_n)	
		begin
			if (rst_n = '0') then	
				wr_data <= x"00";
			elsif (clk'event AND clk = '1') then	
				if(delay = 10#29999#) then
					wr_data <= wr_data+'1';
				end if;
			end if;
	end process;
	
	process(clk,rst_n)	
		begin
			if (rst_n = '0') then	
				sram_addr <= "000" & x"000";
			elsif (clk'event AND clk = '1') then	
				if(delay = 10#29999#) then
					sram_addr <= sram_addr+'1';	
				end if;
			end if;
	end process;
	
	process(clk,rst_n)	
		begin
			if (rst_n = '0') then	
				led <= '0';
			elsif (clk'event AND clk = '1') then	
				if(delay = 10#20099#) then
					if(wr_data = rd_data) then
						led <= '1';	
					else
						led <= '0';							
					end if;
				end if;
			end if;
	end process;	
----------------------
	process(clk,rst_n)	
		begin
			if (rst_n = '0') then	
				cnt <= "000";
			elsif (clk'event AND clk = '1') then	
				if(cstate = IDLE) then
					cnt <= "000";	
				else 
					cnt <= cnt+'1';
				end if;
			end if;
	end process;
----------------------
	process(clk,rst_n)	
		begin
			if (rst_n = '0') then	
				cstate <= IDLE;
			elsif (clk'event AND clk = '1') then	
				cstate <= nstate;
			end if;
	end process;

	process(cstate,sram_wr_req,sram_rd_req,cnt)
		begin
			case cstate is
				when IDLE => 
					if (sram_wr_req = '1') then
						nstate <= WRT0;		
					elsif (sram_rd_req = '1') then 
						nstate <= REA0;	
					else 
						nstate <= IDLE;
					end if;
				when WRT0 =>
					if (cnt = "111") then 
						nstate <= WRT1;
					else
						nstate <= WRT0;			
					end if;
				when WRT1 =>
					nstate <= IDLE;		
				when REA0 =>
					if (cnt = "111") then 
						nstate <= REA1;
					else 
						nstate <= REA0;
					end if;
				when REA1 => 
					nstate <= IDLE;		
				when others => 
					nstate <= IDLE;
			end case;		
	end process;
----------------------
	process(clk,rst_n)	
		begin
			if (rst_n = '0') then	
				rd_data <= x"00";
			elsif (clk'event AND clk = '1') then
				if (cstate = REA1) then
					rd_data <= sram_data;
				end if;
			end if;
	end process;
	
	process(clk,rst_n)	
		begin
			if (rst_n = '0') then	
				sdlink <= '0';
			elsif (clk'event AND clk = '1') then	
				case cstate is
					when IDLE =>
						if (sram_wr_req = '1') then
							sdlink <= '1';
						elsif (sram_rd_req = '1') then
							sdlink <= '0';
						else 
							sdlink <= '0';
						end if;
					when WRT0 =>
						sdlink <= '1';
					when others =>
						sdlink <= '0';
				end case;
			end if;
	end process;	
	sram_data <= wr_data when (sdlink = '1') else
				"ZZZZZZZZ";			
	sram_wr_n <= NOT sdlink;	
end architecture sram_randw;








