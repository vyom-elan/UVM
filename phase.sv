class uvm_user_phase extends uvm_task_phase;
  protected function new(string name = "post_run");
    super.new(name);
  endfunction
  static const string type_name = "uvm_user_phase";
  virtual function string get_type_name();
    return type_name;
  endfunction
  virtual task exec_task(uvm_component comp, uvm_phase phase);
    my_test TEST;
    if($case(TEST, comp))
      TEST.post_run_phase(phase);
  endtask
  local static uvm_user_phase m_inst;
  static function uvm_user_phase get();
    if(m_inst == null)
      m_inst = new;
    return m_inst;
  endfunction
endclass

class my_test extends uvm_test;
  virtual function void add_my_phase();
    uvm_domain dm = uvm_domain::get_common_domain();
    uvm_phase ph = dm.find(uvm_connect_phase::get());
    dm.add (uvm_user_phase::get(), null, ph, null);
  endfunction
  function new (string name = "my_test", uvm_component parent);
    super.new (name, parent);
    add_my_phase();
  endfunction
  virtual task user_phase (user_phase phase);
    `uvm_info ("TEST", $sformatf("In %s phase", phase.get_name()), UVM_MEDIUM)
  endtask
endclass
