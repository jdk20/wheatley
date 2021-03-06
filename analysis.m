clc; clear variables; close all;

fn = '/home/jdk20/Downloads/data.txt';

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
info = readtable(fn, opts);
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

data = readtable(fn, opts);
data = table2cell(data);
numIdx = cellfun(@(x) ~isnan(str2double(x)), data);
data(numIdx) = cellfun(@(x) {str2double(x)}, data(numIdx));
clear opts

% 20  Start_ITI
% 21  End_ITI
% 22  Start_Punish_ITI
% 23  End_Punish_ITI
% 50  Lick
% 51  Lick
% 52  Lick
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

% Check for duplicate event codes
disp('Event Codes');
event_codes = unique(cell2mat(data(:,2)));
for i = 1:length(event_codes)
    idx = cell2mat(data(:,2)) == event_codes(i);
    if length(unique(data(idx,4))) > 1
        error(['Event Code ', num2str(event_codes(i)), ' is duplicated'])
    end
    temp = unique(data(idx,4));
    disp([num2str(event_codes(i)),' ', temp{1}])    
end

% Check sequence
sequence = NaN(size(data,1), 1);
sequence(cell2mat(data(:,2)) == 95) = 1;
sequence(cell2mat(data(:,2)) == 96) = 0;
sequence = sequence(~isnan(sequence));
% if length(sequence) ~= n_trials
%     error('Expected number of trials do not match');
% end

% if mean(data_sequence == sequence) ~= 1
%     error('Reported sequence does not match');
% end

% Compare end metrics
if data{cell2mat(data(:,2)) == 121, 5} ~= sum(cell2mat(data(:,2)) == 60) % Hits
    error('Hits mismatch');
end

if data{cell2mat(data(:,2)) == 122, 5} ~= sum(cell2mat(data(:,2)) == 61) % Miss
    error('Miss mismatch');
end

if data{cell2mat(data(:,2)) == 123, 5} ~= sum(cell2mat(data(:,2)) == 62) % FA
    error('FA mismatch');
end

if data{cell2mat(data(:,2)) == 124, 5} ~= sum(cell2mat(data(:,2)) == 63) % CR
    error('CR mismatch');
end

if data{cell2mat(data(:,2)) == 125, 5} ~= sum(cell2mat(data(:,2)) == 50 | ...
        cell2mat(data(:,2)) == 51 | cell2mat(data(:,2)) == 52) % Licks
    error('Licks mismatch');
end

% if data{cell2mat(data(:,2)) == 126, 5} ~= reward_vol*sum(cell2mat(data(:,2)) == 100) % Reward
%     error('Reward mismatch');
% end
disp(' ');
disp(['Reward (Log): ', num2str(data{cell2mat(data(:,2)) == 126, 5})]) 
disp(['Reward (Calculated): ', num2str(reward_vol*sum(cell2mat(data(:,2)) == 100))])

% if data{cell2mat(data(:,2)) == 120, 5} ~= (sum(cell2mat(data(:,2)) == 60) + ...
%         sum(cell2mat(data(:,2)) == 63))/(sum(cell2mat(data(:,2)) == 60) + ...
%         sum(cell2mat(data(:,2)) == 61) + sum(cell2mat(data(:,2)) == 62) + sum(cell2mat(data(:,2)) == 63))
%     error('Accuracy mismatch');
% end

% Error info
err_trial_bounds = [];
err_invalid_events = [];
err_n_trial_events = [];
err_sequence = [];
err_event_timing = [];
err_metrics = [];
err_iti_events = [];

% ITI
i0 = [find(cell2mat(data(:,2)) == 20); find(cell2mat(data(:,2)) == 22)]; % Start_ITI
i1 = [find(cell2mat(data(:,2)) == 21); find(cell2mat(data(:,2)) == 23)]; % End_ITI

time_iti = [];
time_punish_iti = [];

