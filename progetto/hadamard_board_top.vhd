library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.types_pkg.ALL;

entity hadamard_board_top is
    Port (
        clk, rst                    : in  STD_LOGIC;
        sw                          : in  std_logic_vector(WIDTH-1 downto 0);
        load_x0, load_x1, sel_out   : in  STD_LOGIC;
        led                         : out std_logic_vector(WIDTH-1 downto 0)
    );
end hadamard_board_top;

architecture Structural of hadamard_board_top is

    component hadamard_core is
        Port (
            x_in  : in  vec2_t;
            y_out : out vec2_t
        );
    end component;

    signal x_reg   : vec2_t := (others => (others => '0'));
    signal y_comb  : vec2_t;
    signal y_reg   : vec2_t := (others => (others => '0'));
    signal led_reg : std_logic_vector(WIDTH-1 downto 0) := (others => '0');

begin

    had_inst : hadamard_core
        port map (
            x_in  => x_reg,
            y_out => y_comb
        );

    reg_proc : process(clk, rst)
    begin
        if rst = '1' then
            x_reg   <= (others => (others => '0'));
            y_reg   <= (others => (others => '0'));
            led_reg <= (others => '0');

        elsif rising_edge(clk) then

            -- caricamento dei due ingressi dai 12 switch
            -- se premi load_x0, carichiamo il primo valore

            if load_x0 = '1' then
                x_reg(0) <= signed(sw);
            elsif load_x1 = '1' then
                x_reg(1) <= signed(sw);
            end if;

            -- registrazione delle uscite del core
            y_reg <= y_comb;

            -- visualizzazione registrata di una sola uscita alla volta
            if sel_out = '0' then
                led_reg <= std_logic_vector(y_reg(0));
            else
                led_reg <= std_logic_vector(y_reg(1));
            end if;

        end if;
    end process;

    led <= led_reg;

end Structural;