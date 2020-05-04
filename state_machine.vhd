LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY state_machine IS
	PORT (
		reset : IN STD_LOGIC;
		start : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		LX : OUT STD_LOGIC;
		LS : OUT STD_LOGIC;
		M1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		M2 : OUT STD_LOGIC;
		P : OUT STD_LOGIC;
		H : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END state_machine;

ARCHITECTURE Behavioral OF state_machine IS
	TYPE tstate IS (idle, S0, S1, S2, S3, S4, S5, S6);
	SIGNAL estado, prox_estado : tstate;
BEGIN
	PROCESS (reset, clk)
	BEGIN
		IF (reset = '1') THEN
			estado <= idle;
		ELSIF (clk'EVENT AND clk = '1') THEN
			estado <= prox_estado;
		END IF;
	END PROCESS;
	PROCESS (estado, start)
	BEGIN
		CASE estado IS
			WHEN idle => 
				IF start = '1' THEN
					prox_estado <= S0;
				ELSE
					prox_estado <= idle;
				END IF;
				LX <= 'X';
				M1 <= "XX";
				M2 <= 'X';
				H <= "XX";
				LS <= 'X';
				P <= '0';
			WHEN S0 => prox_estado <= S1;
			LX <= '1';
			M1 <= "XX";
			M2 <= 'X';
			H <= "XX";
			LS <= 'X';
			P <= '0';
			WHEN S1 => prox_estado <= S2;
			LX <= '0';
			M1 <= "01";
			M2 <= '0';
			H <= "01";
			LS <= '1';
			P <= '0';
			WHEN S2 => prox_estado <= S3;
			LX <= '0';
			M1 <= "00";
			M2 <= '1';
			H <= "01";
			LS <= '1';
			P <= '0';
			WHEN S3 => prox_estado <= S4;
			LX <= '0';
			M1 <= "10";
			M2 <= '1';
			H <= "00";
			LS <= '1';
			P <= '0';
			WHEN S4 => prox_estado <= S5;
			LX <= '0';
			M1 <= "XX";
			M2 <= '1';
			H <= "10";
			LS <= '1';
			P <= '0';
			WHEN S5 => prox_estado <= S6;
			LX <= '0';
			M1 <= "11";
			M2 <= '1';
			H <= "00";
			LS <= '1';
			P <= '0';
			WHEN S6 => prox_estado <= idle;
			LX <= '0';
			M1 <= "XX";
			M2 <= 'X';
			H <= "XX";
			LS <= '0';
			P <= '1';
			WHEN OTHERS => prox_estado <= idle;
			LX <= '0';
			M1 <= "XX";
			M2 <= 'X';
			H <= "XX";
			LS <= '0';
			P <= '0';
		END CASE;
	END PROCESS;
END Behavioral;