library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TopCerrojo is
    Port (
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        button   : in  STD_LOGIC;
        switches : in  STD_LOGIC_VECTOR (7 downto 0); -- Entrada de la contraseña
        display  : out STD_LOGIC_VECTOR (6 downto 0); -- Salida para el display de 7 segmentos
        led      : out STD_LOGIC;                    -- LED para indicar si está bloqueado
        anodes   : out STD_LOGIC_VECTOR (3 downto 0) -- Anodos de los displays
    );
end TopCerrojo;

architecture Behavioral of TopCerrojo is

    signal passwd_reg : STD_LOGIC_VECTOR (7 downto 0);
    signal eq         : STD_LOGIC;
    signal load       : STD_LOGIC;
    signal attempts   : STD_LOGIC_VECTOR (1 downto 0);
    signal debounced_button, rising_edge_button : STD_LOGIC;
    signal auxAttempt : std_logic_vector(3 downto 0);
    
    signal one: std_logic:='1';
begin

    -- Instancia del Debouncer
    debouncer_inst : entity work.debouncer
        port map (
            rst             => one,
            clk             => clk,
            x               => button,
            xDeb            => debounced_button,
            xDebRisingEdge  => rising_edge_button,
            xDebFallingEdge => open
        );

    -- Instancia del Registro
    reg_inst : entity work.registro
        port map (
            clk   => clk,
            rst   => rst,
            load  => load,
            entrada     => switches,
            salida     => passwd_reg
        );

    -- Instancia del Comparador
    comp_inst : entity work.comparador
        port map (
            entrada_usuario      => switches,
            clave_almacenada     => passwd_reg,
            --enable => '1', -- Siempre habilitado para comparación
            eq => eq
        );

    -- Instancia de la FSM
    fsm_inst : entity work.fsm_cerrojo
        port map (
            clk      => clk,
            rst      => rst,
            button   => rising_edge_button,
            eq       => eq,
            attempts => attempts,
            lock     => led,
            load => load
        );

    -- Instancia del Convertidor a 7 segmentos
    auxAttempt<="00" & attempts; --concatenacion 00atempt1 atempt2
    conv_inst : entity work.conv_7seg
        port map (
            x       => auxAttempt, -- Muestra los intentos restantes
            display => display
        );

    -- Anodos fijos
    anodes <= "1110"; -- Encender solo un display


end Behavioral;
