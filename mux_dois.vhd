LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_dois IS
	PORT (
	regx : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	regs : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	M2 : IN STD_LOGIC;
	mux2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END mux_dois;

ARCHITECTURE Behavioral OF mux_dois IS
BEGIN
	PROCESS (regx, regs, M2)
	BEGIN
		IF M2 = '1' THEN
			mux2 <= regs;
		ELSE
			mux2 <= regx;
		END IF;
	END PROCESS;
END Behavioral;