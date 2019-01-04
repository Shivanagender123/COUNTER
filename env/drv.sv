class drv;

virtual cif.DRV_MP drv_if;
trans data2duv;
mailbox #(trans) gen2drv;
	function new(virtual cif.DRV_MP drv_if,
			mailbox #(trans) gen2drv);
		this.drv_if=drv_if;
		this.gen2drv=gen2drv;
	endfunction: new

	virtual task drive();
		@(drv_if.drv_cb);
                  drv_if.drv_cb.reset<=data2duv.reset;
		  drv_if.drv_cb.load<=data2duv.load;
		  drv_if.drv_cb.ud<=data2duv.ud;
		  drv_if.drv_cb.data_in<=data2duv.data_in;     	 			
	endtask : drive

	 virtual task reset_duv();
		@(drv_if.drv_cb);
                  drv_if.drv_cb.reset<=1;
		@(drv_if.drv_cb);  
		  drv_if.drv_cb.reset<=0;	 			
	endtask
      
        virtual task start;
		fork
			begin
			reset_duv;
			forever begin
			gen2drv.get(data2duv);
			drive; end
			end
		join_none
	endtask
endclass
			

