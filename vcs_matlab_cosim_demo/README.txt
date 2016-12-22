# In this demo we will see how to bring in MATLAB models
# to help generate testbench stimulus
# and also use as a predictor model within a UVM testbench.

# All the design code is in the DUT folder and listed in DUT.f.
# All the testbench code is in the TB folder and listed in TB.f.

# All of the matlab code is within generic model folder.
# One has to also provide a build_dpi.m file.
# This file lists the matlab function name and argument types. 
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
vc_elab -t=top -d
vc_sim -m=../model -t=fft_test_wave -d

# Using the debugger
# Set a breakpoint right before UVM run phase
#   Select uvm, phase view
#   Select run, add breakpoint
# Run to load UVM components and view the hierarchy
#   Select Components tab - Show the UVM Component hierarchy
#   Select Objects tab - Show the UVM Object hierarchy
# Let's look at the MATLAB DPI calls
#   Select Scoreboard - select Method write_... - set breakpoint at DPI
#   From Components tab - select sequence - select Method body - set brakpoint at DPI
# Plot the DUT signals
#   Select dut from the hieararchy - add to wave
# Run to the Breakpoint in scoreboard DPI
# Turn on the Source annotation
# Next
# Next
# Next
# Review the Transactions
#   Tools->Transaction Browser
#   Click on the button to attach transaction browser to the waveform window
#   Click the button for the transaction hierarchy and navigate under env to sequencer and monitor
#   Double clicking them will show the transaction plot
#   Click on the botton to look at the values for a transaction selected
# Clicking on the transaction will show the values and the start/end of the transaction on the waveform



