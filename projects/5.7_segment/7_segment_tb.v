`timescale 1s/1s
`include "projects/5.7_segment/7_segment.v"

module segment7_tb;

  // binary => bcd
  // 0-16 in binary are 4 bits
  reg [3:0] bcd;

  // 7segment => seg
  // 7 bits for 7 led
  wire [6:0] seg;

  // decimal presentation = i   
  integer i;

  // Instantiate the Unit Under Test (UUT)
  segment7 uut (
             .bcd(bcd),
             .seg(seg)
           );

  initial
  begin

    $dumpfile("segment7_tb.vcd");
    $dumpvars(0,segment7_tb);

    for(i = 0;i < 16;i = i+1)
    begin
      bcd = i;
      #1; //wait for 1s
    end
  end

endmodule
