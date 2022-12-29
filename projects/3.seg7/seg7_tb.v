`timescale 1s/1s
`include "projects/5.seg7/seg7.v"

module seg7_tb;

  // binary => bcd
  // 0-16 in binary are 4 bits
  reg [3:0] bcd;

  // 7segment => seg
  // 7 bits for 7 led
  wire [6:0] seg;

  // decimal presentation = i
  integer i;

  // Instantiate the Unit Under Test (UUT)
  seg7 uut (
         .bcd(bcd),
         .seg(seg)
       );

  initial
  begin

    $dumpfile("seg7_tb.vcd");
    $dumpvars(0,seg7_tb);

    for(i = 0;i < 16;i = i+1)
    begin
      bcd = i;
      #1; //wait for 1s
    end
  end

endmodule
