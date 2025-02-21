----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2024 11:10:34
-- Design Name: 
-- Module Name: registro - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
--cuando load
entity registro is
Port ( clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       load : in STD_LOGIC;
       entrada : in STD_LOGIC_VECTOR (7 downto 0);
       salida : out STD_LOGIC_VECTOR (7 downto 0));
       

end registro;

architecture Behavioral of registro is
signal reg: std_logic_vector(7 downto 0);
begin
p_1: process(clk,rst)
begin
if (rst = '1') then
    reg <= (others =>'0');
elsif rising_edge(clk) then
    if(load = '1') then 
        reg <= entrada;
    end if;
end if;
end process p_1;

salida <= reg;

end Behavioral;
