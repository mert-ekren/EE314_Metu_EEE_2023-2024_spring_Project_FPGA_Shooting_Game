module shockwave(fire,h,v,hit_angle,shoot_mode,rgb);
input fire;
input [9:0] h;
input [9:0] v;
input [1:0] shoot_mode;
input [3:0] hit_angle;
output reg [23:0] rgb;
always @(*) begin
	rgb=24'h000000;
if (fire) begin
	case(hit_angle)
		0: begin
			if (shoot_mode==1) begin
				if (((h==240) || (h==v) || (v==479-h) || (5*h==(700+2*v)) || ((-2*v+1700)==5*h)) & (v<240)) begin
					rgb=24'h99FF99;
				end
			end
			
			if (shoot_mode==2) begin
				if (((h==240) || (5*h==(700+2*v)) || ((-2*v+1700)==5*h)) & (v<240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((h==240) & (v<240)) begin
					rgb=24'h99FF99;
				end
			end
			end
		1: begin
			if (shoot_mode==1) begin
				if (((5*h==(700+2*v)) || (h==240) || ((-2*v+1700)==5*h) || (v==479-h) || ((-2*h+1658)==5*v)) & (v<240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if ((((-2*v+1700)==5*h) || (h==240) || (v==479-h)) & (v<240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if (((-2*v+1700)==5*h) & (v<240) &(h<480)) begin
					rgb=24'h99FF99;
				end
			end
			end
		2: begin
			if (shoot_mode==1) begin
				if (((1700-2*v==5*h) || (1658-2*h==5*v) || (v==479-h) || (h==240) || (v==240)) & (v<241) & (h<480) & (h>239)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((1700-2*v==5*h) || (1658-2*h==5*v) || (v==479-h)) & (h<480) & (v<240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((v==479-h) & (v<240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			end
		3: begin
			if (shoot_mode==1) begin
				if (((479-h==v) || (v==240) || (1658-2*h==5*v) || (1700-2*v==5*h) || (2*h==5*v-700)) & (h<480) & (h>240)) begin
					rgb=24'h99FF99;
				end					
			end
			if (shoot_mode==2) begin
				if (((479-h==v) || (v==240) || (1658-2*h==5*v)) & (v<241) & (h<480) & (h>240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((1658-2*h==5*v) & (v<240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			end
		4: begin
			if (shoot_mode==1) begin
				if (((2*h==5*v-700) || (1658-2*h==5*v) || (v==240) || (h==v) || (479-h==v)) & (h>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((2*h==5*v-700) || (1658-2*h==5*v) || (v==240)) & (h>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((v==240) & (h>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			end
		5: begin
			if (shoot_mode==1) begin
				if (((h==v) || (2*h==5*v-700) || (v==240) || (5*h==700+2*v) || (5*v==1658-2*h)) & (h>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((h==v) || (2*h==5*v-700) || (v==240)) & (h>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((2*h==5*v-700) & (h>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			end
		6: begin
			if (shoot_mode==1) begin
				if (((h==v) || (5*h==700+2*v) || (2*h==5*v-700) || (h==240) || (v==240)) & (v>239) & (h>239) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((h==v) || (5*h==700+2*v) || (2*h==5*v-700)) & (h>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((h==v) & (h>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			end
		7: begin
			if (shoot_mode==1) begin
				if (((5*h==700+2*v) || (h==240) || (h==v) || (1700-2*v==5*h) || (2*h==5*v-700)) & (v>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((5*h==700+2*v) || (h==240) || (h==v)) & (v>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((5*h==700+2*v) & (v>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			end
		8: begin
			if (shoot_mode==1) begin
				if (((h==240) || (5*h==700+2*v) || (1700-2*v==5*h) || (479-h==v) || (h==v)) & (h<480) & (v>240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((h==240) || (5*h==700+2*v) || (1700-2*v==5*h)) & (v>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((h==240) & (v>240) & (h<480)) begin
					rgb=24'h99FF99;
				end					
			end
			end
		9: begin
			if (shoot_mode==1) begin
				if (((5*h==(700+2*v)) || (h==240) || ((-2*v+1700)==5*h) || (v==479-h) || ((-2*h+1658)==5*v)) & (v>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if ((((-2*v+1700)==5*h) || (h==240) || (v==479-h)) & (v>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if (((-2*v+1700)==5*h) & (v>240) &(h<480)) begin
					rgb=24'h99FF99;
				end
			end
			end
		10: begin
			if (shoot_mode==1) begin
				if (((1700-2*v==5*h) || (1658-2*h==5*v) || (v==479-h) || (h==240) || (v==240)) & (v>239) & & (h<241)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((1700-2*v==5*h) || (1658-2*h==5*v) || (v==479-h)) & (h<480) & (v>240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((v==479-h) & (v>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			end
		11: begin
			if (shoot_mode==1) begin
				if (((479-h==v) || (v==240) || (1658-2*h==5*v) || (1700-2*v==5*h) || (2*h==5*v-700)) & (h<240)) begin
					rgb=24'h99FF99;
				end					
			end
			if (shoot_mode==2) begin
				if (((479-h==v) || (v==240) || (1658-2*h==5*v)) & (v>239) & (h<240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((1658-2*h==5*v) & (v>240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			end
		12: begin
			if (shoot_mode==1) begin
				if (((2*h==5*v-700) || (1658-2*h==5*v) || (v==240) || (h==v) || (479-h==v)) & (h<240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((2*h==5*v-700) || (1658-2*h==5*v) || (v==240)) & (h<240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((v==240) & (h<240)) begin
					rgb=24'h99FF99;
				end
			end
			end
		13: begin
			if (shoot_mode==1) begin
				if (((h==v) || (2*h==5*v-700) || (v==240) || (5*h==700+2*v) || (5*v==1658-2*h)) & (h<240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((h==v) || (2*h==5*v-700) || (v==240)) & (h<240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((2*h==5*v-700) & (h<240)) begin
					rgb=24'h99FF99;
				end
			end
			end
		14: begin
			if (shoot_mode==1) begin
				if (((h==v) || (5*h==700+2*v) || (2*h==5*v-700) || (h==240) || (v==240)) & (v<241) & (h<241)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((h==v) || (5*h==700+2*v) || (2*h==5*v-700)) & (h<240)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((h==v) & (h<240)) begin
					rgb=24'h99FF99;
				end
			end
			end
		15: begin
			if (shoot_mode==1) begin
				if (((5*h==700+2*v) || (h==240) || (h==v) || (1700-2*v==5*h) || (2*h==5*v-700)) & (v<240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==2) begin
				if (((5*h==700+2*v) || (h==240) || (h==v)) & (v<240) & (h<480)) begin
					rgb=24'h99FF99;
				end
			end
			if (shoot_mode==3) begin
				if ((5*h==700+2*v) & (v<240)) begin
					rgb=24'h99FF99;
				end
			end
			end
	endcase
end
end
endmodule


