# Makefile for Memory - Regression Testing 
RTL= ../rtl/*.v
work= work #library name
COVOP= -dbg -coverage sb
SVTB1= ../env/cif.sv ../env/top.sv
INC = +incdir+../env +incdir+../test
SVTB2 = ../env/pkg.sv
TEST = ../test/test.sv
TEST1 = ../test/test1.sv
TEST2 = ../test/test2.sv
VSIMOPT= +access +r  
VSIMCOV= -acdb -acdb_cov sbf 
VSIMBATCH= -c -acdb_file mem_cov.acdb -do "run -all; exit"
VSIMBATCH1 = -c -acdb_file mem_cov1.acdb -do "log -rec *;run -all;exit"
VSIMBATCH2 = -c -acdb_file mem_cov2.acdb -do "log -rec *;;run -all;exit"
VSIMBATCH3 = -c -acdb_file mem_cov3.acdb -do "log -rec *;;run -all;exit"
VSIMBATCH4 = -c -acdb_file mem_cov4.acdb -do "log -rec *;;run -all;exit"
VSIMBATCH5 = -c -acdb_file mem_cov5.acdb -do "log -rec *;;run -all;exit"
VSIMBATCH6 = -c -acdb_file mem_cov6.acdb -do "log -rec *;;run -all;exit"
VSIMBATCH7 = -c -acdb_file mem_cov7.acdb -do "log -rec *;;run -all;exit"
VSIMBATCH8 = -c -acdb_file mem_cov8.acdb -do "log -rec *;;run -all;exit"
VSIMBATCH9 = -c -acdb_file mem_cov9.acdb -do "log -rec *;;run -all;exit"


html:
	firefox mem_cov1.html

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(COVOP) $(RTL) $(SVTB2) $(SVTB1) $(INC)
	
run_sim:
	vsim $(VSIMBATCH1) $(VSIMOPT) $(VSIMCOV) -l test1_sim.log -sv_seed random  work.top +TEST1  
	vsim -c -do "acdb report -db mem_cov1.acdb -html -o mem_cov1.html;exit" 
clean:
	rm -rf *.acdb *.cfg *.log
	clear

TC2:
	vsim  $(VSIMBATCH2) $(VSIMOPT) $(VSIMCOV)  -sva -sv_seed random -l test2_sim.log work.top +TEST2
	vsim -c -do "acdb report -db mem_cov2.acdb -html -o mem_cov2.html;exit" 
	
TC3:
	vsim  $(VSIMBATCH3) $(VSIMOPT) $(VSIMCOV) -sv_seed random -l test3_sim.log work.top +TEST3
	vsim -c -do "acdb report -db mem_cov3.acdb -html -o mem_cov3.html;exit" 
	
TC4:
	vsim  $(VSIMBATCH4) $(VSIMOPT) $(VSIMCOV) -sv_seed 427506933 -l test4_sim.log work.top +TEST4
	vsim -c -do "acdb report -db mem_cov4.acdb -html -o mem_cov4.html;exit" 
	
TC5:
	vsim  $(VSIMBATCH5) $(VSIMOPT) $(VSIMCOV) -sv_seed 386229417 -l test5_sim.log work.top +TEST5
	vsim -c -do "acdb report -db mem_cov5.acdb -html -o mem_cov5.html;exit" 


TC6:
	vsim  $(VSIMBATCH6) $(VSIMOPT) $(VSIMCOV) -sv_seed 749764269 -l test6_sim.log work.top +TEST6
	vsim -c -do "acdb report -db mem_cov6.acdb -html -o mem_cov6.html;exit" 

TC7:
	vsim  $(VSIMBATCH7) $(VSIMOPT) $(VSIMCOV) -sv_seed 198889551 -l test7_sim.log work.top +TEST7
	vsim -c -do "acdb report -db mem_cov7.acdb -html -o mem_cov7.html;exit" 

TC8:
	vsim  $(VSIMBATCH8) $(VSIMOPT) $(VSIMCOV) -sv_seed 198083824 -l test8_sim.log work.top +TEST8
	vsim -c -do "acdb report -db mem_cov8.acdb -html -o mem_cov8.html;exit" 

TC9:
	vsim  $(VSIMBATCH9) $(VSIMOPT) $(VSIMCOV) -sv_seed 198083824 -l test8_sim.log work.top +TEST9
	vsim -c -do "acdb report -db mem_cov9.acdb -html -o mem_cov9.html;exit" 

report:
	vsim -c -do "acdb merge -cov sbf -i mem_cov1.acdb -i mem_cov2.acdb -i mem_cov3.acdb -o mem_cov_merged.acdb;exit"
	

rep:
	vsim -c -do "acdb report -db mem_cov_merged.acdb -html -o mem_cov_merged.html;exit" 
	

regress: clean run_test TC2 TC3 TC4 report rep cov

cov:
	firefox mem_cov_merged.html &


gui:
	vsim& 
run_test: clean sv_cmp run_sim
	
	

