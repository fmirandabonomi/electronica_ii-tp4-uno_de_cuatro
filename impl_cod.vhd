library IEEE;
use IEEE.std_logic_1164.all;

entity cod_uno_de_cuatro_a_bin is
    port(
        uno_de_cuatro : IN  std_logic_vector (3 downto 0);
        codigo        : OUT std_logic_vector (1 downto 0); -- Posicion del bit en uno
        valido        : OUT std_logic); -- 1 si la entrada es valida
end cod_uno_de_cuatro_a_bin;

architecture arch of cod_uno_de_cuatro_a_bin is
    signal valido_y_codigo : std_logic_vector (2 downto 0);
begin -- Implementar codificador 1 de 4
    valido <= valido_y_codigo(2);
    codigo <= valido_y_codigo(1 downto 0);
    with uno_de_cuatro select valido_y_codigo <=
        "100" when "0001", -- Completar la tabla, 
        "101" when "0010", -- el bit izquierdo a la salida "valido"
        "110" when "0100",
        "111" when "1000",
        "000" when others;
end arch;