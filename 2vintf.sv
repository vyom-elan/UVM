interface intf;
  logic clk;               //clock
  logic [7:0] sa, da;      //sender's address & destination's address
endinterface

class tb1;
	virtual intf vif;
   function new (virtual intf vif);
  		this.vif = vif;
	endfunction
	task run();
  		repeat(3) begin
        	@(vif.clk)
      		$display($time, "sa = %0d", vif.sa);
          $display($time, "da = %0d", vif.da);
    	end
	endtask
endclass

module fifo_testbench (intf vif1, intf vif2);
	tb1 mon1;//monitor 1
    tb1 mon2;//monitor 2
  	initial begin
    	vif1.clk=0;
        vif2.clk=0;
    	forever begin
       		#3vif1.clk = ~vif1.clk;
          	#7vif2.clk = ~vif2.clk;
  		end
  	end 
    initial begin
    	vif1.sa = 0;
    	vif1.da = 1;
    	#5
    	vif1.sa = 4;
    	vif1.da = 5;

    end
  	initial begin
     	#10
      	vif2.sa = 2;
      	vif2.da = 3;
        #10
        vif2.sa = 6;
    	vif2.da = 7;
    end
  	initial begin
      mon1 = new(vif1);
    	mon1.run();
  	end
  	initial begin
      mon2 = new(vif2);
    	mon2.run();
  	end
endmodule

module top;
	intf vif1();
	intf vif2();
  fifo_testbench ab(vif1,vif2);
endmodule
