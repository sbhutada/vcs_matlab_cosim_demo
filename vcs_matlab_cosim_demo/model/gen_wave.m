%
% Copyright 2016 The MathWorks, Inc.
%

function [re,im] = gen_wave
    %#codegen
    Fs = 800; L = 64;
    t = (0:L-1)/Fs;
    x = sin(2*pi*250*t) + 0.75*cos(2*pi*340*t);
    re = x;  
    im = zeros(1,L);
    re = fi(re,1,16,13);
    im = fi(im,1,16,13);
end

