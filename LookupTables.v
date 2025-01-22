module LookupTables(
    input [3:0] angle_idx, // Index of the angle (0-15 for 0, 22.5, ..., 337.5 degrees)
    output reg signed [10:0] cos_val, // Fixed-point representation
    output reg signed [10:0] sin_val  // Fixed-point representation
);

    // Define the lookup table values for cos and sin
    always @(*) begin
        case (angle_idx)
            5'd0: begin cos_val = 11'd1024; sin_val = 11'd0; end       // 0 degrees
            5'd1: begin cos_val = 11'd949; sin_val = 11'd383; end      // 22.5 degrees
            5'd2: begin cos_val = 11'd724; sin_val = 11'd724; end      // 45 degrees
            5'd3: begin cos_val = 11'd383; sin_val = 11'd949; end      // 67.5 degrees
            5'd4: begin cos_val = 11'd0; sin_val = 11'd1024; end       // 90 degrees
            5'd5: begin cos_val = -11'd383; sin_val = 11'd949; end     // 112.5 degrees
            5'd6: begin cos_val = -11'd724; sin_val = 11'd724; end     // 135 degrees
            5'd7: begin cos_val = -11'd949; sin_val = 11'd383; end     // 157.5 degrees
            5'd8: begin cos_val = -11'd1024; sin_val = 11'd0; end      // 180 degrees
            5'd9: begin cos_val = -11'd949; sin_val = -11'd383; end    // 202.5 degrees
            5'd10: begin cos_val = -11'd724; sin_val = -11'd724; end   // 225 degrees
            5'd11: begin cos_val = -11'd383; sin_val = -11'd949; end   // 247.5 degrees
            5'd12: begin cos_val = 11'd0; sin_val = -11'd1024; end     // 270 degrees
            5'd13: begin cos_val = 11'd383; sin_val = -11'd949; end    // 292.5 degrees
            5'd14: begin cos_val = 11'd724; sin_val = -11'd724; end    // 315 degrees
            5'd15: begin cos_val = 11'd949; sin_val = -11'd383; end    // 337.5 degrees
            default: begin cos_val = 11'd1024; sin_val = 11'd0; end    // Default to 0 degrees
        endcase
    end
endmodule