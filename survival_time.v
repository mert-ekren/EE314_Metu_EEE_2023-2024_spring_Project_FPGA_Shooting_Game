module survival_time(reset,over,clk,n);
input reset;
input over;
input clk;
output reg [31:0] n;
reg [31:0] k;
initial begin
k=0;
end
always @(posedge clk) begin
	if (reset) begin
	k=0;
	n=0;
	end
	else if (over) begin
		n=n;
		k=0;
	end
	else if (k==25000000) begin
	k=0;
	n=n+1;
	end
	else begin
	k=k+1;
	n=n;
	end
end
endmodule