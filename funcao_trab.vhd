LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE my_components IS
	COMPONENT register_x IS
		PORT (
			reset : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			LX : IN STD_LOGIC;
			x_16 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			regx : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT register_s IS
		PORT (
			reset : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			LS : IN STD_LOGIC;
			ula : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			regs : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT alu IS
		PORT (
			mux1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			mux2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			H : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			ula : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT mux_um IS
		PORT (
			regx : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			A_16 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			B_16 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			C_16 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			M1 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			mux1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT mux_dois IS
		PORT (
			regx : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			regs : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			M2 : IN STD_LOGIC;
			mux2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT state_machine IS
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
	END COMPONENT;

end my_components;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.my_components.all;

ENTITY funcao_trab IS
	PORT (
		reset : IN STD_LOGIC;
		start : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		X, A, B, C : IN STD_LOGIC_VECTOR (7 downto 0);
	    S : OUT STD_LOGIC_VECTOR (15 downto 0);
	    P : INOUT STD_LOGIC
	);
END funcao_trab;

ARCHITECTURE comportamento OF funcao_trab IS
	SIGNAL M1, H : STD_LOGIC_VECTOR (1 downto 0);
	SIGNAL LX, LS, M2: STD_LOGIC;
	SIGNAL X_16, A_16, B_16, C_16, regx, regs, ula, mux1, mux2 : STD_LOGIC_VECTOR (15 DOWNTO 0);
	
BEGIN
	A_16 <= "00000000" & A;
	B_16 <= "00000000" & B;
	C_16 <= "00000000" & C;
	X_16 <= "00000000" & X;
	
	stage_0: state_machine port map (reset, start, clk, LX, LS, M1, M2, P, H);
	stage_1: register_x port map (reset, clk, LX, X_16, regx);
	stage_2: mux_um port map (regx, A_16, B_16, C_16, M1, mux1);
	stage_3: mux_dois port map (regx, regs, M2, mux2);
	stage_4: alu port map (mux1, mux2, H, ula);
	stage_5: register_s port map (reset, clk, LS, ula, regs);
	
	
	PROCESS (P)
	BEGIN
		IF P = '0' THEN 
			S <= regs;
		END IF;
	END PROCESS;
END comportamento;