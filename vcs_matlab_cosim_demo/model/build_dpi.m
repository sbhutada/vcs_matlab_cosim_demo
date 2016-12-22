%
% Copyright 2016 The MathWorks, Inc.
%

% Build the checker, specifying input data types
dpigen -args {int16(ones(1,64)),int16(ones(1,64)),int16(ones(1,64)),int16(ones(1,64))} fft_checker

% Build the wave input stimulus
dpigen gen_wave

quit
