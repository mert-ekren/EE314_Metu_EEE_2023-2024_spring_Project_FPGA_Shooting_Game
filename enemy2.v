module enemy2(
    input wire clk,
    input wire [1:0] shootingtype, // from sw
    input wire [3:0] hit_angle, // from the player controller
    input wire [3:0] angle, // angle of attack fron rngm
    input wire [1:0] type_enemy, // Type of the enemy input fron rngm
    input wire outgoing_projectiles, // Pulse indicating projectile is fired
    input wire reset, // from key 0
    output reg over, // to ledr 9
    output reg [9:0] x, 
    output reg [9:0] y,
    output reg [3:0] health,
    output reg active,
	 output reg [1:0] type_out1,
	 output reg [15:0] counter_2
);

    // Local parameters for health based on enemy type
    localparam type0h = 1;
    localparam type1h = 2;
    localparam type2h = 4;

    // Registers
    reg [7:0] damage;
    reg f;
    reg [31:0] counter_movement;
	 reg [31:0] counter_reset;
	 reg [3:0] angle_temp;
	 reg [1:0] type_temp;
	 reg [15:0] counter_number;

    // Initialization
    initial begin
        f = 1;
        active = 1;
        damage <= 0;
    end


    // Enemy movement logic
    always @(posedge clk) begin
	 counter_2<= counter_number;
        case (type_temp)
            2'b00: begin
					type_out1 <= 2'b00;
                if (damage >= type0h) begin
                    active <= 0;
						  f<=1;
						  damage <=0;
						  counter_number<=counter_number+1;
                end else begin
                    active <= 1;
						  counter_number<=counter_number;
                end
            end
            2'b01: begin
					type_out1 <= 2'b01;
                if (damage >= type1h) begin
                    active <= 0;
						  f<=1;
						  damage<=0;
						counter_number<=counter_number+1;
                end else begin
                    active <= 1;
                    health <= type1h - damage;
						 counter_number<=counter_number;
                end
            end
            2'b10: begin
					type_out1 <= 2'b10;
                if (damage >= type2h) begin
                    active <= 0;
						  f<=1;
						  damage <=0;
						  counter_number<=counter_number+1;
                end else begin
                    active <= 1;
                    health <= type2h - damage;
						  counter_number<=counter_number;
                end
            end
        endcase
        if (reset) begin
				if (counter_reset ==1250000) begin
					// Reset conditions
					x <= 0;
					y <= 0;
					counter_movement <= 0;
					f <= 1;
					over<=0;
					active<=1;
					damage<=0;
					counter_reset<=0;
					counter_number<=0;
				end
				else begin
					counter_reset<= counter_reset+1;
				end
			end
			   else if (outgoing_projectiles) begin
					case (shootingtype)
						 2'b01: begin
							  if (hit_angle ==0) begin 	  
								if (angle_temp ==14 ||angle_temp ==15 || angle_temp== 0 || angle_temp==1|| angle_temp==2) begin
									damage <= damage + 1;
								end 
								else begin
									damage <=damage;
								end
							  end
							  else if (hit_angle ==1) begin 	  
									if (angle_temp ==15 ||angle_temp ==0 || angle_temp== 1 || angle_temp==2|| angle_temp==3) begin
										damage <= damage + 1;
									end 
									else begin
										damage <=damage;
									end
							  end
							  else if (hit_angle ==2) begin 	  
									if (angle_temp ==0 ||angle_temp ==1 || angle_temp== 2 || angle_temp==3|| angle_temp==4) begin
										damage <= damage + 1;
									end 
									else begin
										damage <=damage;
									end
							  end
							  else if (hit_angle ==15) begin 	  
									if (angle_temp ==13 ||angle_temp ==14 || angle_temp== 15 || angle_temp==0|| angle_temp==1) begin
										damage <= damage + 1;
									end 
									else begin
										damage <=damage;
									end
							  end
							  else if (hit_angle ==14) begin 	  
									if (angle_temp ==12 ||angle_temp ==13 || angle_temp== 14 || angle_temp==15|| angle_temp==0) begin
										damage <= damage + 1;
									end 
									else begin
										damage <=damage;
									end
							  end
							  else if (hit_angle == angle_temp-2 || hit_angle == angle_temp-1 || hit_angle == angle_temp || hit_angle == angle_temp+1 || hit_angle == angle_temp+2) begin
									damage <= damage + 1;
							  end
							  else begin
							  damage <= damage;
							  end
						 end
						 2'b10: begin
							  if (hit_angle ==0) begin 	  
								if (angle_temp ==15 || angle_temp== 0 || angle_temp==1) begin
									damage <= damage + 2;
								end 
								else begin
									damage <=damage;
								end
							  end
							  else if (hit_angle ==1) begin 	  
									if (angle_temp ==0 ||angle_temp ==1 || angle_temp== 2) begin
										damage <= damage + 2;
									end 
									else begin
										damage <=damage;
									end
							  end
							  else if (hit_angle ==15) begin 	  
									if (angle_temp ==14 ||angle_temp ==15 || angle_temp== 0) begin
										damage <= damage + 2;
									end 
									else begin
										damage <=damage;
									end
							  end
							  else if (hit_angle == angle_temp-1 || hit_angle == angle_temp || hit_angle == angle_temp+1) begin
									damage <= damage + 2;
							  end

							  else begin
							  damage <= damage;
							  end
						 end
						 2'b11: begin
							  if (hit_angle == angle_temp) begin
									damage <= 6;
							  end
							  else begin
							  damage <= damage;
							  end
						 end
						 default: begin
							  damage <= damage;
						 end
					endcase
				end
        else if (active) begin
            if (f) begin
					type_temp <= type_enemy;
					f <= 0;
                case (angle)
                    4'd0: begin x = 240; y = 0;angle_temp =4'd0; end
                    4'd1: begin x = 340; y = 0;angle_temp =4'd1; end
                    4'd2: begin x = 476; y = 0;angle_temp =4'd2; end
                    4'd3: begin x = 479; y = 140;angle_temp =4'd3; end
                    4'd4: begin x = 475; y = 240;angle_temp =4'd4; end
                    4'd5: begin x = 479; y = 340;angle_temp =4'd5; end
                    4'd6: begin x = 476; y = 476;angle_temp =4'd6; end
                    4'd7: begin x = 340; y = 479;angle_temp =4'd7; end
                    4'd8: begin x = 240; y = 475;angle_temp =4'd8; end
                    4'd9: begin x = 140; y = 479;angle_temp =4'd9; end
                    4'd10: begin x = 0; y = 476;angle_temp =4'd10; end
                    4'd11: begin x = 0; y = 340;angle_temp =4'd11; end
                    4'd12: begin x = 0; y = 240;angle_temp =4'd12; end
                    4'd13: begin x = 0; y = 140;angle_temp =4'd13; end
                    4'd14: begin x = 0; y = 0;angle_temp =4'd14; end
                    4'd15: begin x = 140; y = 0;angle_temp =4'd15; end
                endcase
            end

            // Movement logic
				if (f==0) begin
					case (angle_temp)
						 4'd0: begin 
							  if (y == 240 && x == 240) begin
									over <= 1;
							  end else if (counter_movement == 12500000) begin
									y <= y + 5;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd1: begin    
							  if (y == 240 && x == 244) begin
									over <= 1;
							  end else if (counter_movement == 12500000) begin
									y <= y + 5;
									x <= x - 2;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd2: begin 
							  if (y >= 240 && x <= 240) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									y <= y + 4;
									x <= x - 4;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd3: begin
							  if (y <= 236 && x == 239) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									y <= y + 2;
									x <= x - 5;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd4: begin
							  if (y == 240 && x == 240) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x - 5;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd5: begin
							  if (y == 244 && x == 239) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x - 5;
									y <= y - 2;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd6: begin
							  if (y == 240 && x == 240) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x - 4;
									y <= y - 4;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd7: begin
							  if (y == 239 && x == 244) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x - 2;
									y <= y - 5;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd8: begin
							  if (y == 240 && x == 240) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									y <= y - 5;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd9: begin
							  if (y == 239 && x == 236) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x + 2;
									y <= y - 5;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd10: begin
							  if (y <= 240 && x >= 240) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x + 4;
									y <= y - 4;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd11: begin
							  if (y == 244 && x == 240) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x + 5;
									y <= y - 2;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd12: begin
							  if (y == 240 && x == 240) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x + 5;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd13: begin
							  if (y == 236 && x == 240) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x + 5;
									y <= y + 2;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd14: begin
							  if (y == 240 && x == 240) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x + 4;
									y <= y + 4;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
						 4'd15: begin
							  if (y == 240 && x == 236) begin
									over <= 1;
							  end else if(counter_movement == 12500000) begin
									x <= x + 2;
									y <= y + 5;
									counter_movement <= 0;
							  end else begin
									counter_movement <= counter_movement + 1;
							  end
						 end
					endcase
				end
        end
	end
endmodule