class mytest_1 extends uvm_test;
  environment env;
  `uvm_component_utils(mytest_1) 
  function new(string name="mytest_1",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  virtual function void build();
    super.build();
    env = environment::type_id::create("env",this);
  endfunction
  virtual task run();
  endtask   
endclass
