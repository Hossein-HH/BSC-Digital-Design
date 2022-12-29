`timescale 1ms/1ms
`include "projects/8.traffic_light/traffic_light.v"

module traffic_light_tb;
  integer i;

  parameter RED = 10;
  parameter GREEN = 10;
  parameter YELLOW = 2;

  // reg [4:0] QUEUE [0:4];
  //* 0 => RED
  //* 1 => YELLOW
  //* 2 => GREEN
  //* 3 => YELLOW

  //* outputs
  wire stop,
       pa,
       go,
       warn;

  //* inputs
  reg line_sen;
  reg [31:0] car_num, counter;
  reg [3:0] greenCounterFromLatestRed = 0;

  traffic_light uut(
                  //* outputs
                  .stop(stop),
                  .pa(pa),
                  .go(go),
                  .warn(warn),

                  //* inputs
                  .line_sen(line_sen),
                  .car_num(car_num),
                  .counter(counter)
                );

  initial
  begin
    // QUEUE[0] = RED;
    // QUEUE[1] = YELLOW;
    // QUEUE[2] = GREEN;
    // QUEUE[3] = YELLOW;

    $dumpfile("traffic_light_tb.vcd");
    $dumpvars(0,traffic_light_tb);

    for (i = 0; i < 20; ++i)
    begin
      car_num = {$random} % 32;

      if (((i-1) % 4 == 2))
      begin
        if (greenCounterFromLatestRed < 4 && car_num > 10)
        begin
          i--;
          greenCounterFromLatestRed++;
        end
        else
        begin
          greenCounterFromLatestRed = 0;
        end
      end

      counter = i;
      if ((i % 4) % 2)
      begin
        line_sen = {$random} % 2;
      end

      case (i % 4)
        0:
        begin
          #RED;
        end
        1:
          #YELLOW;
        2:
          #GREEN;
        3:
          #YELLOW;
      endcase

      line_sen = 0;
    end
  end
endmodule
