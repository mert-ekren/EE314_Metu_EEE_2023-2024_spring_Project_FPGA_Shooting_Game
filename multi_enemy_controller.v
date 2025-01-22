module multi_enemy_controller(
    input wire clk,
    input wire reset,
    input wire [1:0] shootingtype,
    input wire [3:0] hit_angle,
    input wire [3:0] angle,
    input wire [1:0] type_enemy, // Shared enemy type for simplicity
    input wire outgoing_projectiles, // Pulse indicating projectile is fired
    output wire [7:0] over, // Over status for each enemy
    output wire [79:0] x, // X positions for each enemy
    output wire [79:0] y, // Y positions for each enemy
    output wire [31:0] health, // Health for each enemy
    output wire [7:0] active // Active status for each enemy
);

    // Parameters
    localparam MAX_ENEMIES = 8;
    localparam MIN_ENEMIES = 2;

    // Enemy instances
    wire [7:0] enemy_active;
    wire [3:0] enemy_health [MAX_ENEMIES-1:0];
    wire [9:0] enemy_x [MAX_ENEMIES-1:0];
    wire [9:0] enemy_y [MAX_ENEMIES-1:0];
    wire [7:0] enemy_over;
    integer i;

    // Instantiate the enemy modules
    genvar idx;
    generate
        for (idx = 0; idx < MAX_ENEMIES; idx = idx + 1) begin : enemy_instances
            enemy enemy_inst (
                .clk(clk),
                .shootingtype(shootingtype),
                .hit_angle(hit_angle),
                .angle(angle),
                .type_enemy(type_enemy),
                .outgoing_projectiles(outgoing_projectiles),
                .reset(reset),
                .over(enemy_over[idx]),
                .x(enemy_x[idx]),
                .y(enemy_y[idx]),
                .health(enemy_health[idx]),
                .active(enemy_active[idx])
            );
        end
    endgenerate

    // Outputs
    assign x = {enemy_x[7], enemy_x[6], enemy_x[5], enemy_x[4], enemy_x[3], enemy_x[2], enemy_x[1], enemy_x[0]};
    assign y = {enemy_y[7], enemy_y[6], enemy_y[5], enemy_y[4], enemy_y[3], enemy_y[2], enemy_y[1], enemy_y[0]};
    assign health = {enemy_health[7], enemy_health[6], enemy_health[5], enemy_health[4], enemy_health[3], enemy_health[2], enemy_health[1], enemy_health[0]};
    assign over = enemy_over;
    assign active = enemy_active;

    // Ensure at least MIN_ENEMIES are active
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < MAX_ENEMIES; i = i + 1) begin
                enemy_active[i] = (i < MIN_ENEMIES) ? 1 : 0;
            end
        end else begin
            integer active_count = 0;
            for (i = 0; i < MAX_ENEMIES; i = i + 1) begin
                if (enemy_active[i]) begin
                    active_count = active_count + 1;
                end
            end

            if (active_count < MIN_ENEMIES) begin
                for (i = 0; i < MAX_ENEMIES && active_count < MIN_ENEMIES; i = i + 1) begin
                    if (!enemy_active[i]) begin
                        enemy_active[i] = 1;
                        active_count = active_count + 1;
                    end
                end
            end
        end
    end

endmodule
