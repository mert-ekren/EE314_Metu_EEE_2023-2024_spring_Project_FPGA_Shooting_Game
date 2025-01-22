module ground(h,v,rgb);
input [9:0] h;
input [9:0] v;
output reg [23:0] rgb;
always @(*) begin
	rgb=24'h000000;
	if ((h%32==0) & (v%24==0)) begin
		rgb=24'hF9C442;
	end
end
endmodule