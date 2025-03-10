-- Copyright (C) 2019  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition"

-- DATE "03/10/2025 16:44:16"

-- 
-- Device: Altera 10M50DAF484C6GES Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_TMS~	=>  Location: PIN_H2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TCK~	=>  Location: PIN_G2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDI~	=>  Location: PIN_L4,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDO~	=>  Location: PIN_M5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_CONFIG_SEL~	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCONFIG~	=>  Location: PIN_H9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_nSTATUS~	=>  Location: PIN_G9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_CONF_DONE~	=>  Location: PIN_F8,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_TMS~~padout\ : std_logic;
SIGNAL \~ALTERA_TCK~~padout\ : std_logic;
SIGNAL \~ALTERA_TDI~~padout\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~padout\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~padout\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~padout\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~padout\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	RouletteGame IS
    PORT (
	LIN : IN std_logic_vector(3 DOWNTO 0);
	COL : BUFFER std_logic_vector(3 DOWNTO 0);
	CLK : IN std_logic;
	ACK : IN std_logic;
	RESET : IN std_logic;
	Q : BUFFER std_logic_vector(3 DOWNTO 0);
	Dval : BUFFER std_logic
	);
END RouletteGame;

-- Design Ports Information
-- COL[0]	=>  Location: PIN_AA1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COL[1]	=>  Location: PIN_Y2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COL[2]	=>  Location: PIN_U7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COL[3]	=>  Location: PIN_U6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[0]	=>  Location: PIN_C10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[1]	=>  Location: PIN_R22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[2]	=>  Location: PIN_L19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[3]	=>  Location: PIN_V7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Dval	=>  Location: PIN_AA2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LIN[1]	=>  Location: PIN_Y1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LIN[2]	=>  Location: PIN_W3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LIN[0]	=>  Location: PIN_Y5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LIN[3]	=>  Location: PIN_W4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLK	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RESET	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ACK	=>  Location: PIN_W6,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF RouletteGame IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_LIN : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_COL : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_CLK : std_logic;
SIGNAL ww_ACK : std_logic;
SIGNAL ww_RESET : std_logic;
SIGNAL ww_Q : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_Dval : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \RESET~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \CLK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \COL[0]~output_o\ : std_logic;
SIGNAL \COL[1]~output_o\ : std_logic;
SIGNAL \COL[2]~output_o\ : std_logic;
SIGNAL \COL[3]~output_o\ : std_logic;
SIGNAL \Q[0]~output_o\ : std_logic;
SIGNAL \Q[1]~output_o\ : std_logic;
SIGNAL \Q[2]~output_o\ : std_logic;
SIGNAL \Q[3]~output_o\ : std_logic;
SIGNAL \Dval~output_o\ : std_logic;
SIGNAL \CLK~input_o\ : std_logic;
SIGNAL \CLK~inputclkctrl_outclk\ : std_logic;
SIGNAL \ACK~input_o\ : std_logic;
SIGNAL \LIN[3]~input_o\ : std_logic;
SIGNAL \LIN[1]~input_o\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~0_combout\ : std_logic;
SIGNAL \RESET~input_o\ : std_logic;
SIGNAL \RESET~inputclkctrl_outclk\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\ : std_logic;
SIGNAL \LIN[2]~input_o\ : std_logic;
SIGNAL \LIN[0]~input_o\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~0_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|NextState.STATE_PROCESS~0_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_PROCESS~q\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|Selector1~0_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_WAIT~q\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|Selector0~0_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~0_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~0_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~1_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|AddSub1|Adder1|FA1|Cout~0_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~0_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~0_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~1_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~2_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~3_combout\ : std_logic;
SIGNAL \ALT_INV_RESET~inputclkctrl_outclk\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|ALT_INV_Y~3_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|ALT_INV_Y~2_combout\ : std_logic;
SIGNAL \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|ALT_INV_Y~1_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_LIN <= LIN;
COL <= ww_COL;
ww_CLK <= CLK;
ww_ACK <= ACK;
ww_RESET <= RESET;
Q <= ww_Q;
Dval <= ww_Dval;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\RESET~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \RESET~input_o\);

