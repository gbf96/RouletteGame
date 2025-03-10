transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/KeyScan.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/Register.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/Full_adder.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/FFD.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/AddSub.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/Adder.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/RouletteGame.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/KeyboardReader.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/MUX4.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/DEC4.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/Counter.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/KeyControl.vhd}
vcom -93 -work work {C:/Users/botel/Desktop/RouletteGame/RouletteGameVhdl/KeyDecode.vhd}

