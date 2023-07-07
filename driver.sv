class driv extends uvm_driver;
	`uvm_component_utils(my_driver)
	function new(string name="driver" uvm_component parent =null);
		super.new(name,parent);
	endfunction
endclass

