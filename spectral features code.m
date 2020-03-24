folder = fullfile('Put the link of folder containing samples');
ADS = audioDatastore(folder);
sname='Sheet1';
startingColumn1='A';
startingColumn2='O';
startingColumn3='AC';
startingColumn4='AD';
startingColumn5='AE';
startingColumn6='AF';
startingColumn7='AG';
startingColumn8='AH';
startingColumn9='AI';
startingColumn10='AJ';
startingColumn11='AK';
startingColumn12='AL';
startingColumn13='AM';
startingColumn14='AN';
startingColumn15='AO';
nextRow=1;
% i=1;
filename = 'put name of file to write the extracted features';
% i = 1;

while hasdata(ADS)
    
    x = read(ADS);
%     [x,fs]=audioread(x);
    fprintf('Fraction of files read: %.2f\n',progress(ADS))

%    Mention the sampling rate of your samples;
fs=96000;
%******** MFCC *****************
[coeffs,delta,deltaDelta,loc] = mfcc(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',(fs*0.02));
% [coeffs,delta,deltaDelta,loc] = mfcc(x,fs);
% % Normalization w.r.t Mean and Standard deviation
M1=mean(coeffs);
% S1=std(coeffs);
% N1 = (coeffs - M1)./S1;
% SF=mean(Nflux)
range1=sprintf('%s%d',startingColumn1,nextRow);
% writematrix(coeffs,filename,'Sheet',sname,'Range',range1);
writematrix(M1,filename,'Sheet',sname,'Range',range1);
% xlswrite(filename,M1,sname,range1);
% % Normalization w.r.t Mean and Standard deviation
% S1 = std(coeffs);
% N1 = (coeffs - M1) ./ S1
% SF=mean(Nflux)

%******** GTCC *****************
[coeffs1,delta1,deltaDelta1,loc1] = gtcc(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',(fs*0.02));
% [coeffs1,delta1,deltaDelta1,loc1] = gtcc(x,fs);
M2 = mean(coeffs1);
% S2=std(coeffs1);
% N2 = (coeffs1 - M2)./S2;
range2=sprintf('%s%d',startingColumn2,nextRow);
% writematrix(coeffs1,filename,'Sheet',sname,'Range',range2);
writematrix(M2,filename,'Sheet',sname,'Range',range2);

%******** Spectral Flux*****************
[s,cf,~] = melSpectrogram(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',0.02);
% [s,cf,~] = melSpectrogram(x,fs);
flux = spectralFlux(s,cf);
M3 = mean(flux);
% S3 = std(flux);
% N3 = (flux - M3)./S3;
% index2=14+1;
% startingColumn2=excel_column(index2)
range3=sprintf('%s%d',startingColumn3,nextRow);
% writematrix(flux,filename,'Sheet',sname,'Range',range3);
writematrix(M3,filename,'Sheet',sname,'Range',range3);


%******** Spectral Centroid*****************
% audioBuffered = buffer(x,round(fs*0.005),0,'nodelay');
audioBuffered = buffer(x,round(fs*0.03),round(fs*0.02),'nodelay');
[p,cf] = poctave(audioBuffered,fs);
centroid = spectralCentroid(p,cf);
M4 = mean(centroid);
% S4 = std(centroid);
% N4 = (centroid - M4)./S4;
% index2=14+1;
% startingColumn2=excel_column(index2)
range4=sprintf('%s%d',startingColumn4,nextRow);
% writematrix(centroid,filename,'Sheet',sname,'Range',range4);
writematrix(M4,filename,'Sheet',sname,'Range',range4);

%******** Spectral Crest*****************
[s,cf] = melSpectrogram(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',0.02);
% [s,cf] = melSpectrogram(x,fs);
crest = spectralCrest(s,cf);
M5 = mean(crest);
% S5 = std(crest);
% N5 = (crest - M5)./S5;
% index2=14+1;
% startingColumn2=excel_column(index2)
range5=sprintf('%s%d',startingColumn5,nextRow);
% writematrix(crest,filename,'Sheet',sname,'Range',range5);
writematrix(M5,filename,'Sheet',sname,'Range',range5);

%******** Spectral Decrease *****************
[s,cf] = melSpectrogram(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',0.02);
% [s,cf] = melSpectrogram(x,fs);
decrease = spectralDecrease(s,cf);
M6 = mean(decrease);
% S6 = std(decrease);
% N6 = (decrease - M6)./S6;
% index2=14+1;
% startingColumn2=excel_column(index2)
range6=sprintf('%s%d',startingColumn6,nextRow);
% writematrix(decrease,filename,'Sheet',sname,'Range',range6);
writematrix(M6,filename,'Sheet',sname,'Range',range6);

%******** Spectral Entropy *****************
[s,cf,t] = melSpectrogram(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',0.02);
% [s,cf,t] = melSpectrogram(x,fs);
entropy = spectralEntropy(s,cf);
M7 = mean(entropy);
% S7 = std(entropy);
% N7 = (entropy - M7)./S7;
% index2=14+1;
% startingColumn2=excel_column(index2)
range7=sprintf('%s%d',startingColumn7,nextRow);
% writematrix(entropy,filename,'Sheet',sname,'Range',range7);
writematrix(M7,filename,'Sheet',sname,'Range',range7);

%******** Spectral Flatness *****************
[s,cf,t] = melSpectrogram(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',0.02);
% [s,cf,t] = melSpectrogram(x,fs);
flatness = spectralFlatness(s,cf);
M8 = mean(flatness);
% S8 = std(flatness);
% index2=14+1;
% startingColumn2=excel_column(index2)
range8=sprintf('%s%d',startingColumn8,nextRow);
% writematrix(flatness,filename,'Sheet',sname,'Range',range8);
writematrix(M8,filename,'Sheet',sname,'Range',range8);


%******** Spectral Kurtosis *****************
[s,cf,~] = melSpectrogram(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',0.02);
% [s,cf,~] = melSpectrogram(x,fs);
kurtosis = spectralKurtosis(s,cf);
M9 = mean(kurtosis);
% S9 = std(kurtosis);
% index2=14+1;
% startingColumn2=excel_column(index2)
range9=sprintf('%s%d',startingColumn9,nextRow);
% writematrix(kurtosis,filename,'Sheet',sname,'Range',range9);
writematrix(M9,filename,'Sheet',sname,'Range',range9);


%******** Spectral Rolloffpoint *****************
[s,cf,~] = melSpectrogram(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',0.02);
% [s,cf,~] = melSpectrogram(x,fs);
rolloffPoint = spectralRolloffPoint(s,cf);
M10 = mean(rolloffPoint);
% S10 = std(rolloffPoint);
% index2=14+1;
% startingColumn2=excel_column(index2)
range10=sprintf('%s%d',startingColumn10,nextRow);
% writematrix(rolloffPoint,filename,'Sheet',sname,'Range',range10);
writematrix(M10,filename,'Sheet',sname,'Range',range10);


%******** Spectral Skewness *****************
[s,cf,~] = melSpectrogram(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',0.02);
% [s,cf,~] = melSpectrogram(x,fs);
skewness = spectralSkewness(s,cf);
M11 = mean(skewness);
% S11 = std(skewness);
% index2=14+1;
% startingColumn2=excel_column(index2)
range11=sprintf('%s%d',startingColumn11,nextRow);
% writematrix(skewness,filename,'Sheet',sname,'Range',range11);
writematrix(M11,filename,'Sheet',sname,'Range',range11);


%******** Spectral Slope *****************
[s,cf,~] = melSpectrogram(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',0.02);
% [s,cf,~] = melSpectrogram(x,fs);
slope = spectralSlope(s,cf);
M12 = mean(slope);
% S12 = std(slope);
% index2=14+1;
% startingColumn2=excel_column(index2)
range12=sprintf('%s%d',startingColumn12,nextRow);
% writematrix(slope,filename,'Sheet',sname,'Range',range12);
writematrix(M12,filename,'Sheet',sname,'Range',range12);

%******** Spectral Slope *****************
[s,cf,t] = melSpectrogram(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',0.02);
% [s,cf,t] = melSpectrogram(x,fs);
spread = spectralSpread(s,cf);
M13 = mean(spread);
% S13 = std(spread);
% index2=14+1;
% startingColumn2=excel_column(index2)
range13=sprintf('%s%d',startingColumn13,nextRow);
% writematrix(spread,filename,'Sheet',sname,'Range',range13);
writematrix(M13,filename,'Sheet',sname,'Range',range13);

%******** Energy *****************
ste = sum(buffer(x.^2, round(fs*0.005),0));
M14 = mean(ste);
% S13 = std(spread);
% index2=14+1;
% startingColumn2=excel_column(index2)
range14=sprintf('%s%d',startingColumn14,nextRow);
% writematrix(spread,filename,'Sheet',sname,'Range',range13);
writematrix(M14,filename,'Sheet',sname,'Range',range14);

nextRow=nextRow+1;
i = i+1;
end
