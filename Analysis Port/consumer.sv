class consumer extends uvm_component;
  transaction tr;
  `uvm_component_utils(consumer)
  uvm_analysis_imp #(transaction,consumer)put_export;
  function new(string name = "consumer", uvm_component parent = null);
    super.new(name, parent);
  endfunction 
  virtual function void build();
  super.build();
  put_export = new ("put_export",this);
  endfunction 
  virtual function void write(transaction tr);
    $display("recieved value = %0d",tr.sa);
    $display("recieved value = %0d",tr.da);
    $display("recieved value = %0p",tr.payload);
  endfunction
endclass  
