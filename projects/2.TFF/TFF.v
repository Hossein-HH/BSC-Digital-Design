module TFlipFlop(T,Clk,Q,Qbar);

  input T,Clk;

  output Q,Qbar;
  reg Q,Qbar;

  always@(T,posedge(Clk))

  begin
    if(T == 0)
    begin
      Q =1'b1;
      Qbar=1'b0;
    end
    else
    begin
      Q =1'b0;
      Qbar=1'b1;
    end
  end
endmodule

module TFlipFlopTB;

  // Inputs
  reg T;
  reg Clk;

  // Outputs
  wire Q;
  wire Qbar;

  // Instantiate the Unit Under Test (UUT)
  TFlipFlop uut (
              .T(T),
              .Clk(Clk),
              .Q(Q),
              .Qbar(Qbar)
            );

  initial
    Clk = 0;
  always #100 Clk = ~Clk;
  initial
    T=0;
  always #100 T=~T;
  initial
  begin
    // Initialize Inputs
    T = 0;
    Clk = 0;
    // Wait 100 ns for global reset to finish
    // Add stimulus here
  end
endmodule

module TFF (    input clk,
                input rstn,
                input t,
                output reg q);

  always @ (posedge clk)
  begin
    if (!rstn)
      q <= 0;
    else
      if (t)
        q <= ~q;
      else
        q <= q;
  end
endmodule


module tb_TFF;
  reg clk;
  reg rstn;
  reg t;
  reg [4:0]dly;

  integer i;
  TFF u0 (.clk(clk),
          .rstn(rstn),
          .t(t),
          .q(q));

  always #5 clk = ~clk;

  initial
  begin
    {rstn, clk, t} <= 0;

    $monitor ("T=%0t rstn=%0b t=%0d q=%0d", $time, rstn, t, q);
    repeat (2) @(posedge clk);
    rstn= 1;

    for ( i = 0; i< 20; i = i+1)
    begin
      dly = $random;
      #(dly) t <= $random;
    end

    #20
     $finish;
  end
endmodule
