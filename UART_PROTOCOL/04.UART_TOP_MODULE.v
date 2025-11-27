module uart_top_module(input clk1,clk2,rst,wr_data,input [7:0]data,output baud_clk_t,baud_clk_r,tx,donet,error,doner);

baud_rate_t baudt(.clk1(clk1),.rst(rst),.baud_clk_t(baud_clk_t));

baud_rate_r baudr(.clk2(clk2),.rst(rst),.baud_clk_r(baud_clk_r));

transmitter master_tx(.clk1(clk1),.rst(rst),.wr_data(wr_data),.data(data),.baud_tclk(baud_clk_t),.tx(tx),.donet(donet));

receiver slave_rx(.clk2(clk2),.rst(rst),.baud_rclk(baud_clk_r),.rx(tx),.error(error),.doner(doner));


endmodule
