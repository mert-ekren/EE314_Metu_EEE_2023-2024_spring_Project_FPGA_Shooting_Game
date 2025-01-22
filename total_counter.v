module total_counter(over,clk,count1,count2,count3,count4,count5,total_count);
input over;
input clk;
input [15:0] count1, count2, count3, count4, count5;
output reg [15:0] total_count;

always @(posedge clk) begin
	if (over== 0)begin
	total_count=count1+count2+count3+count4+count5;
	end
	else begin
	total_count=total_count;
	end
end
endmodule