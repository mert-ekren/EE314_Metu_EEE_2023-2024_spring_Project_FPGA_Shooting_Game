module angle4random(clk,angular);
input clk;
output reg [3:0] angular;
always @(posedge clk) begin
angular=angular*3+7;
end
endmodule
