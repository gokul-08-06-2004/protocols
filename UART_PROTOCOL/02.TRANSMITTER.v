module transmitter(input clk1,baud_tclk,rst,wr_data,input [7:0]data,output  reg tx,donet);

parameter idle_state=3'b000;
parameter start_state=3'b001;
parameter data_state=3'b010;
parameter parity_state=3'b011;
parameter stop_state=3'b100;

reg [2:0]ps,ns;
reg [3:0]count;
reg st=0;

always@(posedge clk1)begin
if(rst)begin
ns<=idle_state;
ps<=idle_state;
count<=4'd0;
tx<=1;
donet<=0;
end
else begin
ps<=ns;
end
end

always@(posedge baud_tclk)begin
case(ps)
idle_state:begin
if(wr_data)begin
ns<=start_state;
tx<=1;
end
else
ns<=idle_state;
end

start_state:begin
if(!st)begin
ns<=data_state;
tx<=0;
st<=1;
end
else
ns<=start_state;
end

data_state:begin
if(count<=4'd7)begin
tx<=data[count];
count<=count+1;
end
else begin
count<=0;
tx <= ^data;
ns<=stop_state;
end
end

parity_state:begin
tx<=^data;
ns<=stop_state;
end

stop_state:begin
tx<=1;
donet<=1;
ns<=idle_state;
end
endcase
end
endmodule





