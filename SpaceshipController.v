module SpaceshipController(
    input clk,
    input reset,
    input rotate_left, // Raw button input for rotating left
    input rotate_right, // Raw button input for rotating right
    input fire, // Raw button input for firing projectiles
    input [1:0]mode, // Raw button input for switching shooting modes
    output wire [3:0] angle_out, // Current angle of the spaceship
    output wire projectiles // type for 1 or 0(1bit) and the spread(16bit)
);

    wire[3:0] angle;
    wire projectile;
	 assign angle_out = {angle};
	 assign projectiles = {projectile};
    // Instantiate SpaceshipAngleControl
    SpaceshipAngleControl angle_control (
        .clk(clk),
        .reset(reset),
        .rotate_left(rotate_left),
        .rotate_right(rotate_right),
        .angle(angle)
    );

    // Instantiate SpaceshipShootingControl
    SpaceshipShootingControl shooting_control (
        .clk(clk),
        .reset(reset),
        .fire(fire),
        .projectile(projectile)
    );
	 

endmodule