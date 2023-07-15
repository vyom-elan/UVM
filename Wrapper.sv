interface intf();
  logic clk;
  logic [7:0] sa, da;
endinterface

class wrapper extends uvm_object;
  virtual intf vif;
  `uvm_object_utils(wrapper)
  
  function new (string name = "", virtual intf vif=null);
    super.new(name);
    this.vif = vif;
  endfunction
endclass


class switch_item extends uvm_sequence_item;
  randc bit [7:0]  	sa, da;
  `uvm_object_utils_begin(switch_item)
  	`uvm_field_int (sa, UVM_ALL_ON)
  	`uvm_field_int (da, UVM_ALL_ON)
  `uvm_object_utils_end
  function new(string name = "switch_item");
    super.new(name);
  endfunction
endclass    




class switch_item_sequencer extends uvm_sequencer #(switch_item);
  `uvm_sequencer_utils(switch_item_sequencer)
  function new(string name="name", uvm_component parent=null);
		super.new(name,parent);
	endfunction
endclass    




class driver extends uvm_driver #(switch_item);
  
  `uvm_component_utils_begin(driver)
  	`uvm_field_object (wr, UVM_DEFAULT)
  `uvm_component_utils_end
  
    wrapper wr;
  
  function new(string name = "driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual function void end_of_elaboration();
    if (this.wr == null) begin
      `uvm_fatal ("VIF_ERROR", "Interface not connected");
    end
  endfunction
  
  virtual task run();
    `uvm_info("TRACE", "Driver sequence test", UVM_MEDIUM)
    
    fork
      $display("sa = %0d", wr.vif.sa);
      $display("da = %0d", wr.vif.da);
    join
    
    forever 
      begin
        seq_item_port.get_next_item(req);
        req.print();
        seq_item_port.item_done();
      end
  endtask
endclass    




class router_env extends uvm_env;
  `uvm_component_utils(router_env)
   switch_item_sequencer sis;
   driver drv;
   
   function new(string name="env", uvm_component parent=null);
     super.new(name, parent);
   endfunction
  
   virtual function void build();
     super.build();
     sis = switch_item_sequencer::type_id::create("sis",this);
     drv = driver::type_id::create("drv",this);
   endfunction

  virtual function void connect();
     drv.seq_item_port.connect(sis.seq_item_export);
  endfunction
endclass
    



class test extends uvm_test;
  wrapper wr;
  router_env env;
  `uvm_component_utils(test)
  
  function new(string name = "test", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual function void build();
    super.build();
    wr = new("wr", top.vif);
    env = router_env::type_id::create("env", this);
    set_config_object("env.*", "wr", wr, 0);
    set_config_string("*.sis", "default_sequence", "switch_item_sequence");
  endfunction
endclass


class switch_item_sequence extends uvm_sequence#(switch_item);
  `uvm_sequence_utils(switch_item_sequence,switch_item_sequencer)
  
  function new(string name = "switch_item_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    begin
      `uvm_info("", "Give Seq to sequencer", UVM_LOW);
      repeat(15) begin
        `uvm_do(req);
      end
      `uvm_do_with(req, {sa==5;})
    end
  endtask
endclass


module top;
  import uvm_pkg::*;
  intf vif();
  
  always 
    #3 vif.clk = ~vif.clk;
  
  initial begin
    vif.clk = 0;
    run_test("test");
  end
  
  initial begin
    @(vif.clk);
    	vif.sa = 5;
    @(vif.clk);
    	vif.da = 6;
    @(vif.clk);
    	vif.sa = 7;
    @(vif.clk);
    	vif.da = 10;
    @(vif.clk);
    	vif.sa = 12;
    @(vif.clk);
    	vif.da = 13;
    @(vif.clk);
    	vif.sa = 15;
    @(vif.clk);
    	vif.da = 17;
    @(vif.clk);
    	vif.sa = 19;
    @(vif.clk);
    	vif.da = 21;
    @(vif.clk);
    	vif.sa = 22;
    @(vif.clk);
    	vif.da = 33;
    @(vif.clk);
    	vif.sa = 35;
    @(vif.clk);
    	vif.da = 47;
  end
endmodule
