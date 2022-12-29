//? to real time khode sensor az 1 be 0 tabdil mishe ya bayad 0 esh konim
//? defien array in line
//? #QUEUE[4];

//* red = stop
//* yellow = pa
//* green = go

//* red => 10
//* yellow => 02
//* green => 10
//* yellow => 02

module traffic_light(
    //* outputs
    stop,
    pa,
    go,
    warn,

    //* inputs
    car_num,
    line_sen,
    counter
  );

  output stop,
         pa,
         go,
         warn;

  reg stop,
      pa,
      go,
      warn;

  input [31:0] car_num, counter;
  input line_sen;

  always @(*)
  begin
    if (line_sen)
    begin
      warn = 1;
    end
    else
    begin
      warn = 0;
    end

    if (counter % 4 == 0)
    begin
      warn = 0;

      stop = 1;
      pa = 0;
      go = 0;
    end

    if (counter % 4 == 1)
    begin
      stop = 0;
      pa = 1;
      go = 0;
    end

    if (counter % 4 == 2)
    begin
      warn = 0;

      stop = 0;
      pa = 0;
      go = 1;
    end

    if (counter % 4 == 3)
    begin
      stop = 0;
      pa = 1;
      go = 0;
    end



    // case (counter % 4)
    //   0:
    //     stop = 1;
    //   1:
    //     pa = 1;
    //   2:
    //     go = 1;
    //   3:
    //     pa = 1;
    // endcase

    // counter = 1;

  end



endmodule
