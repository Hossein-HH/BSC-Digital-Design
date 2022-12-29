`timescale 1ms/1ms
`include "projects/9.green_house/green_house.v"

module green_house_tb;
  integer i;

  wire heater,
       light,
       humidityGenerator,
       ventilator,
       addAlkali,
       addAcidic,
       doorOpen,
       doorClose;

  wire [31:0] temp;

  reg [31:0] tempSen1,
      tempSen2,
      tempSen3,
      tempSen4,
      phSen,
      lightSen,
      humiditySen;

  reg doorPIRIn = 0,
      doorPIROut = 0,
      doorOpenMax = 0,
      doorCloseMax = 0;

  green_house uut(
                .heater,
                .light,
                .humidityGenerator,
                .ventilator,
                .addAlkali,
                .addAcidic,
                .doorOpen,
                .doorClose,
                .temp,
                .tempSen1(tempSen1),
                .tempSen2(tempSen2),
                .tempSen3(tempSen3),
                .tempSen4(tempSen4),
                .phSen(phSen),
                .lightSen(lightSen),
                .humiditySen(humiditySen),
                .doorPIRIn(doorPIRIn),
                .doorPIROut(doorPIROut),
                .doorOpenMax(doorOpenMax),
                .doorCloseMax(doorCloseMax)
              );

  initial
  begin
    $dumpfile("green_house_tb.vcd");
    $dumpvars(0,green_house_tb);


    for (i = 0; i < 20; ++i)
    begin
      tempSen1 = 10 + ({$random} % 50);
      tempSen2 = 10 + ({$random} % 50);
      tempSen3 = 10 + ({$random} % 50);
      tempSen4 = 10 + ({$random} % 50);
      #5

       phSen = 30 + ({$random} % 50);
      #5

       lightSen = {$random} % 1000;
      #5

       humiditySen = {$random} % 100;
      #5

       doorPIRIn = {$random} % 2;
      #5

       if (doorOpen)
       begin
         doorOpenMax = 0;
         #5
          doorOpenMax = 1;
         #5
          doorOpenMax = 0;
         #5
          doorPIRIn = 0;
         #5;
       end

       if (doorClose)
       begin
         doorCloseMax = 0;
         #5
          doorCloseMax = 1;
         #5
          doorCloseMax = 0;
         #5;
       end

     end

     tempSen1 = 0;
    tempSen2 = 0;
    tempSen3 = 0;
    tempSen4 = 0;
    lightSen  = 0;
    humiditySen = 0;
    doorPIRIn = 0;
    doorPIROut = 0;
    doorOpenMax = 0;
    doorCloseMax = 0;
    #50;

    for (i = 0; i < 20; ++i)
    begin
      tempSen1 = 10 + ({$random} % 50);
      tempSen2 = 10 + ({$random} % 50);
      tempSen3 = 10 + ({$random} % 50);
      tempSen4 = 10 + ({$random} % 50);
      #5

       lightSen = {$random} % 1000;
      #5

       humiditySen = {$random} % 100;
      #5

       doorPIROut = {$random} % 2;
      #5

       if (doorOpen)
       begin
         doorOpenMax = 0;
         #5
          doorOpenMax = 1;
         #5
          doorOpenMax = 0;
         #5
          doorPIROut = 0;
         #5;
       end

       if (doorClose)
       begin
         doorCloseMax = 0;
         #5
          doorCloseMax = 1;
         #5
          doorCloseMax = 0;
         #5;
       end

     end
   end

 endmodule
