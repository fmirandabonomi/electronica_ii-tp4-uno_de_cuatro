library IEEE;
use IEEE.std_logic_1164.all;

entity decod_uno_de_cuatro is
    port(
        selector      : IN  std_logic_vector (1 downto 0);
        uno_de_cuatro : OUT std_logic_vector (3 downto 0));
end decod_uno_de_cuatro;

architecture arch of decod_uno_de_cuatro is
begin -- Implementar decodificador 1 de 4
    with selector select uno_de_cuatro <=
        "0000" when "00", -- Completar la tabla
        "0000" when "01",
        "0000" when "10",
        "0000" when others;
end arch;