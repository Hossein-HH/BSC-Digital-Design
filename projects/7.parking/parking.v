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
    doorMax
  );

  //* define outputs
  output doorOpen,
         doorClose,
         okPass,
         wrongPass,
         empty,
         full;

  reg doorOpen,
      doorClose,
      okPass,
      wrongPass,
      empty,
      full;

  output [3:0] carNumber;
  reg [3:0] carNumber = 0;
  // maxCapacity = 10

  //* define inputs
  input entranceSen,
        exitSen,
        doorMax;

  input [19:0] entrancePass;
  // 6 decimal digits need to 20 bits to get 2^20 ~ 999,999

  //* constant parameters
  parameter PASSWORD = 123456;

  always @(*)
  begin
    //? in time of opening the door this condition always in check how to stop it ?
    if (entranceSen)
    begin
      // TODO: use from array
      if (entrancePass == PASSWORD)
      begin
        okPass = 1;
        wrongPass = 0;

        doorOpen = 1;
      end
      else
      begin
        okPass = 0;
        wrongPass = 1;
      end
    end

    if (exitSen)
    begin
      doorOpen = 1;
    end

    if (doorMax)
    begin
      doorOpen = 0;
      doorClose = 1;

      if (entranceSen)
      begin
        carNumber++;
      end
      else if (exitSen)
      begin
        carNumber--;
      end

      if (carNumber < 10)
      begin
        full = 0;
        empty = 1;
      end
      else
      begin
        full = 1;
        empty = 0;
      end
    end
  end
endmodule