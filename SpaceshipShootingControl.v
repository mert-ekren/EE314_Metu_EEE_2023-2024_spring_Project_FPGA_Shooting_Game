module SpaceshipShootingControl(
    input wire clk,
    input wire reset,
    input wire fire, // Button input for firing projectiles
    output reg projectile // Output signal for firing projectiles
);

    reg [31:0] fire_counter;
    reg projectile_temp;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fire_counter <= 0;
            projectile_temp <= 0;
        end else begin
            if (fire) begin
                if (fire_counter == 4000000) begin
                    projectile_temp <= 1'b1;
                    fire_counter <= 0;
                end else begin
                    fire_counter <= fire_counter + 1;
                    projectile_temp <= 1'b0;
                end
            end else begin
                fire_counter <= 0;
                projectile_temp <= 1'b0;
            end
            projectile <= projectile_temp; // Update the output projectile signal
        end
    end

endmodule




