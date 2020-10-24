# Textbook Examples
## *Free Range VHDL* by Bryan Mealy and Fabrizio Tappero
* Analyze the code and test-bench
    ```bash
    $ ghdl -a ex.vhdl
    $ ghdl -a ex_tb.vhdl
    ```
* Elaborate the test-bench
    ```bash
    $ ghdl -e ex_tb
    ```
* Run the test-bench and generate VCD file
    ```bash
    $ ghdl -r ex_tb --vcd=ex.vcd
    ```
* Test with GTKWave
    ```bash
    $ gtkwave ex.vcd
    ```