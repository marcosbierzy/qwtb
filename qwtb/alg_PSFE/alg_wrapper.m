function dataout = alg_wrapper(datain, calcset) %<<<1
% Part of QWTB. Wrapper script for algorithm PSFE.
%
% See also qwtb

% Format input data --------------------------- %<<<1
% PSFE definition is: function [fa A ph] = PSFE(Record,Ts,init_guess)
% Record     - sampled input signal
% Ts         - sampling time (in s)
% init_guess: 0 - FFT max bin, 1 - IPDFT, negative initial frequency estimate

% Call algorithm ---------------------------  %<<<1
Record = datain.y.v;
Ts = datain.t.v(2) - datain.t.v(1);
init_guess = 1;

% call PSFE:  %<<<1
[fa A ph] = PSFE(Record,Ts,init_guess);

% Format output data:  --------------------------- %<<<1
% PSFE definition is: function [fa A ph] = PSFE(Record,Ts,init_guess)
% fa     - estimated signal's frequency
% A      - estimated signal's amplitude
% ph     - estimated signal's phase

dataout.f.v = fa;
dataout.f.u = 0;
dataout.f.d = 0;

dataout.A.v = A;
dataout.A.u = 0;
dataout.A.d = 0;

dataout.ph.v = ph;
dataout.ph.u = 0;
dataout.ph.d = 0;

end % function

% vim settings modeline: vim: foldmarker=%<<<,%>>> fdm=marker fen ft=octave textwidth=80