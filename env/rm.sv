class rm;

static bit [3:0]c;
trans data;
mailbox #(trans) mon2rm;
mailbox #(trans) rm2sb;

	function new(mailbox #(trans) mon2rm,
	mailbox #(trans) rm2sb
	);
		this.mon2rm=mon2rm;
		this.rm2sb=rm2sb;
	endfunction

	virtual task fun_counter(trans data);
	if(data.reset)
		c<=0;
	else begin
		if(data.load)
			c<=data.data_in;
                else
			begin
			case(data.ud)
				1: begin 
					c<=c+1;
					if(c==15)
					c<=0; end
				0: begin 
					c<=c-1;
					if(c==0)
					c<=15; end
			endcase
			end
		end
	endtask
	
	virtual task start;
		fork
			forever begin
			mon2rm.get(data);
			fun_counter(data);
                        data.data_out=c;
			rm2sb.put(data); end
		join_none
	endtask
endclass
