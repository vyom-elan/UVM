program automatic simple_test;
  import uvm_pkg::*;
  class t1 extends uvm_test;
    `uvm_component_utils(t1)
    function new(string name="Hello World 1",uvm_component parent=null);
      super.new(name, parent);
    endfunction 
    virtual task run();
      `uvm_info("Normal","t1",UVM_MEDIUM);
    endtask
  endclass
  class testcase_2 extends uvm_test;
    `uvm_component_utils(testcase_2)
    function new(string name="Hello world 2",uvm_component parent=null);
      super.new(name, parent);
    endfunction
    virtual task run();
      `uvm_info("Normal","t2",UVM_MEDIUM);
    endtask
  endclass
  class t3 extends uvm_test;
    `uvm_component_utils(t3)
    function new(string name="Hello world 3",uvm_component parent=null);
      super.new(name, parent);
    endfunction
    
    virtual task run();
      `uvm_info("Normal","t3",UVM_MEDIUM);
    endtask
  endclass
  initial 
    run_test();
endprogram
