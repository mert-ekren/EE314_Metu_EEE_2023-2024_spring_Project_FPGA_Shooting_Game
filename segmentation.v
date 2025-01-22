module segmentation (how_many,segment_birler,segment_onlar,segment_yzler,bir, on, yz);
input [15:0] how_many;
output reg [6:0] segment_birler, segment_onlar, segment_yzler;

output reg [3:0] bir,on,yz;

always @(how_many) begin
//bcd's will be produced within this block /////
 bir=how_many%10; 
 on=((how_many%100)-bir)/10;
 yz=(how_many-on-bir)/100;
/////////////////////////////////////////////////
if (bir==0) begin
segment_birler<=7'b1000000;
end
else if (bir==1) begin
segment_birler<=7'b1111001;
end
else if (bir==2) begin
segment_birler<=7'b0100100;
end
else if (bir==3) begin
segment_birler<=7'b0110000;
end
else if (bir==4) begin
segment_birler<=7'b0011001;
end
else if (bir==5) begin
segment_birler<=7'b0010010;
end
else if (bir==6) begin
segment_birler<=7'b0000010;
end
else if (bir==7) begin
segment_birler<=7'b1111000;
end
else if (bir==8) begin
segment_birler<=7'b0000000;
end
else if (bir==9) begin
segment_birler<=7'b0010000;
end
if (on==0) begin
segment_onlar<=7'b1000000;
end
else if (on==1) begin
segment_onlar<=7'b1111001;
end
else if (on==2) begin
segment_onlar<=7'b0100100;
end
else if (on==3) begin
segment_onlar<=7'b0110000;
end
else if (on==4) begin
segment_onlar<=7'b0011001;
end
else if (on==5) begin
segment_onlar<=7'b0010010;
end
else if (on==6) begin
segment_onlar<=7'b0000010;
end
else if (on==7) begin
segment_onlar<=7'b1111000;
end
else if (on==8) begin
segment_onlar<=7'b0000000;
end
else if (on==9) begin
segment_onlar<=7'b0010000;
end
if (yz==0) begin
segment_yzler<=7'b1000000;
end
else if (yz==1) begin
segment_yzler<=7'b1111001;
end
else if (yz==2) begin
segment_yzler<=7'b0100100;
end
else if (yz==3) begin
segment_yzler<=7'b0110000;
end
else if (yz==4) begin
segment_yzler<=7'b0011001;
end
else if (yz==5) begin
segment_yzler<=7'b0010010;
end
else if (yz==6) begin
segment_yzler<=7'b0000010;
end
else if (yz==7) begin
segment_yzler<=7'b1111000;
end
else if (yz==8) begin
segment_yzler<=7'b0000000;
end
else if (yz==9) begin
segment_yzler<=7'b0010000;
end
end
endmodule
