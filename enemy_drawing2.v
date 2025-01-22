module enemy_drawing2(
input [1:0] type,
input [3:0] health,
input [9:0]x_mid,
input[9:0] y_mid,
input [9:0] hcount, 
input [9:0] vcount, 
output reg [23:0] rgb // Output RGB value for the player pixel
);

reg [15:0] sprite [0:15];
    always @(*) begin
		 case (type)
		 2'd0: begin
			sprite [0] = 16'b1111111111111111;
			sprite [1] = 16'b1111111111111111;
			sprite [2] = 16'b1111111111111111;
			sprite [3] = 16'b1111111111111111;
			sprite [4] = 16'b1111111111111111;
			sprite [5] = 16'b1111111111111111;
			sprite [6] = 16'b1111111111111111;
			sprite [7] = 16'b1111111111111111;
			sprite [8] = 16'b1111111111111111;
			sprite [9] = 16'b1111111111111111;
			sprite [10] =16'b1111111111111111;
			sprite [11] =16'b1111111111111111;
			sprite [12] =16'b1111111111111111;
			sprite [13] =16'b1111111111111111;
			sprite [14] =16'b1111111111111111;
			sprite [15] =16'b1111111111111111;
		end
		 2'd1: begin
			sprite [0] = 16'b0000111111110000;
			sprite [1] = 16'b0000111111110000;
			sprite [2] = 16'b0000111111110000;
			sprite [3] = 16'b0000111111110000;
			sprite [4] = 16'b0000111111110000;
			sprite [5] = 16'b1111111111111111;
			sprite [6] = 16'b1111111111111111;
			sprite [7] = 16'b1111111111111111;
			sprite [8] = 16'b1111111111111111;
			sprite [9] = 16'b1111111111111111;
			sprite [10] =16'b1111111111111111;
			sprite [11] =16'b0000111111110000;
			sprite [12] =16'b0000111111110000;
			sprite [13] =16'b0000111111110000;
			sprite [14] =16'b0000111111110000;
			sprite [15] =16'b0000111111110000;
		end
		 2'd2: begin		
			sprite [0] = 16'b0000011111100000;
			sprite [1] = 16'b0000111111110000;
			sprite [2] = 16'b0001111111111000;
			sprite [3] = 16'b0011111111111100;
			sprite [4] = 16'b0111111111111110;
			sprite [5] = 16'b1111111111111111;
			sprite [6] = 16'b1111111111111111;
			sprite [7] = 16'b1111111111111111;
			sprite [8] = 16'b1111111111111111;
			sprite [9] = 16'b1111111111111111;
			sprite [10] =16'b0111111111111110;
			sprite [11] =16'b0011111111111100;
			sprite [12] =16'b0001111111111000;
			sprite [13] =16'b0000111111110000;
			sprite [14] =16'b0000011111100000;
			sprite [15] =16'b0000000000000000;

		end
	endcase
end

wire signed [9:0] x_rel, y_rel;
assign x_rel = hcount - x_mid;
assign y_rel = vcount - y_mid;

    always @(*) begin
        // Default color is black
        rgb = 24'h000000;
        // Check if the current pixel is within the bounds of the sprite
        if (x_rel >= -8 && x_rel < 8 && y_rel >= -8 && y_rel < 8) begin
            if (sprite[y_rel + 8][x_rel + 8]) begin
					 if (type == 2'b00)begin
						rgb <=24'hFF0000;
					 end
					 else if (health ==4)begin
						rgb=24'hFFFFFF;
					 end  
					 else if (health==3) begin 
					 rgb = 24'hFF00FF;
					 end					 
					 else if (health ==2) begin
						rgb=24'hFFF000;
					 end 
					 else begin
						rgb = 24'hFF0000; 
					 end
            end
        end
    end
endmodule
