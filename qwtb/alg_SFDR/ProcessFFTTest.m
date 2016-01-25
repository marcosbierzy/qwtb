function testresults = ProcessFFTTest(dsc)

%% screensize = get(0,'ScreenSize');
%% 
%% hFFT_Test_window = figure('Visible','on',...
%%                               'Position', [screensize(3)*0.25 screensize(4)*0.25 screensize(3)*0.5 screensize(4)*0.5]',...
%%                               'Name','FFT Test',...
%%                               'NumberTitle','off');
%%                           
%% hTextTitle = uicontrol ('Style','text',...
%%                            'String','Frequency-domain analysis',...
%%                            'Units','normalized',...
%%                            'Position',[0.3 0.9 0.4 0.04],...
%%                            'HorizontalAlignment','center',...
%%                            'FontWeight','bold',...
%%                            'BackgroundColor',[0.8 0.8 0.8]);    
%%                                                                             
%% hTextWindowing = uicontrol('Style','text',...
%%                            'String','Window: ',...
%%                            'Units','normalized',...
%%                            'Position',[0.65 0.8 0.1 0.04],...
%%                            'HorizontalAlignment','left',...
%%                            'BackgroundColor',[0.8 0.8 0.8]);    
%%                        
%% hPopupMenuWindowing = uicontrol('Style','popupmenu',...
%%                                 'Units','normalized',...
%%                                 'Position',[0.75 0.82 0.15 0.04],...
%%                                 'HorizontalAlignment','right',...
%%                                 'String',{'None (Rect)','Hann','Blackman','Blackman-Harris'},...
%%                                 'Callback',@Windowing_callback);                       
%% 
%% hTextSFDR = uicontrol('Style','text',...
%%                            'String','SFDR: ',...
%%                            'Units','normalized',...
%%                            'Position',[0.1 0.8 0.2 0.04],...
%%                            'HorizontalAlignment','left',...
%%                            'FontWeight','bold',...
%%                            'BackgroundColor',[0.8 0.8 0.8]);
%%                        
%% hTextSFDRValue = uicontrol('Style','text',...
%%                            'String','NaN',...
%%                            'Units','normalized',...
%%                            'Position',[0.3 0.8 0.1 0.04],...
%%                            'HorizontalAlignment','right',...
%%                            'FontWeight','bold',...
%%                            'BackgroundColor',[0.8 0.8 0.8]);
%% 
%% hTextSFDRdBFSValue = uicontrol('Style','text',...
%%                            'String','NaN',...
%%                            'Units','normalized',...
%%                            'Position',[0.3 0.75 0.1 0.04],...
%%                            'HorizontalAlignment','right',...
%%                            'FontWeight','bold',...
%%                            'BackgroundColor',[0.8 0.8 0.8]);
%% 
%% hTextComponent =   uicontrol('Style','text',...
%%                         'String','Component:',...
%%                         'Units','normalized',...
%%                         'Position',[0.1 0.7 0.1 0.04],...
%%                         'HorizontalAlignment','left',...
%%                         'FontWeight','bold',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);
%%                     
%% hTextFrequency =   uicontrol('Style','text',...
%%                         'String','Frequency (f/fs):',...
%%                         'Units','normalized',...
%%                         'Position',[0.2 0.7 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'FontWeight','bold',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);
%%                     
%% hTextAmpRelFS =   uicontrol('Style','text',...
%%                         'String','Amplitude (rel. FS):',...
%%                         'Units','normalized',...
%%                         'Position',[0.45 0.7 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'FontWeight','bold',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);
%% 
%% hTextAmpRelCarrier =   uicontrol('Style','text',...
%%                         'String','Amplitude (rel. carrier):',...
%%                         'Units','normalized',...
%%                         'Position',[0.7 0.7 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'FontWeight','bold',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                        
%%                                                 
%% hTextCarrier =  uicontrol('Style','text',...
%%                         'String','Carrier: ',...
%%                         'Units','normalized',...
%%                         'Position',[0.1 0.65 0.2 0.04],...
%%                         'HorizontalAlignment','left',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%% 
%% hText_2nd_harm =  uicontrol('Style','text',...
%%                         'String','2nd harmonic: ',...
%%                         'Units','normalized',...
%%                         'Position',[0.1 0.6 0.2 0.04],...
%%                         'HorizontalAlignment','left',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%% 
%% 
%% hText_3rd_harm =  uicontrol('Style','text',...
%%                         'String','3rd harmonic: ',...
%%                         'Units','normalized',...
%%                         'Position',[0.1 0.55 0.2 0.04],...
%%                         'HorizontalAlignment','left',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                     
%% hText_4th_harm =  uicontrol('Style','text',...
%%                         'String','4th harmonic: ',...
%%                         'Units','normalized',...
%%                         'Position',[0.1 0.5 0.2 0.04],...
%%                         'HorizontalAlignment','left',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%% 
%% hText_5th_harm =  uicontrol('Style','text',...
%%                         'String','5th harmonic: ',...
%%                         'Units','normalized',...
%%                         'Position',[0.1 0.45 0.2 0.04],...
%%                         'HorizontalAlignment','left',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                     
%% hTextCarrierFreqValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.2 0.65 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                         
%% hText2thHarmFreqValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.2 0.6 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%% 
%% hText3thHarmFreqValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.2 0.55 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                     
%% hText4thHarmFreqValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.2 0.5 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                     
%% hText5thHarmFreqValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.2 0.45 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                     
%% hTextCarrierAmpFSValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.45 0.65 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                         
%% hText2thHarmAmpFSValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.45 0.6 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%% 
%% hText3thHarmAmpFSValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.45 0.55 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                     
%% hText4thHarmAmpFSValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.45 0.5 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                     
%% hText5thHarmAmpFSValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.45 0.45 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%% 
%% hTextCarrierAmpCValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.7 0.65 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                         
%% hText2thHarmAmpCValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.7 0.6 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%% 
%% hText3thHarmAmpCValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.7 0.55 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                     
%% hText4thHarmAmpCValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.7 0.5 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%%                     
%% hText5thHarmAmpCValue =  uicontrol('Style','text',...
%%                         'String','NaN',...
%%                         'Units','normalized',...
%%                         'Position',[0.7 0.45 0.2 0.04],...
%%                         'HorizontalAlignment','right',...
%%                         'BackgroundColor',[0.8 0.8 0.8]);                       
%% 
%% hAxesSpectrum = axes ('Position',[0.1 0.1 0.8 0.3]);

%Initializing state variables
NUM_OF_HARMONICS = 5;
N_FFT = 1e6; %length of FFT
datavect = dsc.data(:) - mean(dsc.data); %AC-coupling and forcing column vectors
N = length(datavect);
%% set(hPopupMenuWindowing,'Value',3); %default window is Blackman window
window_vector = blackman(N)/sum(blackman(N));
warning_displayed = 0;
NoB = dsc.NoB;
ProcessData;

    function ProcessData
        windowed_data = datavect.*window_vector;
        windowed_data = windowed_data(:);
        spect = abs(fft(windowed_data,N_FFT));
        half_side = spect(1:floor(length(spect)/2)+1);
        [amp_max, index_max] = max(half_side);
        rel_freq_max = (index_max-1)/N_FFT; %estimated relative frequency of the 1st harmonic
        %Amplitude of carrier relative to full scale:
        %Windows are normalized (sum(win) == 1), thus 1/N is implicitly done by the windowing
        carrier_to_FS = 2*amp_max/((2^NoB)/2);        
        
        H = [1;zeros(NUM_OF_HARMONICS-1,1)];
        indeces = [index_max; zeros(NUM_OF_HARMONICS-1,1)];
        %Calculating harmonics relative to carrier
        for k = 2:NUM_OF_HARMONICS
            %k. harmonic:
            indeces(k) = 1 + round(k*(rel_freq_max*N_FFT));
            if (indeces(k) <= length(half_side)) %k-th harmonic is within the Nyquist frequency
                H(k) = half_side(indeces(k))/half_side(indeces(1));
            else
                H(k) = NaN;
            end
        end
        %Calculating SFDR:
        max_harmonic_distortion = 20*log10(max(H(2:end)));
        %Discarding main lobe from spourious components:
        %Windows' main lobe is no more than DFT bins wide, thus
        %N_FFT/N*5 samples shall be discarded to calculate SFDR
        max_spur = max([half_side(1:index_max-round(5*N_FFT/N));half_side(index_max+round(5*N_FFT/N):end)]);
        max_spourious_component = 20*log10(max_spur/half_side(indeces(1)));
        %Without windowing, SFDR can be misleading:
        if 2==1 %% if (get(hPopupMenuWindowing,'Value')==1) %rectangular window is used
            SFDR = max_harmonic_distortion;
        else
            SFDR = max([max_harmonic_distortion,max_spourious_component]);
        end
        SFDRdBc = (-1)*SFDR; %SFDR is nonnegative
        SFDRdBFS = SFDRdBc + (-1)*20*log10(carrier_to_FS); %SFRD dBFS

        %% axes(hAxesSpectrum);
        %% half_side_reduced = half_side(2:end)/half_side(indeces(1));
        %% plot((2:floor(N_FFT/2)+1)/N_FFT,20*log10(half_side_reduced));
        %% axis([0 0.5 -150 10]);
        %% xlabel('f/fs');
        %% ylabel('Amplitude [dBc]');
        %% %Updating display:
        %% set (hTextCarrierFreqValue,'String',sprintf('%1.4e',rel_freq_max));
        %% set (hText2thHarmFreqValue,'String',sprintf('%1.4e',2*rel_freq_max));
        %% set (hText3thHarmFreqValue,'String',sprintf('%1.4e',3*rel_freq_max));        
        %% set (hText4thHarmFreqValue,'String',sprintf('%1.4e',4*rel_freq_max));        
        %% set (hText5thHarmFreqValue,'String',sprintf('%1.4e',5*rel_freq_max));
        %% 
        %% set (hTextCarrierAmpFSValue,'String',sprintf('%2.2f dBFS',20*log10(carrier_to_FS)));
        %% set (hText2thHarmAmpFSValue,'String',sprintf('%2.2f dBFS',20*log10(H(2)) + 20*log10(carrier_to_FS)));
        %% set (hText3thHarmAmpFSValue,'String',sprintf('%2.2f dBFS',20*log10(H(3)) + 20*log10(carrier_to_FS)));        
        %% set (hText4thHarmAmpFSValue,'String',sprintf('%2.2f dBFS',20*log10(H(4)) + 20*log10(carrier_to_FS)));        
        %% set (hText5thHarmAmpFSValue,'String',sprintf('%2.2f dBFS',20*log10(H(5)) + 20*log10(carrier_to_FS)));        
        %% 
        %% set (hTextCarrierAmpCValue,'String',sprintf('%2.2f dBc',0));
        %% set (hText2thHarmAmpCValue,'String',sprintf('%2.2f dBc',20*log10(H(2))));
        %% set (hText3thHarmAmpCValue,'String',sprintf('%2.2f dBc',20*log10(H(3))));        
        %% set (hText4thHarmAmpCValue,'String',sprintf('%2.2f dBc',20*log10(H(4))));        
        %% set (hText5thHarmAmpCValue,'String',sprintf('%2.2f dBc',20*log10(H(5))));        
        %% 
        %% set (hTextSFDRValue,'String',sprintf('%2.2f dBc  ',SFDRdBc));
        %% set (hTextSFDRdBFSValue,'String',sprintf('%2.2f dBFS',SFDRdBFS));
        
        %Warning in case of overdriven ADC
        if ((carrier_to_FS > 1) && (~warning_displayed))
            warndlg({'The excitation signal seemingly overdrives';...
                'the ADC under test. Please consider it evaluating the value of SFDR';...
                'relative to full scale (dbFS) and relative to carrier (dBc).';...
                'Also note that the harmonic components';...
                'can be as result of nonlinearity as result of saturation.'},...
                'Warning on overdrive');
            warning_displayed = 1;
        end
    end

%% %%%%%%%%%Adding evaluation result to results cell array:
%% try
%%     testresults = evalin('base','adctest_process_results');
%%     res_len = size(testresults,1);
%%     %Search for existing results block
%%     existings_index = 0;
%%     for k = 1:res_len        
%%         if strcmpi(dsc.model,testresults{k,1}.DUT.model) ...
%%                 && strcmpi(dsc.serial,testresults{k,1}.DUT.serial)...
%%                 && (dsc.channel == testresults{k,1}.DUT.channel)...
%%                 && (dsc.NoB == testresults{k,1}.DUT.NoB)
%%             existings_index = k;                    
%%         end
%%     end    
%%     if (existings_index ~= 0) %existing result struct
%%         %Adding new results:
%%         testresults{existings_index,1}.FFT.SFDRdBc = SFDRdBc;
%%         testresults{existings_index,1}.FFT.SFDRdBFS = SFDRdBFS;                
%%     else %new result struct shall be added
%%         testresults{res_len + 1,1}.DUT.model = dsc.model;
%%         testresults{res_len + 1,1}.DUT.serial = dsc.serial;
%%         testresults{res_len + 1,1}.DUT.channel = dsc.channel;
%%         testresults{res_len + 1,1}.DUT.NoB = dsc.NoB;
%%         %Adding new results:
%%         testresults{res_len + 1,1}.FFT.SFDRdBc = SFDRdBc;
%%         testresults{res_len + 1,1}.FFT.SFDRdBFS = SFDRdBFS;        
%%     end
%%     %updating adctest_process_results
%%     assignin ('base','adctest_process_results',testresults);
%%         
%% catch
    %If testresults global variable does not exist:
    testresults = cell(1,1); %creating new cell array for testresults
    testresults{1,1}.DUT.model = dsc.model;
    testresults{1,1}.DUT.serial = dsc.serial;
    testresults{1,1}.DUT.channel = dsc.channel;
    testresults{1,1}.DUT.NoB = dsc.NoB;
    %Adding new results:
    testresults{1,1}.FFT.SFDRdBc = SFDRdBc;
    testresults{1,1}.FFT.SFDRdBFS = SFDRdBFS;        
%%     assignin ('base','adctest_process_results',testresults);
%% end
%%%%%%End of adding evaluatin results to cell array%%%%%%%%%%

    function Windowing_callback(source,eventdata)
        menuval = get(source,'Value');
        if (menuval == 1) %Rectangular window
            window_vector = ones(N,1)/sum(ones(N,1));
        elseif (menuval == 2) %Hann window
            window_vector = hann(N)/sum(hann(N)); 
        elseif (menuval == 3) %Blackman window
            window_vector = blackman(N)/sum(blackman(N));
        elseif (menuval == 4) %3-term Blackman-Harris window
            window_vector = BH3Win(N)/sum(BH3Win(N));
        end
        ProcessData;
    end
                        
end
