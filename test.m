close all, clc, clear all 

threshold = 0.25;

stageDxata = xlsread('Stage_Data.xls');
x = stageData(:,2);
y = stageData(:,3);

MxAllowSqD=x(1,1)/100; % Max. allowed Square Distance between original and fitted data

Mat = [ y x ];

out = straightTracks(Mat, MxAllowSqD, threshold);

figure, hold on;
plot(Mat(:,1), Mat(:,2), 'r', 'Linewidth', 3);
for i = 1:numel(out);
    temp = out{1,i};
    plot(temp(:,1), temp(:,2), 'g', 'Linewidth', 3);
    
end
