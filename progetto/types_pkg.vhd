library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package types_pkg is
    -- definizioni costanti
    
    -- formato dati: 12 bit totali, 8 bit frazionari
    constant WIDTH      : integer := 12;
    constant FRAC_BITS  : integer := 8; -- parte frazionaria
    constant VEC_SIZE   : integer := 2;

    -- tipo base dato: di 12 bit, di cui 8 frazionari - quindi sarà 11 downto 0
    subtype data_t is signed(WIDTH-1 downto 0);

    -- vettore a 2 elementi - cioè 0 to 1
    type vec2_t is array (0 to VEC_SIZE-1) of data_t;

    -- somma e prodotto
    constant SUM_WIDTH  : integer := WIDTH + 1;         -- per somma/differenza può servore un bit in più
    constant PROD_WIDTH : integer := SUM_WIDTH + WIDTH; -- per moltiplicazione
    subtype sum_t  is signed(SUM_WIDTH-1 downto 0);
    subtype prod_t is signed(PROD_WIDTH-1 downto 0);

    --had coeff
    
    -- partendo da 1/sqrt(2) e 256 (2^8), 8 indicano gli 8 bit, calcoliamo had coeff (sarà 181)
    -- coefficiente 1/sqrt(2) in formato Q4.8
    -- 1/sqrt(2) ≈ 0.707106...
    -- 0.707106 * 2^8 ≈ 181
    constant HAD_COEFF_INT : integer := 181;
    constant HAD_COEFF : data_t := to_signed(HAD_COEFF_INT, WIDTH);
    
end package types_pkg;
