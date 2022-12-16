module parking (
    //* outputs
    doorOpen,
    doorClose,
    okPass,
    wrongPass,
    carNumber,
    empty,
    full,

    //* inputs
    entranceSen,
    entrancePass,
    exitSen,
    doorMaxOpen,
    doorMaxClose,
  );

  //* define outputs
  output doorOpen,
         doorClose,
         okPass,
         wrongPass,
         empty,
         full;

  reg okPass,
      wrongPass;

  output [3:0] carNumber;
  reg [3:0] carNumber = 5;
  reg full = 0,
      empty = 1,
      doorOpen = 0,
      doorClose = 0;
  // maxCapacity = 10

  //* define inputs
  input entranceSen,
        exitSen,
        doorMaxOpen,
        doorMaxClose;

  input [5:0] entrancePass;

  //* variables for check password
  reg [5:0] PASSWORD [9:0];
  reg PASSCHECK = 0;
  integer i = 0;

  always @(*)
  begin
    PASSWORD[0] = 6'b000011; // 03
    PASSWORD[1] = 6'b000111; // 07
    PASSWORD[2] = 6'b100011; // 35
    PASSWORD[3] = 6'b100110; // 38
    PASSWORD[4] = 6'b100111; // 39
    PASSWORD[5] = 6'b101100; // 44
    PASSWORD[6] = 6'b101111; // 47
    PASSWORD[7] = 6'b110011; // 51
    PASSWORD[8] = 6'b110111; // 55
    PASSWORD[9] = 6'b111111; // 63

    //? in time of opening the door this condition always in check how to stop it ?
    if (entranceSen)
    begin
      i = 0;
      while (!PASSCHECK && i < 10)
      begin
        if (entrancePass == PASSWORD[i])
        begin
          PASSCHECK = 1;
        end
        i++;
      end

      if (PASSCHECK)
      begin
        okPass = 1;
        wrongPass = 0;

        if (!doorClose)
        begin
          doorOpen = 1;
        end

        PASSCHECK = 0;
      end
      else
      begin
        okPass = 0;
        wrongPass = 1;
      end
    end

    if (exitSen)
    begin
      if (!doorClose)
      begin
        doorOpen = 1;
      end
    end

    if (doorMaxOpen)
    begin
      doorOpen = 0;
      doorClose = 1;
    end

    if (doorMaxClose)
    begin
      doorClose = 0;

      if (entranceSen)
      begin
        carNumber++;
      end
      else if (exitSen)
      begin
        carNumber--;
      end

      if (carNumber == 0)
      begin
        full = 0;
        empty = 1;
      end
      else if(carNumber < 10)
      begin
        full = 0;
        empty = 0;
      end
      else
      begin
        full = 1;
        empty = 0;
      end

    end

  end
endmodule
