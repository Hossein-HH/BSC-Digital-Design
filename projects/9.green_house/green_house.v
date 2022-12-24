module green_house(
    temp,
    heater,
    light,
    humidityGenerator,
    ventilator,
    addAlkali,
    addAcidic,
    doorOpen,
    doorClose,
    phSen,
    tempSen1,
    tempSen2,
    tempSen3,
    tempSen4,
    lightSen,
    humiditySen,
    doorPIRIn ,
    doorPIROut,
    doorOpenMax ,
    doorCloseMax
  );

  output temp,
         heater,
         light,
         humidityGenerator,
         ventilator,
         addAlkali,
         addAcidic,
         doorOpen,
         doorClose;

  reg heater,
      light,
      ventilator,
      addAlkali,
      addAcidic,
      humidityGenerator,
      doorOpen = 0,
      doorClose = 0;

  integer temp;

  input [31:0] tempSen1,
        tempSen2,
        tempSen3,
        tempSen4,
        phSen,
        lightSen,
        humiditySen;

  input doorPIRIn,
        doorPIROut,
        doorOpenMax,
        doorCloseMax;

  always @(*)
  begin

    //**************************
    temp = (tempSen1 + tempSen2 + tempSen3 + tempSen4) / 4;

    //**************************
    if (phSen < 50)
    begin
      addAcidic = 0;
      addAlkali = 1;
    end
    else if (phSen > 60)
    begin
      addAcidic = 1;
      addAlkali = 0;
    end
    else
    begin
      addAcidic = 0;
      addAlkali = 0;
    end

    if ((tempSen1 +
         tempSen2 +
         tempSen3 +
         tempSen4) < 100)
      heater = 1;
    else
    begin
      heater = 0;

      //**************************
      if ((tempSen1 +
           tempSen2 +
           tempSen3 +
           tempSen4) > 160)
        ventilator = 1;
      else
        ventilator = 0;
    end

    if (lightSen < 200)
      light = 1;
    else
      light = 0;

    if (humiditySen < 50)
      humidityGenerator = 1;
    else
      humidityGenerator = 0;

    if (doorPIRIn && !doorPIROut && !doorClose)
      doorOpen = 1;
    else if (!doorPIROut)
      doorOpen = 0;

    if (doorPIROut && !doorPIRIn && !doorClose)
      doorOpen = 1;
    else if (!doorPIRIn)
      doorOpen = 0;

    if (doorOpenMax)
    begin
      doorOpen = 0;
      doorClose = 1;
    end

    if (doorCloseMax)
      doorClose = 0;
  end
endmodule
