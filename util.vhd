library IEEE;
use IEEE.std_logic_1164.all;

package util is
    function lvec_image(xs: std_logic_vector) return string;
end package;

package body util is
    function lvec_image(xs: std_logic_vector) return string is
        variable cs : string(xs'range);
    begin
        for i in xs'range loop
            cs(i) := std_logic'image(xs(i))(2);
        end loop;
        return """" & cs & """";
    end;
end package body;