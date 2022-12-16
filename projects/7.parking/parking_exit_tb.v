`timescale 1ms/1ms
`include "projects/7.parking/parking.v"

module parking_exit_tb;
  integer i;

  //* inputs
  reg entranceSen,
      exitSen,
      doorMaxOpen,
      doorMaxClose;
  reg [5:0] entrancePass;

  //* outputs
  wire doorOpen,
       doorClose,
       okPass,
       wrongPass,
       empty,
       full;
  wire [3:0] carNumber;

  parking uut (
            //* outputs
            .doorOpen(doorOpen),
            .doorClose(doorClose),
            .okPass(okPass),
            .wrongPass(wrongPass),
            .carNumber(carNumber),
            .empty(empty),
            .full(full),

            //* inputs
            .entranceSen(entranceSen),
            .entrancePass(entrancePass),
            .exitSen(exitSen),
            .doorMaxOpen(doorMaxOpen),
            .doorMaxClose(doorMaxClose)
          );

  initial
  begin
    $dumpfile("parking_exit_tb.vcd");
    $dumpvars(0,parking_exit_tb);

    for(i = 0;i < 10;i++)
    begin
      exitSen = {$random} % 2;
      #5;

      if (exitSen)
      begin

        if (doorOpen)
        begin
          doorMaxOpen = 0;
          #10;
          doorMaxOpen = 1;
          #10;
          doorMaxOpen = 0;
        end

        if (doorClose)
        begin
          doorMaxClose = 0;
          #10;
          doorMaxClose = 1;
          #10;
          doorMaxClose = 0;
        end

        exitSen = 0;

      end
    end
  end

endmodule
