folder = fullfile('Put the link of folder containing samples');
ADS = audioDatastore(folder);
sname='Sheet1';
startingColumn1='A';
nextRow=1;
% i=1;
filename = 'put name of file to write the extracted features';

while hasdata(ADS)
    
    x = read(ADS);
%     [x,fs]=audioread(x);
    fprintf('Fraction of files read: %.2f\n',progress(ADS))

%    Mention the sampling rate of your samples;
fs=96000;

%******** GTCC *****************
[coeffs1,delta1,deltaDelta1,loc1] = gtcc(x,fs,'WindowLength',round(fs*0.03),'OverlapLength',(fs*0.02));
% [coeffs1,delta1,deltaDelta1,loc1] = gtcc(x,fs);
M2 = mean(coeffs1);
range=sprintf('%s%d',startingColumn1,nextRow);
writematrix(M2,filename,'Sheet',sname,'Range',range);
nextRow=nextRow+1;
i = i+1;
end
