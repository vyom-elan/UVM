typedef enum {OKAY, EXOKAY, SLVERR, DECERR} resp_type;
class driver_callback extends uvm_callback; 
  `uvm_object_utils(driver_callback)
  function new(string name = "driver_callback");
    super.new(name);
  endfunction
  virtual task update_resp(ref resp_type resp);
  endtask
endclass
class slave_driver extends uvm_component;
  resp_type resp;
  `uvm_component_utils(slave_driver)
  `uvm_register_cb(slave_driver,driver_callback)
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  task run_phase(uvm_phase phase);
    repeat(2) begin 
      std::randomize(resp) with { resp == OKAY;};
      `uvm_do_callbacks(slave_driver,driver_callback,update_resp(resp));
      `uvm_info("DRIVER",$sformatf("Generated response is %s",resp.name()),UVM_LOW);
    end  
  endtask
endclass
class slave_env extends uvm_env;
  slave_driver driver;
  `uvm_component_utils(slave_env)
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver = slave_driver::type_id::create("driver", this);
  endfunction
endclass

class basic_test extends uvm_test;
  slave_env env;
  `uvm_component_utils(basic_test)
  function new(string name = "basic_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = slave_env::type_id::create("env", this);
  endfunction
endclass
class slv_error_callback extends driver_callback;
  `uvm_object_utils(slv_error_callback)
  function new(string name = "slv_error_callback");
    super.new(name);
  endfunction 
  task update_resp(ref resp_type resp);
    resp = SLVERR;
  endtask
endclass
class slv_err_test extends basic_test;
  slv_error_callback err_callback;
  `uvm_component_utils(slv_err_test)
  function new(string name = "slv_err_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    err_callback = slv_error_callback::type_id::create("err_callback", this);   
    uvm_callbacks#(slave_driver,driver_callback)::add(env.driver,err_callback);
  endfunction
endclass

program testbench_top;
initial begin
    run_test();
  end  
endprogram
