library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.types_pkg.ALL;

entity tb_hadamard_board_top is
end tb_hadamard_board_top;

architecture Behavioral of tb_hadamard_board_top is

    signal clk     : std_logic := '0';
    signal rst     : std_logic := '0';
    signal sw      : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal load_x0 : std_logic := '0';
    signal load_x1 : std_logic := '0';
    signal sel_out : std_logic := '0';
    signal led     : std_logic_vector(WIDTH-1 downto 0);

begin

    DUT : entity work.hadamard_board_top
        port map (
            clk     => clk,
            rst     => rst,
            sw      => sw,
            load_x0 => load_x0,
            load_x1 => load_x1,
            sel_out => sel_out,
            led     => led
        );

    clk_process : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    rst <= '1', '0' after 12 ns;

    -- Casi:
    -- 1) x0=1.0   x1=0.0
    -- 2) x0=1.0   x1=-1.0
    -- 3) x0=0.5   x1=1.0
    -- 4) x0=2.0   x1=0.5

    sw <= std_logic_vector(to_signed(16#100#, WIDTH)),
          std_logic_vector(to_signed(16#000#, WIDTH)) after 40 ns,
          std_logic_vector(to_signed(16#100#, WIDTH)) after 120 ns,
          std_logic_vector(to_signed(-256, WIDTH))    after 140 ns,
          std_logic_vector(to_signed(16#080#, WIDTH)) after 220 ns,
          std_logic_vector(to_signed(16#100#, WIDTH)) after 240 ns,
          std_logic_vector(to_signed(16#200#, WIDTH)) after 320 ns,
          std_logic_vector(to_signed(16#080#, WIDTH)) after 340 ns;

    load_x0 <= '0',
               '1' after 20 ns,  '0' after 30 ns,
               '1' after 120 ns, '0' after 130 ns,
               '1' after 220 ns, '0' after 230 ns,
               '1' after 320 ns, '0' after 330 ns;

    load_x1 <= '0',
               '1' after 40 ns,  '0' after 50 ns,
               '1' after 140 ns, '0' after 150 ns,
               '1' after 240 ns, '0' after 250 ns,
               '1' after 340 ns, '0' after 350 ns;

    -- mostro prima y0 e poi y1 per ciascun caso
    sel_out <= '0',
               '1' after 80 ns,   -- caso 1: y1
               '0' after 180 ns,  -- caso 2: y0
               '1' after 200 ns,  -- caso 2: y1
               '0' after 280 ns,  -- caso 3: y0
               '1' after 300 ns,  -- caso 3: y1
               '0' after 380 ns,  -- caso 4: y0
               '1' after 400 ns;  -- caso 4: y1

end Behavioral;