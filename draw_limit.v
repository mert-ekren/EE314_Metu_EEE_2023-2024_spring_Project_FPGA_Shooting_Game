module draw_limit(h,v,rgb);
input [9:0] h, v;
output reg [23:0] rgb;
always @(*) begin
	rgb=24'h000000;
	if ((h>480) &( (v==110) || (v==210))) begin
		rgb=24'hFFFF00;
	end
	else begin
	rgb=24'h000000;
	end
end
endmodule
