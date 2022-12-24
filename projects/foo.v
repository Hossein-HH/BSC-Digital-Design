module test(
    //* outputs
    //* inputs
  );

  output a;

  reg a;

  input b;

  always @(*)
  begin
    if (b)
    begin
      a = 1;
    end
  end
endmodule

////////////////////////////////

`timescale 1ms/1ms
//`include "projects/"

module test_tb;
  integer i;

  //* outputs
  wire a;

  //* inputs
  reg b;

  test uut(
         //* outputs
         .a(a),
         //* inputs
         .b(b)
       );

  initial
  begin

    $dumpfile("test_tb.vcd");
    $dumpvars(0,test_tb);

    for (i = 0; i < 20; ++i)
    begin
      // rand = {$random} % 32;

      // reset rand = 0;
    end
  end
endmodule
