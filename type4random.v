module type4random(clk,type);
input clk;
output reg [1:0] type;
reg [1:0] a;

initial begin
a=2;
end

always @(posedge clk) begin
if (a==3) begin
type=0;
a=a-1;
end
else begin
type=a;
a=a-1;
end
end
endmodule
