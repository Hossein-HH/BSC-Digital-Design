`timescale 1ms/1ms
`include "projects/final/shop.v"

module shop_tb;
  integer i = 0;

  //* outputs
  wire parkingDoorOpen,
       parkingDoorClose,
       parkingWarning,
       shopDoorOpen,
       shopDoorClose,
       shopWarning,
       fan,
       heater,
       light;

  wire [31:0] parkingCapacity,
       shopCapacity,
       temp;

  //* inputs

  reg carEntranceSen,
      carExitSen,
      PIRShopEntranceSen,
      PIRShopExitSen,
      doorMin,
      doorMax;

  reg [31:0] tempSen1,
      tempSen2,
      tempSen3,
      tempSen4,
      lightSen1,
      lightSen2;

  shop uut(
         //*outputs
         .parkingDoorOpen,
         .parkingDoorClose,
         .parkingWarning,
         .parkingCapacity,
         .shopDoorOpen,
         .shopDoorClose,
         .shopWarning,
         .shopCapacity,
         .fan,
         .heater,
         .light,
         .temp,

         //* inputs
         .carEntranceSen(carEntranceSen),
         .carExitSen(carExitSen),
         .PIRShopEntranceSen(PIRShopEntranceSen),
         .PIRShopExitSen(PIRShopExitSen),
         .doorMin(doorMin),
         .doorMax(doorMax),
         .tempSen1(tempSen1),
         .tempSen2(tempSen2),
         .tempSen3(tempSen3),
         .tempSen4(tempSen4),
         .lightSen1(lightSen1),
         .lightSen2(lightSen2)
       );

  initial
  begin
    $dumpfile("shop_tb.vcd");
    $dumpvars(0,shop_tb);

    for (i = 0; i < 20; i++)
    begin
      tempSen1 = 10 + ({$random} % 30);
      tempSen2 = 10 + ({$random} % 30);
      tempSen3 = 10 + ({$random} % 30);
      tempSen4 = 10 + ({$random} % 30);
      #5;

      lightSen1 = {$random} % 1000;
      lightSen2 = {$random} % 1000;
      #5;

      // carEntranceSen
      // carExitSen
      carEntranceSen = {$random} % 2;
      #5
       carEntranceSen = 0;
      #5
       carExitSen = {$random} % 2;
      #5
       carExitSen = 0;
      #5

       // PIRShopEntranceSen
       // doorMin
       // doorMax
       PIRShopEntranceSen = {$random} % 2;

      if (shopDoorOpen)
      begin
        doorMax = 0;
        #5
         doorMax = 1;
        #5
         doorMax = 0;
        #5
         PIRShopEntranceSen = 0;
        #5;
      end

      if (shopDoorClose)
      begin
        doorMin = 0;
        #5
         doorMin = 1;
        #5
         doorMin = 0;
        #5;
      end

      // PIRShopExitSen
      // doorMin
      // doorMax
      PIRShopExitSen = {$random} % 2;

      if (shopDoorOpen)
      begin
        doorMax = 0;
        #5
         doorMax = 1;
        #5
         doorMax = 0;
        #5
         PIRShopEntranceSen = 0;
        #5;
      end

      if (shopDoorClose)
      begin
        doorMin = 0;
        #5
         doorMin = 1;
        #5
         doorMin = 0;
        #5;
      end

    end
  end

endmodule
