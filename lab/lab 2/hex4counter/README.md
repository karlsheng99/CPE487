# Lab 2: Four-Digit Hex Counter
Built a four-digit (16-bit) counter to display its value on 7-segment displays.

![demo](demo/demo1.gif)

## Update:
* Reversed the counter by modifying the constraint file. (./hex4counter.srcs/constrs_1/new/hexcount.xdc)
    
    ```diff
    - set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {anode[0]}]
    - set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {anode[1]}]
    - set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {anode[2]}]
    - set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {anode[3]}]

    + set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {anode[0]}]
    + set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {anode[1]}]
    + set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {anode[2]}]
    + set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {anode[3]}]
    ```
    Now the counter starts from the least significant digit (right to left).

    ![demo](demo/demo2.gif)