import pkg::*;
class test;

virtual cif.DRV_MP drv_if;
virtual cif.WRMON_MP wrmon_if;
virtual cif.RDMON_MP rdmon_if;

env e;

	function new (virtual cif.DRV_MP drv_if,
	virtual cif.WRMON_MP wrmon_if,
	virtual cif.RDMON_MP rdmon_if
	);
		this.wrmon_if=wrmon_if;
		this.rdmon_if=rdmon_if;
		this.drv_if=drv_if;
		e=new(drv_if,wrmon_if,rdmon_if);
	endfunction

	task build_run();
           if($test$plusargs("TEST1"))
              begin
		e.build;
		e.run;
		$finish;
              end
	endtask
endclass
	
