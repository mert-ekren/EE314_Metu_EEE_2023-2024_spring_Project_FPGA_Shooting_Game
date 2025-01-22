module type1random(clk,type);
input clk;
output [1:0] type;
reg [1:0] type;
reg [7:0] c_low;
reg [7:0] c_high;
initial begin
c_low=1;
c_high=1;
end
always @(posedge(clk)) begin
c_low<=c_high;
c_high<=c_low+c_high;
type<=c_high%3;
end
endmodule