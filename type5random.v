module type5random(clk,type);
input clk;
output reg [1:0] type;
reg [1:0] a;
initial begin
a=1;
end
always @(posedge clk) begin
if (a==3) begin

a=a+2;
end
else if (a!=3) begin
type=a;
a=a+1;
end
end
endmodule
