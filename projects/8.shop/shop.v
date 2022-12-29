module shop(
    //* outputs
    parkingDoorOpen,
    parkingDoorClose,
    parkingWarning,
    parkingCapacity,
    shopDoorOpen,
    shopDoorClose,
    shopWarning,
    shopCapacity,
    fan,
    heater,
    light,
    temp,

    //* inputs
    carEntranceSen,
    carExitSen,
    PIRShopEntranceSen,
    PIRShopExitSen,
    doorMin,
    doorMax,
    tempSen1,
    tempSen2,
    tempSen3,
    tempSen4,
    lightSen1,
    lightSen2
  );

  output parkingDoorOpen,
         parkingDoorClose,
         parkingWarning,
         shopDoorOpen,
         shopDoorClose,
         shopWarning,
         fan,
         heater,
         light;

  output [31:0] parkingCapacity,
         shopCapacity,
         temp;

  reg parkingDoorOpen = 0,
      parkingDoorClose = 0,
      parkingWarning = 0,
      shopDoorOpen = 0,
      shopDoorClose = 0,
      shopWarning = 0,
      fan = 0,
      heater = 0,
      light = 0;

  reg [31:0] parkingCapacity = 0,
      shopCapacity = 0,
      temp = 0;

  input carEntranceSen,
        carExitSen,
        PIRShopEntranceSen,
        PIRShopExitSen,
        doorMin,
        doorMax;

  input [31:0] tempSen1,
        tempSen2,
        tempSen3,
        tempSen4,
        lightSen1,
        lightSen2;


  always @(tempSen1 or tempSen2 or tempSen3 or tempSen4)
  begin
    temp = (tempSen1 + tempSen2 + tempSen3 + tempSen4) / 4;
  end

  always @(*)
  begin
    // parkingDoorOpen
    // parkingCapacity
    // parkingDoorClose
    if (carEntranceSen && parkingCapacity < 5)
    begin
      parkingDoorOpen = 1;
      parkingCapacity++;
      #5;
      parkingDoorClose = 1;
      #5;
      parkingDoorOpen = 0;
      parkingDoorClose = 0;
      #5;
    end

    if (carExitSen && parkingCapacity > 0)
    begin
      parkingDoorOpen = 1;
      parkingCapacity--;
      #5;
      parkingDoorClose = 1;
      #5;
      parkingDoorOpen = 0;
      parkingDoorClose = 0;
      #5;
    end

    // parkingWarning
    if (parkingCapacity > 5)
      parkingWarning = 1;
    else
      parkingWarning = 0;

    // shopDoorOpen
    // shopCapacity
    if (PIRShopEntranceSen && shopCapacity < 20 && !PIRShopExitSen)
    begin
      shopDoorOpen = 1;
      shopCapacity++;
    end
    else
      shopDoorOpen = 0;


    if (PIRShopExitSen && shopCapacity > 0 && !PIRShopEntranceSen)
    begin
      shopDoorOpen = 1;
      shopCapacity--;
    end
    else
      shopDoorOpen = 0;

    // shopDoorClose
    if (doorMax)
    begin
      shopDoorOpen = 0;
      shopDoorClose = 1;
    end

    if (doorMin)
      shopDoorClose = 0;

    // shopWarning
    if (shopCapacity > 20)
      shopWarning = 1;
    else
      shopWarning = 0;

    // fan
    if (temp > 27)
      fan = 1;
    else
      fan = 0;

    // heater
    if (temp < 25)
      heater = 1;
    else
      heater = 0;

    // light
    if (lightSen1 + lightSen2 < 400)
      light = 1;
  end
endmodule
