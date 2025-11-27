module baud_rate_t(input clk1,rst,output reg baud_clk_t);
parameter integer baud_rate=115200;
parameter integer frq=50000000;
parameter integer clk_div=frq/baud_rate;
integer count;

always@(posedge clk1)begin
if(rst)begin
count<=0;
baud_clk_t<=0;
end
else begin
if(count==clk_div)begin
count<=0;
baud_clk_t<=1;
end

else begin
count<=count+1;
baud_clk_t<=0;
end
end 
end
endmodule

module baud_rate_r(input clk2,rst,output reg baud_clk_r);
parameter integer baud_rate=115200;
parameter integer frq=40000000;
parameter integer clk_div=frq/baud_rate;
integer count;

always@(posedge clk2)begin
if(rst)begin
count<=0;
baud_clk_r<=0;
end
else begin
if(count==clk_div)begin
count<=0;
baud_clk_r<=1;
end
else begin
count<=count+1;
baud_clk_r<=0;
end
end
end
endmodule
