module seg7_0_99(
    seg,
    disp_channel,
    bcd
  );

  //? 1 => Right
  //? 2 => Left

  output [6:0] seg;
  reg [6:0] seg;

  input [1:0] disp_channel;
  input [3:0] bcd;

  // always block for converting bcd digit into 7 segment format
  always @(bcd)
  begin
    case (bcd)
      0 :
        seg = 7'b0000001;
      1 :
        seg = 7'b1001111;
      2 :
        seg = 7'b0010010;
      3 :
        seg = 7'b0000110;
      4 :
        seg = 7'b1001100;
      5 :
        seg = 7'b0100100;
      6 :
        seg = 7'b0100000;
      7 :
        seg = 7'b0001111;
      8 :
        seg = 7'b0000000;
      9 :
        seg = 7'b0000100;
      //switch off 7 segment character when the bcd digit is not a decimal number.
      default :
        seg = 7'b1111111;
    endcase
  end

endmodule
