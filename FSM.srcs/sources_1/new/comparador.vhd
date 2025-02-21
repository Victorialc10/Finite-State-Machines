----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2024 11:10:18
-- Design Name: 
-- Module Name: comparador - Behavioral
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

entity comparador is
Port ( entrada_usuario : in STD_LOGIC_VECTOR (7 downto 0);
       clave_almacenada : in STD_LOGIC_VECTOR (7 downto 0);
       --enable : in std_logic; -- necesito esto por si queda bloqueado por agotar los 3 intentos
       eq : out STD_LOGIC);
end comparador;

architecture Behavioral of comparador is

begin
p1 : process(entrada_usuario,clave_almacenada)
begin
    --if(enable = '1') then --si aun no he agotado intentos
        if (entrada_usuario = clave_almacenada)then -- miro si ambas entradas son iguales
          eq <= '1';
        else
            eq <= '0';
        end if;
    --else
        --salida <='0';
   -- end if;
end process p1;

end Behavioral;
