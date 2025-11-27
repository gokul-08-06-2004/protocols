module receiver(input clk2,baud_rclk,rst,rx,output reg [7:0]r_data,output reg error,doner);

parameter start_state=2'b00;
parameter data_state=2'b01;
parameter parity_state=2'b10;
parameter stop_state=2'b11;
reg [1:0]ps,ns;
reg [3:0]count;
reg [7:0]data;

always@(posedge clk2)begin
if(rst)begin
ns<=start_state;
ps<=start_state;
error<=0;
count<=4'd0;
data<=8'd0;
doner<=0;
r_data <=0;
end
else 
ps<=ns;
end

always@(posedge baud_rclk)begin
case(ps)
start_state:begin
if(!rx)begin
ns<=data_state;
end
else
ns<=start_state;
end

data_state:begin
if(count<=4'd7)begin
data[count]<=rx;
count<=count+1;
end
else begin
ns=parity_state;
end
end

parity_state:begin
if(((^data)^rx)==0)begin
error<=1;
doner<=1;
r_data <= data;
ns<=stop_state;
end
else begin
error<=0;
doner<=1;
data<=rx;
r_data <= data;
ns<=stop_state;
end
end

stop_state:begin
doner<=1;
ns<=stop_state;
end

default:ns<=start_state;
endcase
end
endmodule
