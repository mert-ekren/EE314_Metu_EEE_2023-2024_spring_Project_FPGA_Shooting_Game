module scoreside(mode,h,v,rgb);
input [9:0] h;
input [1:0] mode;
input [9:0] v;
output reg [23:0] rgb;

always @(*) begin

        rgb = 24'h000000;
				if (h>480) begin
                rgb = 24'h880000;
					if (mode==1) begin
						if (v>455 & v<460 & h>540 & h<580) begin
							rgb=24'h99FFFF;
						end
					end
					if (mode==2) begin
						if ((v>455 & v<460 & h>540 & h<580) || (v>445 & v<450 & h>540 & h<580)) begin
							rgb=24'h99FFFF;
						end
					end
					if (mode==3) begin
						if ((v>455 & v<460 & h>540 & h<580) || (v>445 & v<450 & h>540 & h<580) || (v>435 & v<440 & h>540 & h<580)) begin
							rgb=24'h99FFFF;
						end
					end
            end
    end
endmodule
