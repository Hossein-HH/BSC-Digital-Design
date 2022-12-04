module TFlipFlop(T,Clk,Q,Qbar );
input T,Clk;
output Q,Qbar;
reg Q,Qbar;
always@(T,posedge(Clk))
begin
if(T==0)
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

 initial Clk = 0;
    always #100 Clk = ~Clk;
 initial T=0;
   always #100 T=~T;
initial begin
// Initialize Inputs
T = 0;
Clk = 0;
// Wait 100 ns for global reset to finish
 // Add stimulus here
end
endmodule