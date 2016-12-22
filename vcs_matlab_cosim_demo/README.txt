# In this demo we will see how to bring in MATLAB models
# to help generate testbench stimulus
# and also use as a predictor model within a UVM testbench.

# All of the matlab code is within generic model folder.
# One has to also provide a build_dpi.m file that captures
# the matlab function name and argument types. 
# gen_wave is used to generate a stimulus sequence
# fft_checker is used as a predictor model

# This package also compes with "VC Lite".
# This contains simple compile/run commands.
set path = ( ../vc_lite/bin $path )

# Start with a clean run folder
cd run
vc_clean

# Prepare MATLAB model for importing into VCS
vc_matlab ../model

# DUT compile
vc_vlog -F ../dut/DUT.f

# UVM Testbench compile
vc_uvm -F ../tb/TB.f

# elaborate and simulate in debug mode (-d)
vc_elab -t top -d
vc_sim -m=../model -t=fft_test_wave -d

# DEMO Verdi
Select uvm, phase view
Select run, add breakpoint
Run to load UVM components
Select Components tab - Show the UVM Component hierarchy
Select Objects tab - Show the UVM Object hierarchy
Select Scoreboard - select Method write_... - set breakpoint at DPI
From Components tab - select sequence - select Method body - set brakpoint at DPI
Select dut from the hieararchy - add to wave
Run
Break into scoreboard DPI
Source annotation
Next
Next
Next


