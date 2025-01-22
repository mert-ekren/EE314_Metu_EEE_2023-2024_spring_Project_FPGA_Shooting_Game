module type3random(clk,type);
input clk;
output reg [1:0] type;
reg [5:0] a;
always @(posedge clk) begin
a=a+7;
if (a[1:0]!=3) begin
type=a[1:0];
end
end
endmodule
