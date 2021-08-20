clc; clear variables; close all;

% Import info from data.csv
opts = delimitedTextImportOptions("NumVariables", 5);
opts.DataLines = [1, 23];
opts.Delimiter = ",";
opts.VariableNames = ["Time", "ID", "Var3", "Var4", "Var5"];
opts.SelectedVariableNames = ["Time", "ID"];
opts.VariableTypes = ["char", "char", "string", "string", "string"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, ["Time", "ID", "Var3", "Var4", "Var5"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Time", "ID", "Var3", "Var4", "Var5"], "EmptyFieldRule", "auto");
info = readtable("/home/jdk20/git/wheatley/0000-00-00-00-00-00/data.txt", opts);
info = table2cell(info);
numIdx = cellfun(@(x) ~isnan(str2double(x)), info);
info(numIdx) = cellfun(@(x) {str2double(x)}, info(numIdx));
clear opts

info

% Import main data from data.csv
opts = delimitedTextImportOptions("NumVariables", 5);
opts.DataLines = [28, Inf];
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
% 52: Lick, Reception
% 60: Trial Hit
% 61: Trial Miss
% 62: Trial FA
% 63: Trial CR




return

i0 = find(cell2mat(data(:,2)) == 95); % Start_CS+_Trial
i1 = find(cell2mat(data(:,2)) == 97); % End_CS+_Trial

i2 = find(cell2mat(data(:,2)) == 96); % Start_CS-_Trial
i3 = find(cell2mat(data(:,2)) == 98); % End_CS-_Trial

% CS+ trial
box off; hold on;
for i = 1:length(i0)
    line([cell2mat(data(i0(i),1)) cell2mat(data(i1(i),1))],[1 1],'Color','g');
end

% CS+ trial
for i = 1:length(i2)
    line([cell2mat(data(i2(i),1)) cell2mat(data(i3(i),1))],[1 1],'Color','r');
end

i4 = find(cell2mat(data(:,2)) == 50); % ITI Lick
plot(cell2mat(data(i4,1)),ones(1,length(cell2mat(data(i4,1)))),'ks');

i5 = find(cell2mat(data(:,2)) == 51); % Delay Lick, invalid
plot(cell2mat(data(i5,1)),ones(1,length(cell2mat(data(i5,1)))),'ks');

i6 = find(cell2mat(data(:,2)) == 52); % Reception Lick, valid
plot(cell2mat(data(i6,1)),ones(1,length(cell2mat(data(i6,1)))),'ks','MarkerFaceColor','k');

% Trial Hit or CR
i7 = find(cell2mat(data(:,2)) == 60 | cell2mat(data(:,2)) == 63);
plot(cell2mat(data(i7,1)),ones(1,length(cell2mat(data(i7,1)))),'kd','MarkerFaceColor','k');

% Trial Miss or FA
i8 = find(cell2mat(data(:,2)) == 61 | cell2mat(data(:,2)) == 62);
plot(cell2mat(data(i8,1)),ones(1,length(cell2mat(data(i8,1)))),'kd','MarkerFaceColor','w');





















