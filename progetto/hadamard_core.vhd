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

signal sum_s   : sum_t;
signal diff_s  : sum_t;
signal prod0_s : prod_t;
signal prod1_s : prod_t;

begin

    sum_s  <= resize(x_in(0), SUM_WIDTH) + resize(x_in(1), SUM_WIDTH);
    diff_s <= resize(x_in(0), SUM_WIDTH) - resize(x_in(1), SUM_WIDTH);

    prod0_s <= sum_s  * HAD_COEFF;
    prod1_s <= diff_s * HAD_COEFF;

    y_out(0) <= resize(shift_right(prod0_s, FRAC_BITS), WIDTH);
    y_out(1) <= resize(shift_right(prod1_s, FRAC_BITS), WIDTH);

end Behavioral;
