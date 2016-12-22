%
% Copyright 2016 The MathWorks, Inc.
%

function result = fft_checker(fftin_re, fftin_im,fftout_re, fftout_im)
%#codegen

% First convert FFT input to double
fftin_c = complex( double(fftin_re), double(fftin_im) );

% Calculate FFT
fft_exp = fft(fftin_c)/64;

% Calculate error
fftoutc = complex( double(fftout_re), double(fftout_im) );
error = fft_exp - fftoutc;

% Calculate normalized rms of error
result = real ( rms(error)/rms(fftoutc) );

end