for i = 1:length(i0)
    trial = data(i0(i):i1(i),:);
    
    % Check for events beside Lick_ITI
    if sum(cell2mat(trial(2:end-1,2)) ~= 50) > 0
        err_iti_events = [err_iti_events; i];
    end
    
    % ITI
    if trial{1,2} == 20
        time_iti = [time_iti; trial{end,1} - trial{1,1}];
    % Punish ITI
    elseif trial{1,2} == 22
        time_punish_iti = [time_punish_iti; trial{end,1} - trial{1,1}];
    end
end

if ~isempty(err_iti_events)
    error('Non-lick event inside ITI');
end

disp(' ');
disp(['ITI; mean: ', num2str(sum(t_iti)/2),', range: ',num2str(t_iti(1)),'-',num2str(t_iti(2)), ...
    ', measured; mean: ',num2str(mean(time_iti)),', range: ',num2str(min(time_iti)),'-',num2str(max(time_iti)),'']);
disp(['Punished ITI; mean: ', num2str(sum(t_iti+t_punish)/2),', range: ',num2str(t_iti(1)+t_punish),'-',num2str(t_iti(2)+t_punish), ...
    ', measured; mean: ',num2str(mean(time_punish_iti)),', range: ',num2str(min(time_punish_iti)),'-',num2str(max(time_punish_iti)),'']);

% CS Trials
i0 = [find(cell2mat(data(:,2)) == 95); find(cell2mat(data(:,2)) == 96)]; % Start_CS_Trial
i1 = [find(cell2mat(data(:,2)) == 97); find(cell2mat(data(:,2)) == 98)]; % End_CS_Trial

time_delay = [];
time_reception = [];
time_trial = [];

