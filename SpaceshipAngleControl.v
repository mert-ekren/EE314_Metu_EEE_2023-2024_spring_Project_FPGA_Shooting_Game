module SpaceshipAngleControl(
	 input clk,
    input reset,
    input rotate_left,  // Button input for rotating left
    input rotate_right, // Button input for rotating right
    output reg [3:0] angle // Current angle of the spaceship
);

    parameter ANGLE_STEP = 1; // Rotation step her 1 tane sağa doğru 22.5 dereceye tekabül ediyor
	 
	 
	 // çok dönmemesi için koyuyorum sayıyı konuşalım atıcam
	 
	 reg [32:0]counter_left;
	 reg [32:0]counter_right;
	 reg [32:0]counter_reset;

	 
    always @(posedge clk ) begin
        if (reset) begin
            if (counter_reset == 7000000) begin 
					counter_reset <= 0;
					angle <= 0;
					counter_left <= 0;
					counter_right <= 0;
				end
				else begin
					counter_reset<= counter_reset +1;
					counter_left <= 0;
					counter_right <= 0;
				end
        end 
		  else begin
            if (rotate_left) begin
					if (counter_left == 7000000) begin 
						angle <= angle - ANGLE_STEP;
						counter_reset <= 0;
						counter_left <= 0;
						counter_right <= 0;
					end
					else begin
						counter_reset <= 0;
						counter_left <= counter_left +1;
						counter_right <= 0;
					end
			   end 
            if (rotate_right) begin
					if (counter_right == 7000000) begin 
						angle <= angle + ANGLE_STEP;
						counter_reset <= 0;
						counter_left <= 0;
						counter_right <= 0;
					end
					else begin
						counter_reset <= 0;
						counter_left <= 0;
						counter_right <= counter_right +1;
					end
			   end
        end
    end
endmodule
