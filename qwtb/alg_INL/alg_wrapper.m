function dataout = alg_wrapper(datain, calcset)
% Part of QWTB. Wrapper script for algorithm INL.
%
% See also qwtb

% Format input data --------------------------- %<<<1
% INL definition is:
% function INL = ProcessHistogramTest(dsc,display_settings,varargin)
dsc.data = datain.y.v;
dsc.NoB = datain.bits.v;

dsc.name = 'tst';
dsc.comment = {['comment']};
dsc.model = 'MatlabSim';
dsc.serial = 'N/A';
dsc.channel = 1;
dsc.simulation = 1;

display_settings.results_win = 0;
display_settings.summary_win = 0;
display_settings.warning_dialog = 0;

% Call algorithm ---------------------------  %<<<1
INL = ProcessHistogramTest(dsc,display_settings);

% Format output data:  --------------------------- %<<<1
% INL definition is:
% function INL = ProcessHistogramTest(dsc,display_settings,varargin)
dataout.INL.v = INL;
dataout.INL.u = 0;
dataout.INL.d = 0;

end % function

% vim settings modeline: vim: foldmarker=%<<<,%>>> fdm=marker fen ft=octave textwidth=80
