module hello (A,B);

  input A;
  output B;

  assign B = A;

endmodule

// module hello_tb;

//   reg A;
//   wire B;

//   hello uut(A,B);

//   initial
//   begin

//     $dumpfile("hello_tb.vcd");
//     $dumpvars(0,hello_tb);

//     A = 0;
//     #20

//      A = 1;
//     #20

//      A = 0;
//     #20

//      $display("Test complete");

//   end


// endmodule
