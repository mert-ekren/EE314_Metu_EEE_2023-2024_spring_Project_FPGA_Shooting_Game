module TopLevelDrawing(
	 input over,
	 input fire,
	 input [1:0] mode,
	 input [1:0] typeout1,// 1
	 input [3:0] health, //health_enemy1
    input clk,
    input reset,
    input [9:0] xpixel, // Current horizontal pixel coordinate from VGA driver
    input [9:0] ypixel, // Current vertical pixel coordinate from VGA driver
    input [3:0] angle_idx, // Current angle index of the spaceship
	 input [9:0]x_mid1, // xmid_enemy1
	 input [9:0]y_mid1, // ymid_enemy1
    output reg [23:0] rgb, // Output RGB value for the current pixel
	 
	 input [9:0]x_mid2, // xmid_enemy2
	 input [9:0]y_mid2, // ymid_enemy2
	 input [1:0] typeout2,// type_of_enemy2
	 input [3:0] health2, //health_enemy2
	 
	 input [9:0]x_mid3, // xmid_enemy3
	 input [9:0]y_mid3, // ymid_enemy3
	 input [1:0] typeout3,// type_of_enemy3
	 input [3:0] health3, //health_enemy3	
	 
	 input [9:0]x_mid4, // xmid_enemy4
	 input [9:0]y_mid4, // ymid_enemy4
	 input [1:0] typeout4,// type_of_enemy4
	 input [3:0] health4, //health_enemy4 
	 
	 input [9:0]x_mid5, // xmid_enemy4
	 input [9:0]y_mid5, // ymid_enemy4
	 input [1:0] typeout5,// type_of_enemy4
	 input [3:0] health5, //health_enemy4 
	 
	 input [3:0] digit1,
	 input [3:0] digit10,
	 input [3:0] digit100
);

    // Center of the screen for 640x480 resolution
    parameter X_CENTER = 240;
    parameter Y_CENTER = 240;

    wire [23:0] player_rgb;
	 wire [23:0] back_rgb;
	 wire [23:0] enemy1_rgb;
    wire blank;
	 wire [23:0] score1_rgb;
	 wire [23:0] fire_rgb;
	 wire [23:0] enemy2_rgb;
	 wire [23:0] enemy3_rgb;
	 wire [23:0] enemy4_rgb;
	 wire [23:0] enemy5_rgb;
	 
	 wire [23:0] over_rgb;
	 wire [23:0] rgb_ea;
	 
	 wire [23:0] rgb_birler;
	 wire [23:0] rgb_onlar;
	 wire [23:0] rgb_yzler;
	 wire [23:0] rgb_name;
	 wire [23:0] rgb_shoottype;
	 wire [23:0] rgb_border;
	 
    // Instantiate PlayerDrawing module
    PlayerDrawing player_draw (
        .hcount(xpixel),
        .vcount(ypixel),
        .x_center(X_CENTER),
        .y_center(Y_CENTER),
        .angle_idx(angle_idx),
        .rgb(player_rgb)
    );
	 
    // Instantiate enemy1Drawing module
	 enemy_drawing draw1(
	 .health(health),
	 .type(typeout1),
	 .x_mid(x_mid1),
	 .y_mid(y_mid1),
	 .hcount(xpixel),
	 .vcount(ypixel),
	 .rgb(enemy1_rgb)
	 );
	 
	 // inst enemy2
	 enemy_drawing2 draw2(
	 .health(health2),
	 .type(typeout2),
	 .x_mid(x_mid2),
	 .y_mid(y_mid2),
	 .hcount(xpixel),
	 .vcount(ypixel),
	 .rgb(enemy2_rgb)
	 );
	 
	 // inst enemy3
	 enemy_drawing3 draw3(
	 .health(health3),
	 .type(typeout3),
	 .x_mid(x_mid3),
	 .y_mid(y_mid3),
	 .hcount(xpixel),
	 .vcount(ypixel),
	 .rgb(enemy3_rgb)
	 );
	 // inst enemy4
	 enemy_drawing4 draw4(
	 .health(health4),
	 .type(typeout4),
	 .x_mid(x_mid4),
	 .y_mid(y_mid4),
	 .hcount(xpixel),
	 .vcount(ypixel),
	 .rgb(enemy4_rgb)
	 );
 
	 // inst enemy5
	 enemy_drawing5 draw5(
	 .health(health5),
	 .type(typeout5),
	 .x_mid(x_mid5),
	 .y_mid(y_mid5),
	 .hcount(xpixel),
	 .vcount(ypixel),
	 .rgb(enemy5_rgb)
	 );
	  
	 // instantiate shockwave
	 shockwave laser(.fire(fire),.h(xpixel),.v(ypixel),.hit_angle(angle_idx),.shoot_mode(mode),.rgb(fire_rgb));
	 //instantiate scoreboard module
	 scoreside score1(.mode(mode),.h(xpixel),.v(ypixel),.rgb(score1_rgb));
	 
	 // instantiate dotted background
	 ground backgrounddots (.h(xpixel),.v(ypixel),.rgb(back_rgb));
	 
	 // instantiate over screen
	 
	over_drawing overscreen(
	.hcount(xpixel),
	.vcount(ypixel),
	.reset(reset),
	.over(over),
	.rgb(over_rgb));

	EA ea(
	.hsync(xpixel),
	.vsync(ypixel),
	.rgb(rgb_ea));
	
	// bcd digits 
	birler bir(
	.digit1(digit1),
	.hsync(xpixel),
	.vsync(ypixel),
	.rgb(rgb_birler)
);

	onlar on(
	.digit10(digit10),
	.hsync(xpixel),
	.vsync(ypixel),
	.rgb(rgb_onlar)
);


	yzler yz(
	.digit100(digit100),
	.hsync(xpixel),
	.vsync(ypixel),
	.rgb(rgb_yzler)
);

	score_name namer(
	.hsync(xpixel),
	.vsync(ypixel),
	.rgb(rgb_name));
	
	shooting_name shoottypename(
	.hsync(xpixel),
	.vsync(ypixel),
	.rgb(rgb_shoottype));
	
	draw_limit draw_limit_draw(.h(xpixel),.v(ypixel),.rgb(rgb_border));
			 
	 
    // Set the RGB output based on the player and enemy drawings
    always @(posedge clk) begin
        if (reset) begin
            rgb <= 24'h000000;
        end else if (!blank) begin
            // Simple priority scheme: player over enemies, enemies over background
				if (over_rgb != 24'h000000) begin
					 rgb <= over_rgb;
				end
            else if (player_rgb != 24'h000000) begin
                rgb <= player_rgb;
            end 
				
				// enemy1
				else if (enemy1_rgb != 24'h000000) begin
					rgb <= enemy1_rgb;
				end
				
				//enemy2
				else if(enemy2_rgb != 24'h000000) begin
					rgb <= enemy2_rgb;
				end
				//enemy3
				else if(enemy3_rgb != 24'h000000) begin
					rgb <= enemy3_rgb;
				end	
				//enemy4
				else if(enemy4_rgb != 24'h000000) begin
					rgb <= enemy4_rgb;
				end
				// enemy5
				else if(enemy5_rgb != 24'h000000) begin
					rgb <= enemy5_rgb;
				end	
				
				else if (rgb_birler!= 24'h000000) begin
					rgb <= rgb_birler;
				end
				else if (rgb_onlar!= 24'h000000) begin
					rgb <= rgb_onlar;
				end
				else if (rgb_yzler!= 24'h000000) begin
					rgb <= rgb_yzler;
				end
				else if (rgb_name!= 24'h000000) begin
					rgb <= rgb_name;
				end	
				else if (fire_rgb!= 24'h000000) begin
					rgb <= fire_rgb;
				end
				else if (rgb_ea!= 24'h000000) begin
					rgb <= rgb_ea;
				end
				else if (rgb_border!= 24'h000000) begin
					rgb <= rgb_border;
				end
				else if (rgb_shoottype!= 24'h000000) begin
					rgb <= rgb_shoottype;
				end
				else if (score1_rgb!=24'h000000) begin
					rgb<=score1_rgb;
				end
				else if (back_rgb!=24'h000000) begin
					rgb<= back_rgb;
				end
				else begin 
				rgb <= 24'h702963;
				end
			end
    end
endmodule
