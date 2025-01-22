module vga_driver (
    input wire clk,     // 25 MHz 25.172 pixel clock var her şey 25 mhz olcak logic de
    input wire reset,     
    input [23:0] color_in,
    output [9:0] next_x,  // x-coordinate of NEXT pixel
    output [9:0] next_y,  // y-coordinate of NEXT pixel 
    output wire hsync,    
    output wire vsync,    
    output [7:0] red,     
    output [7:0] green,   
    output [7:0] blue,    
    output sync,          
    output clk_vga,           
    output blank         
);

    // Horizontal parameters 
    parameter [9:0] H_ACTIVE  =  10'd_639 ;
    parameter [9:0] H_FRONT   =  10'd_15 ;
    parameter [9:0] H_PULSE   =  10'd_95 ;
    parameter [9:0] H_BACK    =  10'd_47 ;

    // Vertical parameters 
    parameter [9:0] V_ACTIVE   =  10'd_479 ;
    parameter [9:0] V_FRONT    =  10'd_9 ;
    parameter [9:0] V_PULSE =  10'd_1 ;
    parameter [9:0] V_BACK  =  10'd_32 ;

    // Parameters unutmamak için koydum 0 veya bir çok kötü duruyordu
    parameter   LOW     = 1'b_0 ;
    parameter   HIGH    = 1'b_1 ;

    // States niye 4 bit tuttum ben de bilmiyom belki değiştiririm ?
    parameter   [3:0]   H_ACTIVE_STATE    = 4'd_0 ;
    parameter   [3:0]   H_FRONT_STATE     = 4'd_1 ;
    parameter   [3:0]   H_PULSE_STATE   = 4'd_2 ;
    parameter   [3:0]   H_BACK_STATE     = 4'd_3 ;

    parameter   [3:0]    V_ACTIVE_STATE    = 4'd_0 ;
    parameter   [3:0]   V_FRONT_STATE    = 4'd_1 ;
    parameter   [3:0]   V_PULSE_STATE   = 4'd_2 ;
    parameter   [3:0]   V_BACK_STATE     = 4'd_3 ;

    // Clocked registers outputlar için
    reg              hysnc_reg ;
    reg              vsync_reg ;
    reg     [7:0]   red_reg ;
    reg     [7:0]   green_reg ;
    reg     [7:0]   blue_reg ;
    reg              line_done ;

    // Control registers counterlar bir de satete counterı
    reg     [9:0]   h_counter ;
    reg     [9:0]   v_counter ;

    reg     [3:0]    h_state ;
    reg     [3:0]    v_state ;

    // State machine acayip saçma duruyor biliyorum.
    always@(posedge clk) begin
        // At reset . . .
        if (reset) begin
            // her şeyi 0la
            h_counter   <= 10'd_0 ;
            v_counter   <= 10'd_0 ;
            // States to ACTIVE
            h_state     <= H_ACTIVE_STATE  ;
            v_state     <= V_ACTIVE_STATE  ;
            // Deassert line done
            line_done   <= LOW ;
        end
        else begin

            if (h_state == H_ACTIVE_STATE) begin
                // Iterate horizontal counter, zero at end of ACTIVE mode
                h_counter <= (h_counter==H_ACTIVE)?10'd_0:(h_counter + 10'd_1) ;
                hysnc_reg <= HIGH ;
                line_done <= LOW ;
                h_state <= (h_counter == H_ACTIVE)?H_FRONT_STATE:H_ACTIVE_STATE ;
            end
            if (h_state == H_FRONT_STATE) begin
                // Iterate horizontal counter, zero at end of H_FRONT mode
                h_counter <= (h_counter==H_FRONT)?10'd_0:(h_counter + 10'd_1) ;
                hysnc_reg <= HIGH ;
                h_state <= (h_counter == H_FRONT)?H_PULSE_STATE:H_FRONT_STATE ;
            end
            if (h_state == H_PULSE_STATE) begin
                // Iterate horizontal counter, zero at end of H_PULSE mode
                h_counter <= (h_counter==H_PULSE)?10'd_0:(h_counter + 10'd_1) ;
                hysnc_reg <= LOW ;
                h_state <= (h_counter == H_PULSE)?H_BACK_STATE:H_PULSE_STATE ;
            end
            if (h_state == H_BACK_STATE) begin
                // Iterate horizontal counter, zero at end of H_BACK mode
                h_counter <= (h_counter==H_BACK)?10'd_0:(h_counter + 10'd_1) ;
                hysnc_reg <= HIGH ;
                h_state <= (h_counter == H_BACK)?H_ACTIVE_STATE:H_BACK_STATE ;
                // Signal line complete at state transition -1 olmalı mı yoksa olmamalı mı bundan emin olamadım vstate için de geçerli bu kısmı
                line_done <= (h_counter == (H_BACK-1))?HIGH:LOW ;
            end

            if (v_state == V_ACTIVE_STATE) begin
                // increment vertical counter at end of line, zero on state transition
                v_counter<=(line_done==HIGH)?((v_counter==V_ACTIVE)?10'd_0:(v_counter+10'd_1)):v_counter ;
                vsync_reg <= HIGH ;
                // state transition
                v_state<=(line_done==HIGH)?((v_counter==V_ACTIVE)?V_FRONT_STATE:V_ACTIVE_STATE):V_ACTIVE_STATE ;
            end
            if (v_state == V_FRONT_STATE) begin
                // increment vertical counter at end of line, zero on state transition
                v_counter<=(line_done==HIGH)?((v_counter==V_FRONT)?10'd_0:(v_counter + 10'd_1)):v_counter ;
                vsync_reg <= HIGH ;
                v_state<=(line_done==HIGH)?((v_counter==V_FRONT)?V_PULSE_STATE:V_FRONT_STATE):V_FRONT_STATE;
            end
            if (v_state == V_PULSE_STATE) begin
                // increment vertical counter at end of line, zero on state transition
                v_counter<=(line_done==HIGH)?((v_counter==V_PULSE)?10'd_0:(v_counter + 10'd_1)):v_counter ;
                vsync_reg <= LOW ;
                v_state<=(line_done==HIGH)?((v_counter==V_PULSE)?V_BACK_STATE:V_PULSE_STATE):V_PULSE_STATE;
            end
            if (v_state == V_BACK_STATE) begin
                // increment vertical counter at end of line, zero on state transition
                v_counter<=(line_done==HIGH)?((v_counter==V_BACK)?10'd_0:(v_counter + 10'd_1)):v_counter ;
                vsync_reg <= HIGH ;
                v_state<=(line_done==HIGH)?((v_counter==V_BACK)?V_ACTIVE_STATE:V_BACK_STATE):V_BACK_STATE ;
            end


            red_reg<=(h_state==H_ACTIVE_STATE)?((v_state==V_ACTIVE_STATE)?{color_in[23:16]}:8'd_0):8'd_0 ;
            green_reg<=(h_state==H_ACTIVE_STATE)?((v_state==V_ACTIVE_STATE)?{color_in[15:8]}:8'd_0):8'd_0 ;
            blue_reg<=(h_state==H_ACTIVE_STATE)?((v_state==V_ACTIVE_STATE)?{color_in[7:0]}:8'd_0):8'd_0 ;

        end
    end
    // output values - to VGA connector
    assign hsync = hysnc_reg ;
    assign vsync = vsync_reg ;
    assign red = red_reg ;
    assign green = green_reg ;
    assign blue = blue_reg ;
    assign clk_vga = clk ;
    assign sync = 1'b_0 ;
    assign blank = hysnc_reg & vsync_reg ;
    // output to Drawing module 
    assign next_x = (h_state==H_ACTIVE_STATE)?h_counter:10'd_0 ;
    assign next_y = (v_state==V_ACTIVE_STATE)?v_counter:10'd_0 ;

endmodule