library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.util.all;

entity one_hot_tb is
end one_hot_tb;

architecture tb of one_hot_tb is
    component decod_uno_de_cuatro is
        port(
            selector      : IN  std_logic_vector (1 downto 0);
            uno_de_cuatro : OUT std_logic_vector (3 downto 0));    
    end component;
    component cod_uno_de_cuatro_a_bin is
        port(
            uno_de_cuatro : IN  std_logic_vector (3 downto 0);
            codigo        : OUT std_logic_vector (1 downto 0);
            valido        : OUT std_logic);

    end component;
    signal sel_in       : std_logic_vector (1 downto 0);
    signal one_hot_out  : std_logic_vector (3 downto 0);
    signal one_hot_in   : std_logic_vector (3 downto 0);
    signal cod_out      : std_logic_vector (1 downto 0);
    signal valido_out   : std_logic;
    constant s_dec      : string := "Debe decodificar a uno de cuatro";
    constant s_cod      : string := "Debe codificar uno de cuatro en binario";
    constant s_pass     : string := " [PASS]";
    constant s_fail     : string := " [FAIL]";
begin
    dec : decod_uno_de_cuatro port map (
            selector      => sel_in,
            uno_de_cuatro => one_hot_out);
    cod : cod_uno_de_cuatro_a_bin port map (
            uno_de_cuatro => one_hot_in,
            codigo        => cod_out,
            valido        => valido_out);
    prueba_decodificador : process
        variable one_hot_esperado : std_logic_vector (3 downto 0);
        variable pass             : boolean;
        variable all_pass         : boolean := true;
    begin
        for i in 0 to 3 loop
            if not all_pass then
                exit;
            end if;
            one_hot_esperado := std_logic_vector(to_unsigned(2**i,4));
            sel_in <= std_logic_vector(to_unsigned(i,2));
            wait for 1 ns;
            pass     := one_hot_out = one_hot_esperado;
            all_pass := pass and all_pass;
            assert pass
                report "Decodificador falla para selector "&lvec_image(sel_in)&"."
                severity error;
        end loop;
        if all_pass then
            report s_dec & s_pass & "."
            severity note;
        else
            report s_dec & s_fail & "."
            severity error;
        end if;
        wait;
    end process; -- prueba_decodificador
    prueba_codificador : process
        variable cod_esperado : std_logic_vector (1 downto 0);
        variable pass         : boolean;
        variable all_pass     : boolean := true;
        constant falla_cod    : string := "Falla codificador para entrada ";
    begin
        for i in 0 to 3 loop
            if not all_pass then
                exit;
            end if;
            cod_esperado := std_logic_vector(to_unsigned(i,2));
            for j in 0 to 2 ** (3-i) - 1 loop
                if not all_pass then
                    exit;
                end if;
                one_hot_in <= std_logic_vector(to_unsigned(j,3-i))
                              & std_logic_vector(to_unsigned(2**i,i+1));
                wait for 1 ns;
                if j = 0 then
                    pass := (cod_out = cod_esperado) and (valido_out = '1');
                else
                    pass := valido_out = '0';
                end if;
                all_pass := pass and all_pass;
                assert pass
                    report falla_cod & lvec_image(one_hot_in) &"."
                    severity error;
            end loop;
        end loop;
        one_hot_in <= "0000";
        wait for 1 ns;
        pass     := valido_out = '0';
        all_pass := pass and all_pass;
        assert pass
            report falla_cod & lvec_image(one_hot_in) &"."
            severity error;
        if all_pass then
            report s_cod & s_pass & "."
            severity note;
        else
            report s_cod & s_fail & "."
            severity error;
        end if;
        wait;
    end process; -- prueba_codificador
end tb;