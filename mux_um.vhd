LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_um IS
	PORT (
	regx : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	A_16 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	B_16 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	C_16 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	M1 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	mux1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END mux_um;

ARCHITECTURE Behavioral OF mux_um IS
BEGIN
	PROCESS (A_16, B_16, C_16, regx, M1)
	BEGIN
		CASE M1 IS
			WHEN "00" => mux1 <= regx;
			WHEN "01" => mux1 <= A_16;
			WHEN "10" => mux1 <= B_16;
			WHEN OTHERS => mux1 <= C_16;
		END CASE;
	END PROCESS;
END Behavioral;