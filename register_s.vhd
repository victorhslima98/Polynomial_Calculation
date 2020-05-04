LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register_s IS
	PORT (
	reset : IN STD_LOGIC;
	clk : IN STD_LOGIC;
	LS : IN STD_LOGIC;
	ula : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	regs : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END register_s;

ARCHITECTURE Behavioral OF register_s IS
BEGIN
	PROCESS (clk, reset)
	BEGIN
		IF reset = '1' THEN
			regs <= "0000000000000000";
		ELSIF (clk'EVENT AND clk = '1') THEN
			IF LS = '1' THEN
				regs <= ula;
			ELSE
				regs <= regs;
			END IF;
		END IF;
	END PROCESS;
END Behavioral;