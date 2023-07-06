program automatic simple_test;
import uvm pkg::*;
class hello_world extends uvm_test;
	`uvm_component_utils(hello_world)
  function new(string name= "Hi", uvm_component_parent= null);
		super.new(name,parent);
	endfunction
	virtual task run();
		`uvm_info("Normal","Hello World!", UVM_MEDIUM);
	endtask
endclass
initial
	run_test();
endprogram
