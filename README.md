# TarrahiDigital

Implementation ```Verilog``` codes for ```DigitalDesign``` with Dr.MosallaNezhad in Jahrom University

## Implemented projects

- DFF
- TFF
- Seven segment 00-09
- Seven segment 00-99
- Parking
- Traffic light
- Green House
- Shop with parking

## Get test bench output

#### On VS Code
Install this extention :
[Verilog Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=raits.verilog-extensions)

#### On Modelsim
Delete this lines in test bench file :

```verilog
`include "projects/module_name/module_name.v"
```
```verilog
$dumpfile("module_name_tb.vcd");
$dumpvars(0,module_name_tb);
```

## Badges
Jahrom University : [jahromu.ac.ir](https://jahromu.ac.ir/en)