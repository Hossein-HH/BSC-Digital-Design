`timescale 1ns/1ns
`include "projects/6.seg7_0_99/seg7_0_99.v"

module seg7_0_99_tb;

  // binary => bcd
  // 0-16 in binary are 4 bits
  reg [3:0] bcd;

  // 7segment => seg
  // 7 bits for 7 led

  wire [6:0] seg;
  reg [1:0] disp_channel;

  // decimal presentation = i
  integer i;

  // Instantiate the Unit Under Test (UUT)
  seg7_0_99 uut (
              .bcd(bcd),
              .seg(seg),
              .disp_channel(disp_channel)
            );

  initial
  begin

    $dumpfile("seg7_0_99_tb.vcd");
    $dumpvars(0,seg7_0_99_tb);

    for(i = 0;i < 100;i = i+1)
    begin
      disp_channel = 2;
      bcd = i / 10;
      #50; //wait for 50ns

      disp_channel = 1;
      bcd = i % 10;
      #50;
    end
  end

endmodule
