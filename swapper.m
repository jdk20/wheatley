%% Swapper
clc; clear variables; close all;

% number of trials for the session
n = 100050;
% maximum consecutive elements
k = 9;

if k < floor(n/2)
    % create in lengths of k
    x = [];
    for i = 1:ceil(n/k)
        if mod(i,2) == 0
            x = [x; zeros(k, 1)];
        elseif mod(i,2) == 1
            x = [x; ones(k, 1)];
        end
    end

    % Trim if n is an odd number
    if length(x) > n
        x = x(1:n);
    end
else   
   x = [zeros(floor(n/2), 1); ones(ceil(n/2), 1)];
end

disp(['S+ trials ', num2str(sum(x == 1))]);
disp(['S- trials ', num2str(sum(x == 0))]);

swaps = [];
for i = 1:10000
    % Select two elements at random and swap them if it doesn't create >k
    % consecutive elements
    i0 = randi(length(x),1);
    i1 = randi(length(x),1);

    % if i0 and i1 are the same element, don't swap
    if x(i0) == x(i1)
%         disp(['no swap: i0 and i1 are both ', num2str(x(i0))]);
        swaps = [swaps; 0];
    else
        % if (k-1) indexes forward or backwards of i0/i1 create >k i0/i1 consecutive
        % elements, don't swap

        % Check for out-of-array bounds
        lower_i0 = max(1, i0-(k-1));
        upper_i0 = min(n, i0+(k-1));

        lower_i1 = max(1, i1-(k-1));
        upper_i1 = min(n, i1+(k-1));

        % Grab k consecutive indexes on either side
        x_lower_i0 = x(lower_i0:i0);
        x_upper_i0 = x(i0:upper_i0);

        x_lower_i1 = x(lower_i1:i1);
        x_upper_i1 = x(i1:upper_i1);

        % Test swap
        x_lower_i0(end) = x(i1);
        x_upper_i0(1) = x(i1);

        x_lower_i1(end) = x(i0);
        x_upper_i1(1) = x(i0);

        % Check test swap for consecutive elements
        if sum(x_lower_i0 == x(i1)) < k & sum(x_upper_i0 == x(i1)) < k & sum(x_lower_i1 == x(i0)) < k & sum(x_upper_i1 == x(i0)) < k
            % Swap elements
            temp_i0 = x(i0);
            temp_i1 = x(i1);

            x(i0) = temp_i1;
            x(i1) = temp_i0;
            
%             disp(['swap: index ', num2str(i0),' (', num2str(temp_i0),') and ', num2str(i1),' (', num2str(temp_i1),')']);
            swaps = [swaps; 1];
        else
            % Don't swap
%             disp('no swap: k violation');
            swaps = [swaps; 0];
        end
    end
end

disp([num2str(sum(swaps)), ' swaps']);
% disp(num2str(x));

start1 = strfind([0,x'==1],[0 1]);
end1 = strfind([x'==1,0],[1 0]);
max(end1 - start1 + 1)

%% Swapper 2
clc; clear variables; close all;

n = 16; % number of trials 
k = 3; % maximum number of consecutive trials

t = 3; % trial types, starting at 0. t = 2 for binary trials
tp = [10.4, 1.2, 5.6]; % relative proportions of each trial type

% -------------------------------------------------------------------------
% Error checks
% -------------------------------------------------------------------------
% convert tp to a pmf
tp = tp./sum(tp);

if k <= 0
    error('Maximum number of consecutive trials must be greater than or equal to 1');
end

if n <= 0
    error('Number of trials must be greater than or equal to 1');
end

if t <=0
    error('Number of unique trial types must be greater than or equal to 1');
end

if t > n
    error("Number of unique trial types shouldn't exceed the number of total trials");
end

if length(tp) ~= t
    error("Each trial should have an associated probability");
end

% -------------------------------------------------------------------------
% Generation
% -------------------------------------------------------------------------
disp(['Generating ', num2str(n),' trials with ', num2str(t),' trial types, and a limit of ', num2str(k),' consecutive trials']);
disp(' ');

n_trials = floor(tp.*n); % whole number of trials
f_trials = (tp.*n) - floor(tp.*n); % fractional part of trials
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
for i = 1:length(tp)
    disp(['Trial ', num2str(i-1),': ', num2str(tp(i)), ', ',num2str(tp(i)*n),' trials, ', num2str(n_trials(i)),' trials']);
end

if sum(n_trials == 0) > 0
    disp('Warning: Empty trials');
end

if k >= n
    % Quick shuffle
end



























































