library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.types_pkg.ALL;

entity hadamard_core is
    Port (
        x_in  : in  vec2_t;
        y_out : out vec2_t
    );
end hadamard_core;

architecture Behavioral of hadamard_core is
begin

    had_prod: process(x_in)
        variable sum_v  : sum_t;
        variable diff_v : sum_t;
        variable prod0_v : prod_t;
        variable prod1_v : prod_t;
    begin
        -- somma e differenza degli ingressi
        sum_v  := resize(x_in(0), SUM_WIDTH) + resize(x_in(1), SUM_WIDTH);
        diff_v := resize(x_in(0), SUM_WIDTH) - resize(x_in(1), SUM_WIDTH);

        -- moltiplicazione per 1/sqrt(2) in formato fixed-point
        prod0_v := sum_v  * HAD_COEFF;
        prod1_v := diff_v * HAD_COEFF;

        -- riallineamento al formato Q4.8:
        -- dopo la moltiplicazione ci sono 16 bit frazionari,
        -- quindi facciamo shift right di 8 per tornare a 8 bit frazionari
        y_out(0) <= resize(shift_right(prod0_v, FRAC_BITS), WIDTH);
        y_out(1) <= resize(shift_right(prod1_v, FRAC_BITS), WIDTH);
    end process;

end Behavioral;
