module shootled(sw,led);
input [1:0] sw;
output reg [2:0] led;
always @(sw) begin
	if (sw==0) begin
		led=0;
	end
	else if (sw==1) begin
		led=1;
	end
	else if (sw==2) begin
		led=2;
	end
	else if (sw==3) begin
		led=4;
	end
	else begin
	led =0;
	end
end
endmodule