\CLK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLK~input_o\);
\ALT_INV_RESET~inputclkctrl_outclk\ <= NOT \RESET~inputclkctrl_outclk\;
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|ALT_INV_Y~3_combout\ <= NOT \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~3_combout\;
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|ALT_INV_Y~2_combout\ <= NOT \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~2_combout\;
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|ALT_INV_Y~1_combout\ <= NOT \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~1_combout\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y41_N16
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X18_Y0_N30
\COL[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~0_combout\,
	devoe => ww_devoe,
	o => \COL[0]~output_o\);

-- Location: IOOBUF_X16_Y0_N16
\COL[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|ALT_INV_Y~1_combout\,
	devoe => ww_devoe,
	o => \COL[1]~output_o\);

-- Location: IOOBUF_X16_Y0_N2
\COL[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|ALT_INV_Y~2_combout\,
	devoe => ww_devoe,
	o => \COL[2]~output_o\);

-- Location: IOOBUF_X16_Y0_N9
\COL[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|ALT_INV_Y~3_combout\,
	devoe => ww_devoe,
	o => \COL[3]~output_o\);

-- Location: IOOBUF_X51_Y54_N30
\Q[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Q[0]~output_o\);

-- Location: IOOBUF_X78_Y21_N9
\Q[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Q[1]~output_o\);

-- Location: IOOBUF_X78_Y37_N9
\Q[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Q[2]~output_o\);

-- Location: IOOBUF_X20_Y0_N23
\Q[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Q[3]~output_o\);

-- Location: IOOBUF_X18_Y0_N23
\Dval~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_PROCESS~q\,
	devoe => ww_devoe,
	o => \Dval~output_o\);

-- Location: IOIBUF_X0_Y18_N15
\CLK~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLK,
	o => \CLK~input_o\);

-- Location: CLKCTRL_G3
\CLK~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLK~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLK~inputclkctrl_outclk\);

-- Location: IOIBUF_X16_Y0_N29
\ACK~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ACK,
	o => \ACK~input_o\);

-- Location: IOIBUF_X18_Y0_N15
\LIN[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_LIN(3),
	o => \LIN[3]~input_o\);

-- Location: IOIBUF_X16_Y0_N22
\LIN[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_LIN(1),
	o => \LIN[1]~input_o\);

-- Location: LCCOMB_X17_Y1_N22
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~0_combout\ = \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\ $ 
-- (((!\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\ & !\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\,
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~0_combout\);

-- Location: IOIBUF_X0_Y18_N22
\RESET~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RESET,
	o => \RESET~input_o\);

-- Location: CLKCTRL_G4
\RESET~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \RESET~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \RESET~inputclkctrl_outclk\);

-- Location: FF_X17_Y1_N23
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~0_combout\,
	clrn => \ALT_INV_RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\);

-- Location: IOIBUF_X18_Y0_N8
\LIN[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_LIN(2),
	o => \LIN[2]~input_o\);

-- Location: IOIBUF_X18_Y0_N1
\LIN[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_LIN(0),
	o => \LIN[0]~input_o\);

