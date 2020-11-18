# Lab 4: Hex Calculator
Programed the FPGA to function as a simple hexadecimal calculator capable of adding and subtracting four-digit hexadecimal numbers using a 16-button keypad.

![demo](hexcalc/demo/demo1.gif)

## Modifications:
* Reversed display digits.
    * Modified file located at (.\hexcalc\hexcalc.srcs\constrs_1\new\hexcalc.xdc)

    ```diff
    - set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[0]}]
    - set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[1]}]
    - set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[2]}]
    - set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[3]}]

    + set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[0]}]
    + set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[1]}]
    + set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[2]}]
    + set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {SEG7_anode[3]}]
    ```

* Suppressed leading zeros.
    * Modified file located at (.\hexcalc\hexcalc.srcs\sources_1\new\leddec16.vhd)

    ```diff
    - anode <= "1110" WHEN dig = "00" ELSE
	-          "1101" WHEN dig = "01" ELSE
	-          "1011" WHEN dig = "10" ELSE
	-          "0111" WHEN dig = "11" ELSE
	-          "1111";

    + anode <= "1110" WHEN dig = "00" AND conv_integer(data) >= 0 ELSE
	+          "1101" WHEN dig = "01" AND conv_integer(data) >= 16 ELSE
	+          "1011" WHEN dig = "10" AND conv_integer(data) >= 256 ELSE
	+          "0111" WHEN dig = "11" AND conv_integer(data) >= 4096 ELSE
	+          "1111";
    ```

* Added subtraction operation.
    * Modified file located at (.\hexcalc\hexcalc.srcs\constrs_1\new\hexcalc.xdc)
    ```diff
    + set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { bt_sub }];
    ```
    * Modified file located at (.\hexcalc\hexcalc.srcs\sources_1\new\hexcalc.vhd)
    ```diff
    + bt_sub : IN STD_LOGIC;

    + SIGNAL ps : STD_LOGIC; --plus or sub, '0' -> plus, '1' -> sub.

    - ELSIF bt_plus = '1' THEN
	-    nx_state <= START_OP;

    + ELSIF bt_plus = '1' THEN
	+    nx_state <= START_OP;
	+    ps <= '0';
	+ ELSIF bt_sub = '1' THEN
	+    nx_state <= START_OP;
	+    ps <= '1';

    - IF bt_eq = '1' THEN
	-    nx_acc <= acc + operand;
	-    nx_state <= SHOW_RESULT;

    + IF bt_eq = '1' AND ps = '0' THEN
	+    nx_acc <= acc + operand;
	+    nx_state <= SHOW_RESULT;
	+ ELSIF bt_eq = '1' AND ps = '1' THEN
	+    nx_acc <= acc - operand;
	+    nx_state <= SHOW_RESULT;
    ```

![demo](hexcalc/demo/demo2.gif)