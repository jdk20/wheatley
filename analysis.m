clc; clear variables; close all;

% Import data.csv
opts = delimitedTextImportOptions("NumVariables", 5);
opts.DataLines = [24, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["Time", "ID", "Type", "Name", "Value"];
opts.VariableTypes = ["double", "double", "char", "char", "char"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, ["Type", "Name"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Type", "Name"], "EmptyFieldRule", "auto");

data = readtable("/home/jdk20/git/wheatley/0000-00-00-00-00-00/data.txt", opts);
data = table2cell(data);
numIdx = cellfun(@(x) ~isnan(str2double(x)), data);
data(numIdx) = cellfun(@(x) {str2double(x)}, data(numIdx));
clear opts

% 90: CS+
% 91: CS-
% 95: Start_CS+_Trial
% 96: Start_CS-_Trial
% 97: End_CS+_Trial
% 98: End_CS-_Trial
% 20: Start_ITI
% 21: End_ITI
% 22: Start_Punish_ITI
% 23: End_Punish_ITI
% 50: Lick, ITI
% 51: Lick, Delay
% 53: Lick, Reception

i0 = find(cell2mat(data(:,2)) == 95);
i1 = find(cell2mat(data(:,2)) == 96);

box off; hold on;
% plot(cell2mat(data(i0,1)),ones(1,length(cell2mat(data(i0,1)))),'k.');
for i = 1:length(i0)
    line([cell2mat(data(i0(i),1)) cell2mat(data(i1(i),1))],[1 1]);
end

i0 = find(cell2mat(data(:,2)) == 50);
plot(cell2mat(data(i0,1)),ones(1,length(cell2mat(data(i0,1)))),'ks');

i0 = find(cell2mat(data(:,2)) == 51);
plot(cell2mat(data(i0,1)),ones(1,length(cell2mat(data(i0,1)))),'ks');

i0 = find(cell2mat(data(:,2)) == 52);
plot(cell2mat(data(i0,1)),ones(1,length(cell2mat(data(i0,1)))),'ks','MarkerFaceColor','k');