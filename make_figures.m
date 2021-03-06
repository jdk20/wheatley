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

% 20  Start_ITI
% 21  End_ITI
% 22  Start_Punish_ITI
% 23  End_Punish_ITI
% 50  Lick ITI
% 51  Lick Delay
% 52  Lick Reception
% 60  Trial_Hit
% 61  Trial_Miss
% 62  Trial_FA
% 63  Trial_CR
% 89  Play_Audio_Tone_CS-
% 90  Play_Audio_Tone_CS+
% 91  Start_Trial_Delay_Window
% 92  Start_Trial_Reception_Window
% 93  End_Trial_Delay_Window
% 94  End_Trial_Reception_Window
% 95  Start_CS+_Trial
% 96  Start_CS-_Trial
% 97  End_CS+_Trial
% 98  End_CS-_Trial
% 100  Dispense_Reward
% 110  End_Session_Trials_Finished
% 120  End_Session_Accuracy
% 121  End_Session_Number_Hits
% 122  End_Session_Number_Miss
% 123  End_Session_Number_FA 
% 124  End_Session_Number_CR
% 125  End_Session_Number_Licks
% 126  End_Session_Reward_Dispensed_ml

% Grab info
n_trials = info{strcmp(info(:,1),'Trials'), 2};
t_delay = info{strcmp(info(:,1),'Delay_Window_ms'), 2}/1000;
t_reception = info{strcmp(info(:,1),'Reception_Window_ms'), 2}/1000;
t_iti = [info{strcmp(info(:,1),'ITI_Lower_s'), 2} info{strcmp(info(:,1),'ITI_Upper_s'), 2}];
t_punish = info{strcmp(info(:,1),'Punish_Time_s'), 2};
min_licks = info{strcmp(info(:,1),'Min_Licks'), 2};
reward_vol = info{strcmp(info(:,1),'Reward_Volume'), 2};

% load sequence
opts = delimitedTextImportOptions("NumVariables", n_trials+1);
opts.DataLines = [24, 24];
opts.Delimiter = ",";
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
data_sequence = readtable("/home/jdk20/git/wheatley/0000-00-00-00-00-00/data.txt", opts);
data_sequence = table2array(data_sequence);
clear opts
data_sequence = str2double(data_sequence(2:end))';

% CS Trials
i0 = find(cell2mat(data(:,2)) == 95 | cell2mat(data(:,2)) == 96); % Start_CS_Trial
i1 = find(cell2mat(data(:,2)) == 97 | cell2mat(data(:,2)) == 98); % End_CS_Trial

performance = [];
t_performance = [];

lick = struct('cs_plus', struct('hit', ...
    struct('reception',[],'delay',[]),'miss', ...
    struct('reception',[],'delay',[])), ...
    'cs_minus',struct('cr', ...
    struct('reception',[],'delay',[]), ...
    'fa',struct('reception',[],'delay',[])));

c0 = 1;
c1 = 1;
c2 = 1;
c3 = 1;
for i = 1:length(i0)
    trial = data(i0(i):i1(i),:);
    t_performance = [t_performance; trial{end,1}];
    
    % Correct
    if sum(cell2mat(trial(:,2)) == 60 | cell2mat(trial(:,2)) == 63)
        performance = [performance; 1];
    % Incorect
    elseif sum(cell2mat(trial(:,2)) == 61 | cell2mat(trial(:,2)) == 62)
        performance = [performance; 0];
    else
        error('No metric');
    end
    
    t_offset = trial{1,1};
    d = cell2mat(trial(cell2mat(trial(:,2)) == 51,1)) - t_offset;
    r = cell2mat(trial(cell2mat(trial(:,2)) == 52,1)) - t_offset;
    
    if trial{1,2} == 95 % CS+
        if trial{end-1,2} == 60 % Hit
            lick.cs_plus.hit.reception{c0} = r;
            lick.cs_plus.hit.delay{c0} = d;
            c0 = c0 + 1;
        elseif trial{end-1,2} == 61 % Miss
            lick.cs_plus.miss.reception{c0} = r;
            lick.cs_plus.miss.delay{c0} = d;
            c1 = c1 + 1;
        end
    elseif trial{1,2} == 96 % CS-
        if trial{end-1,2} == 63 % CR
            lick.cs_minus.cr.reception{c0} = r;
            lick.cs_minus.cr.delay{c0} = d;
            c2 = c2 + 1;
        elseif trial{end-1,2} == 62 % FA
            lick.cs_minus.fa.reception{c0} = r;
            lick.cs_minus.fa.delay{c0} = d;
            c3 = c3 + 1;
        end
    end
end

% Licks
figure(1);
for k = 1:4
    switch k
        case 1
            S = 'CS+ Trials (Hit)';
            n = length(lick.cs_plus.hit.delay);
        case 2
            S = 'CS- Trials (CR)';
            n = length(lick.cs_minus.cr.delay);
        case 3
            S = 'CS+ Trials (Miss)';
            n = length(lick.cs_plus.miss.delay);
        case 4
            S = 'CS- Trials (FA)';
            n = length(lick.cs_minus.fa.delay);
    end
    
    subplot(2,2,k);
    box off; hold on;
    for i = 1:n
        
        switch k
            case 1
                temp_0 = lick.cs_plus.hit.delay{i};
                temp_1 = lick.cs_plus.hit.reception{i};
            case 2
                temp_0 = lick.cs_minus.cr.delay{i};
                temp_1 = lick.cs_minus.cr.reception{i};
            case 3
                temp_0 = lick.cs_plus.miss.delay{i};
                temp_1 = lick.cs_plus.miss.reception{i};
            case 4
                temp_0 = lick.cs_minus.fa.delay{i};
                temp_1 = lick.cs_minus.fa.reception{i};
        end
        
        plot(temp_0, i.*ones(1,length(temp_0)), 'ks','MarkerFaceColor','w','MarkerSize',4);
        plot(temp_1, i.*ones(1,length(temp_1)), 'ks','MarkerFaceColor','k','MarkerSize',4);
    end
%     line([t_delay t_delay],[1 i],'Color','k','LineStyle','--');
    xlabel('Time (seconds)');
    ylabel('Trials');
    title(S);
end

figure(2)
% Rolling accuracy
acc = [];
for i = 1:length(performance)
    acc = [acc; mean(performance(1:i))];
end

subplot(211);
plot(1:n_trials, acc, 'k'); box off;
line([1 n_trials],[0.5 0.5],'Color','k','LineStyle','--');
ylim([0 1]);
xlim([1 n_trials]);
xlabel('Trials');
ylabel('Instantaneous accuracy');
set(gca,'YTick',0:0.1:1);

subplot(212);
plot(t_performance, acc, 'k.','LineStyle','-'); box off;
line([t_performance(1) t_performance(end)],[0.5 0.5],'Color','k','LineStyle','--');
ylim([0 1]);
xlim([t_performance(1) t_performance(end)]);
xlabel('Time (seconds)');
ylabel('Instantaneous accuracy');
set(gca,'YTick',0:0.1:1);

cd('/home/jdk20/git/wheatley');
w = 8;
h = 5;
set(figure(1),'PaperPosition',[0 0 w*1.19 h*1.19]);
print(figure(1),'-dpng','licks_by_metric.png');

set(figure(2),'PaperPosition',[0 0 w*1.19 h*1.19]);
print(figure(2),'-dpng','acc_over_time_and_trials.png');















