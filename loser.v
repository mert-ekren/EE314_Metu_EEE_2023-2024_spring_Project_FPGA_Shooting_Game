module loser(clk,over,ledr);
input over,clk;
output reg [9:0] ledr;
reg [31:0] k;
initial begin
k=0;
end
always @(posedge (clk)) begin
if (over) begin
	if ((k>=12500000) & (k<25000000)) begin
		ledr=10'b1111111111;
		k=k+1;
	end
	else if (k<12500000) begin
		ledr=10'b0000000000;
		k=k+1;
	end
	else if (k==25000000) begin
		k=0;
	end
end
else begin
	ledr=10'b1111111111;
end
end
endmodule