for i = 1:length(i0)
    trial = data(i0(i):i1(i),:);
    
    % Check for trial events outside of Start_CS_Trial and End_CS_Trial
    if data{i0(i)-1,2} ~= 21 && data{i0(i)-1,2} ~= 23
        err_trial_bounds = [err_trial_bounds; i];
    end
    if data{i1(i)+1,2} ~= 20 && data{i1(i)+1,2} ~= 22
        err_trial_bounds = [err_trial_bounds; i];
    end
    
    % Look for ITI events
    idx = cell2mat(trial(:,2)) == 20 | cell2mat(trial(:,2)) == 21 | ...
        cell2mat(trial(:,2)) == 22 | cell2mat(trial(:,2)) == 23 | cell2mat(trial(:,2)) == 50;
    if sum(idx) > 0
        err_invalid_events = [err_invalid_events; i];
    end
    
    % Remove licks
    idx = cell2mat(trial(:,2)) == 51 | cell2mat(trial(:,2)) == 52;
    trial_wo_licks = trial(~idx,:);
    
    % Count events, could have optional reward
    if size(trial_wo_licks,1) > 9 || size(trial_wo_licks,1) < 8
        err_n_trial_events = [err_n_trial_events; i];
    end
    
    % (1) Start_CS_Trial
    if trial_wo_licks{1,2} ~= 95 && trial_wo_licks{1,2} ~= 96
        err_sequence = [err_sequence; i];
    end
    
    % (2) Play_Audio_Tone_CS
    if trial_wo_licks{2,2} ~= 90 && trial_wo_licks{2,2} ~= 89
        err_sequence = [err_sequence; i];
    end
    
    % (3) Start_Trial_Delay_Window
    if trial_wo_licks{3,2} ~= 91
        err_sequence = [err_sequence; i];
    end
    
    % (4) End_Trial_Delay_Window
    if trial_wo_licks{4,2} ~= 93
        err_sequence = [err_sequence; i];
    end
    
    % (5) Start_Trial_Reception
    if trial_wo_licks{5,2} ~= 92
        err_sequence = [err_sequence; i];
    end
    
    % (6) End_Trial_Reception
    if trial_wo_licks{6,2} ~= 94
        err_sequence = [err_sequence; i];
    end
    
    time_delay = [time_delay; trial_wo_licks{4,1} - trial_wo_licks{3,1}];
    time_reception = [time_reception; trial_wo_licks{6,1} - trial_wo_licks{5,1}];
    
    if size(trial_wo_licks,1) == 8
        % (7) Metric
        if trial_wo_licks{7,2} ~= 60 && trial_wo_licks{7,2} ~= 61 && trial_wo_licks{7,2} ~= 62 && trial_wo_licks{7,2} ~= 63
            err_sequence = [err_sequence; i];
        end
        
        % (8) End_CS_Trial
        if trial_wo_licks{8,2} ~= 97 && trial_wo_licks{8,2} ~= 98
            err_sequence = [err_sequence; i];
        end
        
        time_trial = [time_trial; trial_wo_licks{8,1} - trial_wo_licks{1,1}];
    elseif size(trial_wo_licks,1) == 9
        % (7) Dispense_Reward
        if trial_wo_licks{7,2} ~= 100
            err_sequence = [err_sequence; i];
        end
        
        % (8) Metric
        if trial_wo_licks{8,2} ~= 60 && trial_wo_licks{8,2} ~= 61 && trial_wo_licks{8,2} ~= 62 && trial_wo_licks{8,2} ~= 63
            err_sequence = [err_sequence; i];
        end
        
        % (9) End_CS_Trial
        if trial_wo_licks{9,2} ~= 97 && trial_wo_licks{9,2} ~= 98
            err_sequence = [err_sequence; i];
        end
        
        time_trial = [time_trial; trial_wo_licks{9,1} - trial_wo_licks{1,1}];
    end
    
    % Metrics
    % CS+
    if trial{1,2} == 95
        if sum(cell2mat(trial(:,2)) == 51) >= min_licks % Delay
            if trial{end-1,2} ~= 61 % Miss
                err_metrics = [err_metrics; i];
            end
        elseif sum(cell2mat(trial(:,2)) == 52) >= min_licks % Reception
            if trial{end-1,2} ~= 60 % Hit
                err_metrics = [err_metrics; i];
            end
        else % No licks meet threshold
            if trial{end-1,2} ~= 61 % Miss
                err_metrics = [err_metrics; i];
            end
        end
        
    % CS-
    elseif trial{1,2} == 96
        if sum(cell2mat(trial(:,2)) == 51) >= min_licks % Delay
            if trial{end-1,2} ~= 62 % False Alarm
                err_metrics = [err_metrics; i];
            end
        elseif sum(cell2mat(trial(:,2)) == 52) >= min_licks % Reception
            if trial{end-1,2} ~= 62 % False Alarm
                err_metrics = [err_metrics; i];
            end
        else % No licks meet threshold
            if trial{end-1,2} ~= 63 % Correct Reject
                err_metrics = [err_metrics; i];
            end
        end
    end
    
end

disp(' ')
b1 = bootstrp(1000,@mean,time_delay);
disp(['Delay: ', num2str(t_delay),', measured: ', num2str(mean(time_delay)), ...
    ' (95%: ',num2str(prctile(b1,2.5)),'-',num2str(prctile(b1,97.5)),'), bias: ', num2str(t_delay - mean(time_delay))])

b2 = bootstrp(1000,@mean,time_reception);
disp(['Reception: ', num2str(t_reception),', measured: ', num2str(mean(time_reception)), ...
    ' (95%: ',num2str(prctile(b2,2.5)),'-',num2str(prctile(b2,97.5)),'), bias: ', num2str(t_reception - mean(time_reception))])

b3 = bootstrp(1000,@mean,time_trial);
disp(['Trial: ', num2str(t_reception+t_delay),', measured: ', num2str(mean(time_trial)), ...
    ' (95%: ',num2str(prctile(b3,2.5)),'-',num2str(prctile(b3,97.5)),'), bias: ', num2str((t_reception + t_delay) - mean(time_trial))])

if ~isempty(err_trial_bounds)
    error('Trial events outside of trial bounds');
end

if ~isempty(err_invalid_events)
    error('ITI events within trial bounds');
end

if ~isempty(err_n_trial_events)
    error('Trial contains extra/duplicate events');
end

if ~isempty(err_sequence)
    error('Trial sequence out of order');
end

if ~isempty(err_sequence)
    error('Metrics error');
end




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





















