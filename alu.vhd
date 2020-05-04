LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu IS
	PORT (
	mux1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	mux2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	H : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	ula : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END alu;

ARCHITECTURE Behavioral OF alu IS
BEGIN
	PROCESS (mux1, mux2, H)
	BEGIN
		CASE H IS
			WHEN "00" => ula <= std_logic_vector(unsigned(mux1) + unsigned(mux2));
			WHEN "01" => ula <= std_logic_vector(RESIZE(unsigned(mux1) * unsigned(mux2), 16));
			WHEN "10" => ula <= std_logic_vector(shift_right(unsigned(mux2), 2));
			WHEN OTHERS => ula <= std_logic_vector(shift_right(unsigned(mux2), 2));
		END CASE;
	END PROCESS;
END Behavioral;