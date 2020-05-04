LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register_x IS
	PORT (
	reset : IN STD_LOGIC;
	clk : IN STD_LOGIC;
	LX : IN STD_LOGIC;
	x_16 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	regx : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END register_x;

ARCHITECTURE Behavioral OF register_x IS
BEGIN
	PROCESS (clk, reset)
	BEGIN
		IF reset = '1' THEN
			regx <= "0000000000000000";
		ELSIF (clk'EVENT AND clk = '1') THEN
			IF LX = '1' THEN
				regx <= x_16;
			ELSE
				regx <= regx;
			END IF;
		END IF;
	END PROCESS;
END Behavioral;