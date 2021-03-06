%% Swapper
clc; clear variables; close all;

rng(42);

n_sequences = 1000;

% n = 50; % number of trials 
% k = 3; % maximum number of consecutive trials
m = 4; % trial types, starting at 0. t = 2 for binary trials
mp = [1, 1, 1, 1]; % relative proportions of each trial type

for n = [500]
    for k = [3 5 1000]
        [n k]
        m_trials = NaN(n, n_sequences);
        m_mae = NaN(n_sequences, 1);
        m_cm = NaN(m, m, n_sequences);
        for i = 1:n_sequences
            disp(['Sequence ', num2str(i)]);
            [trials, cm, mae] = generate_trials(n, k, m, mp);
            disp(' ');
            m_trials(:, i) = trials;
            m_mae(i) = mae;
            m_cm(:,:,i) = cm;
        end

        if n_sequences < 100
            similarity_trials = [];
            similarity_cm = [];
            for i = 1:n_sequences
                for j = 1:n_sequences
                    if i ~= j
                        similarity_trials = [similarity_trials; mean(m_trials(:,i) == m_trials(:,j))];
                        similarity_cm = [similarity_cm; mean(mean(m_cm(:,:,i) == m_cm(:,:,j)))];
                    end
                end
            end

            disp('Finished');
            disp(['Mean similarity: ', num2str(mean(similarity_trials)),', min: ', ...
                num2str(min(similarity_trials)),', max: ', num2str(max(similarity_trials))]);
            disp(['Mean MAE: ', num2str(mean(m_mae)),', min: ', ...
                num2str(min(m_mae)),', max: ', num2str(max(m_mae))]);
        end

        % Output sequence as rows
        cd('/home/jdk20/git/wheatley/sequences');
        if k >= n
            writematrix(m_trials', ['seq_n_',num2str(n),'_k_inf_m_',num2str(m),'.csv'], 'Delimiter',',')
        else
            writematrix(m_trials', ['seq_n_',num2str(n),'_k_',num2str(k),'_m_',num2str(m),'.csv'], 'Delimiter',',')
        end
    end
end

% -------------------------------------------------------------------------
% Functions
% -------------------------------------------------------------------------
function [trials, cm, mae] = generate_trials(n, k, m, mp)
    B = 100*n; % number of random swaps

    % ---------------------------------------------------------------------
    % Error checks
    % ---------------------------------------------------------------------
    % convert tp to a pmf
    mp = mp./sum(mp);

    if k <= 0
        error('Maximum number of consecutive trials must be greater than or equal to 1');
    end

    if n <= 0
        error('Number of trials must be greater than or equal to 1');
    end

    if m <=0
        error('Number of unique trial types must be greater than or equal to 1');
    end

    if m > n
        error("Number of unique trial types shouldn't exceed the number of total trials");
    end

    if length(mp) ~= m
        error("Each trial should have an associated probability");
    end

    % ---------------------------------------------------------------------
    % Generation
    % ---------------------------------------------------------------------
    disp(['Generating ', num2str(n),' trials with ', num2str(m), ...
        ' trial types, and a limit of ', num2str(k),' consecutive trials']);

    n_trials = floor(mp.*n); % whole number of trials
    f_trials = (mp.*n) - floor(mp.*n); % fractional part of trials
    [~, idx] = sort(f_trials, 'descend');

    diff_trials = n - sum(n_trials); % number of additional trials needed

    % add trials to trials types with greatest fractional component
    i = 1;
    while diff_trials > 0
        n_trials(idx(i)) = n_trials(idx(i)) + 1;

        i = i + 1;
        diff_trials = diff_trials - 1;
    end

    if sum(n_trials) ~= n
        error("Something went wrong with the fractional allocation...");
    end

    disp('Trial type probabilities and number of trials');
    for i = 1:length(mp)
        disp(['Trial ', num2str(i-1),': ', num2str(mp(i)), ', ', ...
            num2str(mp(i)*n),' trials, ', num2str(n_trials(i)),' trials']);
    end

    if sum(n_trials == 0) > 0
        disp('Warning: Empty trials');
    end

    % Sort trials in descending size for interweaving
    idx_trials = 0:(length(n_trials)-1);
    [trial_bag, idx] = sort(n_trials, 'descend');
    idx_trials = idx_trials(idx);

    trials = [];
    counter = 0; % check for no available spaces to interweave
    while sum(trial_bag) > 0 && counter ~= (length(trials) - 1)
        % at least two trial types to interweave
        if sum(trial_bag ~= 0) > 1
            
            % select a random trial type
            i = randi(m, 1);
            
            if isempty(trials)
                skip_trial = false;
            elseif trials(end) == (i-1)
                skip_trial = true;
            else
                skip_trial = false;
            end
            
            if skip_trial
                % skip
            else
                if trial_bag(i) == 0
                    % skip
                elseif (trial_bag(i) - k) >= 0
                    % full draw
                    trials = [trials; idx_trials(i).*ones(k,1)];
                    trial_bag(i) = trial_bag(i) - k;
                elseif (trial_bag(i) - k) < 0
                    % partial draw
                    trials = [trials; idx_trials(i).*ones(trial_bag(i),1)];
                    trial_bag(i) = 0;
                else
                    error("Something went wrong with the interweaving...");
                end
            end

        else
            % only one trial type left
            last_trial_idx = idx_trials(trial_bag > 0);
            j = find(trial_bag > 0);

            if length(last_trial_idx) > 1
                error("Something went wrong with detecting the final trial type...");
            end

            while trial_bag(j) > 0 && counter ~= (length(trials) - 1)
                counter = 0;
                for i = 1:length(trials)-1
                    if trials(i) ~= last_trial_idx && trials(i+1) ~= last_trial_idx
                        if trial_bag(j) == 0
                            % end
                        elseif (trial_bag(j) - k) >= 0
                            trials = [trials(1:i);
                            last_trial_idx.*ones(k, 1);
                            trials(i+1:end)];

                            trial_bag(j) = trial_bag(j) - k;
                        elseif (trial_bag(j) - k) < 0
                            trials = [trials(1:i);
                            last_trial_idx.*ones(trial_bag(j), 1);
                            trials(i+1:end)];

                            trial_bag(j) = 0;
                        else
                            error("Something went wrong with the final interweaving...");
                        end
                    end
                    counter = counter + 1;
                end
            end
        end
    end
    
    if counter == (length(trials) - 1)
        error(['Could not place ', num2str(trial_bag(j)),' trials of trial type ', ...
            num2str(last_trial_idx),' without violating the limit of k = ', ...
            num2str(k),' consecutive trials']);
    end

    if length(trials) ~= n
        error('Missing some trials...');
    end

    for i = 0:length(n_trials)-1
        if sum(trials == i) ~= n_trials(i+1)
            error(['Missing trials for trial type ', num2str(i)]);
        end
    end

    [err, mc] = k_check(trials, m, k);
    if err
        error(['Limit k has been violated, max consecutive = ', num2str(mc)]);
    end


    % ---------------------------------------------------------------------
    % Permutation
    % ---------------------------------------------------------------------
    um = ones(m, m)/(m^2); % uniform matrix for comparison
    if k >= n
        % Quick shuffle
        trials = trials(randperm(n));
    else
        
    for i = 1:B
        i0 = randi(length(trials), 1);
        i1 = randi(length(trials), 1);

        if i0 == i1
            % same index, no swap
        elseif trials(i0) == trials(i1)
            % same trial type, no swap
        else
            % potential swap, check if it would break k
            putative_trials = trials;
            putative_trials(i0) = trials(i1);
            putative_trials(i1) = trials(i0);

            err = k_check(putative_trials, m, k);
            if err
                % no swap
            else
                % swap
                trials = putative_trials;
            end
        end
    end

    end

    % ---------------------------------------------------------------------
    % Final Error Check
    % ---------------------------------------------------------------------
    if length(trials) ~= n
        error('Final: Missing some trials...');
    end

    for i = 0:length(n_trials)-1
        if sum(trials == i) ~= n_trials(i+1)
            error(['Final: Missing trials for trial type ', num2str(i)]);
        end
    end

    [err, mc] = k_check(trials, m, k);
    if err
        error(['Final: Limit k has been violated, max consecutive = ', num2str(mc)]);
    end

    % ---------------------------------------------------------------------
    % Statistics
    % ---------------------------------------------------------------------
    cm = zeros(m, m); % transition matrix
    for i = 1:length(trials)-1
        cm(trials(i)+1, trials(i+1)+1) = cm(trials(i)+1, trials(i+1)+1) + 1;
    end
    cm = cm./sum(cm(:));
    mae = mean(abs(cm(:) - um(:))); % mean absolute error
end


function [err, max_consecutive] = k_check(trials, m, k)
    max_consecutive = [];
    for i = 0:(m-1)
        idx_start = strfind([0, trials' == i], [0 1]);
        idx_stop = strfind([trials' == i, 0], [1 0]);
        
        max_consecutive = [max_consecutive; max(idx_stop - idx_start + 1)];
    end
    
    max_consecutive = max(max_consecutive);
    
    if max_consecutive > k
        err = true;
    else
        err = false;
    end
end