-- Location: LCCOMB_X17_Y1_N10
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~0_combout\ = (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\ & (((\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\)))) # 
-- (!\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\ & ((\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\ & (!\LIN[2]~input_o\)) # 
-- (!\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\ & ((!\LIN[0]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LIN[2]~input_o\,
	datab => \LIN[0]~input_o\,
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~0_combout\);

-- Location: LCCOMB_X17_Y1_N24
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\ = (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\ & ((\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~0_combout\ & (!\LIN[3]~input_o\)) 
-- # (!\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~0_combout\ & ((!\LIN[1]~input_o\))))) # (!\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\ & 
-- (((\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LIN[3]~input_o\,
	datab => \LIN[1]~input_o\,
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~0_combout\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\);

-- Location: LCCOMB_X17_Y1_N4
\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|NextState.STATE_PROCESS~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|NextState.STATE_PROCESS~0_combout\ = (\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_PROCESS~q\ & (!\ACK~input_o\)) # 
-- (!\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_PROCESS~q\ & ((\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ACK~input_o\,
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_PROCESS~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|NextState.STATE_PROCESS~0_combout\);

-- Location: FF_X17_Y1_N5
\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_PROCESS\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|NextState.STATE_PROCESS~0_combout\,
	clrn => \ALT_INV_RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_PROCESS~q\);

-- Location: LCCOMB_X17_Y1_N16
\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|Selector1~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|Selector1~0_combout\ = (\ACK~input_o\ & ((\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_PROCESS~q\) # 
-- ((\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_WAIT~q\ & !\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ACK~input_o\,
	datab => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_PROCESS~q\,
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_WAIT~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|Selector1~0_combout\);

-- Location: FF_X17_Y1_N17
\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_WAIT\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|Selector1~0_combout\,
	clrn => \ALT_INV_RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_WAIT~q\);

-- Location: LCCOMB_X17_Y1_N18
\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|Selector0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|Selector0~0_combout\ = (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\) # ((\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\ & ((\ACK~input_o\) # 
-- (!\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_WAIT~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ACK~input_o\,
	datab => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_WAIT~q\,
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|Selector0~0_combout\);

-- Location: FF_X17_Y1_N19
\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|Selector0~0_combout\,
	clrn => \ALT_INV_RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\);

-- Location: LCCOMB_X17_Y1_N12
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~0_combout\ = \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\ $ 
-- (((!\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\ & (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\ & !\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\,
	datab => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\,
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~0_combout\);

-- Location: FF_X17_Y1_N13
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~0_combout\,
	clrn => \ALT_INV_RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\);

-- Location: LCCOMB_X17_Y1_N28
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~0_combout\ = (\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\) # 
-- (!\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~0_combout\);

-- Location: LCCOMB_X17_Y1_N0
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~1_combout\ = \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\ $ 
-- (((!\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~0_combout\ & (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\ & !\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~0_combout\,
	datab => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\,
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~1_combout\);

-- Location: FF_X17_Y1_N1
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~1_combout\,
	clrn => \ALT_INV_RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\);

-- Location: LCCOMB_X17_Y1_N2
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|AddSub1|Adder1|FA1|Cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|AddSub1|Adder1|FA1|Cout~0_combout\ = (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\ & 
-- (!\KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\ & (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\ & !\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD1|Q~q\,
	datab => \KeyboardReader_inst|KeyDecode_inst|KeyControl_inst|CurrentState.STATE_SCAN~q\,
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD0|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|MUX4_inst|Y~1_combout\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|AddSub1|Adder1|FA1|Cout~0_combout\);

-- Location: LCCOMB_X17_Y1_N6
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~0_combout\ = \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\ $ 
-- (((\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\ & \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|AddSub1|Adder1|FA1|Cout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\,
	datac => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|AddSub1|Adder1|FA1|Cout~0_combout\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~0_combout\);

-- Location: FF_X17_Y1_N7
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~0_combout\,
	clrn => \ALT_INV_RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\);

-- Location: LCCOMB_X17_Y1_N8
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~0_combout\ = (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\) # (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~0_combout\);

-- Location: LCCOMB_X17_Y1_N30
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~1_combout\ = (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\ & !\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~1_combout\);

-- Location: LCCOMB_X17_Y1_N20
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~2_combout\ = (!\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\ & \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~2_combout\);

-- Location: LCCOMB_X17_Y1_N26
\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~3_combout\ = (\KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\ & \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD2|Q~q\,
	datad => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|Counter_inst|Registo1|FFD3|Q~q\,
	combout => \KeyboardReader_inst|KeyDecode_inst|KeyScan_inst|DEC4_inst|Y~3_combout\);

-- Location: UNVM_X0_Y40_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_end_addr => -1,
	addr_range2_offset => -1,
	addr_range3_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X43_Y52_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

-- Location: ADCBLOCK_X43_Y51_N0
\~QUARTUS_CREATED_ADC2~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 2,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC2~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC2~~eoc\);

ww_COL(0) <= \COL[0]~output_o\;

ww_COL(1) <= \COL[1]~output_o\;

ww_COL(2) <= \COL[2]~output_o\;

ww_COL(3) <= \COL[3]~output_o\;

ww_Q(0) <= \Q[0]~output_o\;

ww_Q(1) <= \Q[1]~output_o\;

ww_Q(2) <= \Q[2]~output_o\;

ww_Q(3) <= \Q[3]~output_o\;

ww_Dval <= \Dval~output_o\;
END structure;


