class producer extends uvm_component;
  `uvm_component_utils(producer)
  uvm_analysis_port#(transaction)put_port;
  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  virtual function void build();
    super.build;
    put_port = new("put_port",this);
  endfunction
  virtual task run();
    repeat(2) begin
    transaction tr = transaction::type_id::create("tr",this);
    tr.randomize();
    put_port.write(tr);
    end
  endtask
endclass
