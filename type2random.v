module type2random(clk,type);
input clk;
output reg [1:0] type;
reg [1:0] cnt;
initial begin
cnt=0;
end
always @(posedge clk) begin
cnt=cnt+1;
if (cnt==3) begin
cnt=0;
end
type=cnt;
end
endmodule

