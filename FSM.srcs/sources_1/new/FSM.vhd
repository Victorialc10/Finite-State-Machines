library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_cerrojo is
    Port (
        clk       : in  STD_LOGIC;
        rst       : in  STD_LOGIC;
        button    : in  STD_LOGIC;
        eq        : in  STD_LOGIC; -- Resultado de la comparación
        attempts  : out STD_LOGIC_VECTOR (1 downto 0); -- Número de intentos restantes
        lock      : out STD_LOGIC; -- LED (lock) que indica si está bloqueado o no
        load: out std_logic
    );
end fsm_cerrojo;

architecture Behavioral of fsm_cerrojo is

    type state_type is (Initial, One, Two, Three, Final);
    signal current_state, next_state: state_type;
    signal count: STD_LOGIC_VECTOR (1 downto 0); -- Cuenta de intentos restantes

begin
--no puedo tener una misma 
    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= Initial;
            --count <= "11";  -- 3 intentos
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Lógica de transición de estados
    process(current_state, button, eq)
    begin
        next_state <= current_state;
    
    
        case current_state is
            when Initial =>
            count <= "11";
            load <='1';
                if button = '1' then
                    next_state <= Three;
                    
                else
                    next_state <= Initial;
                end if;

            when Three =>
                count <= "11";  
                  load <='0';    
                if button = '1' and eq = '1' then
                    next_state <= Initial;
                    --count <= "11";  -- Contraseña correcta, reset de intentos
                elsif button = '1' and eq = '0' then
                    next_state <= Two;
                    
                end if;

            when Two =>
            count <= "10";  -- Reducir intentos
             load <='0';
                if button = '1' and eq = '1' then
                    next_state <= Initial;
                elsif button = '1' and eq = '0' then
                    next_state <= One;
                    
                end if;

            when One =>
             count <= "01";
              load <='0';
                if button = '1' and eq = '1' then
                    next_state <= Initial;
                elsif button = '1' and eq = '0' then
                    next_state <= Final;  -- Sin intentos restantes, bloqueado
                    
                end if;

            when Final =>
                count <= "00";
                 load <='0';
                next_state <= Final;  -- Estado bloqueado indefinidamente
        end case;
    end process;

    -- Salidas
    attempts <= count;
    lock <= '1' when (current_state = Initial) else '0'; -- LED encendido si está bloqueado

end Behavioral;
