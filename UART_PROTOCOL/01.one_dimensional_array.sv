// Code your design here
module one_dimensional_array;
//  shortint arr[0:2]='{1,2,3};
  //shortint arr[3];
  byte arr[3];
  initial begin
    arr[0]=5;
    arr[1]=127;
    arr[2]=3;
    foreach(arr[i])begin
      $display("arr[%0d]=%0d",i,arr[i]);
    end
  end
    endmodule