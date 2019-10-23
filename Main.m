%% Main function for implementing BCMO to solve optimization problems
%% Programmer: Thang Le-Duc
%  Emails: thang.ld@vgu.edu.vn; le.duc.thang0312@gmail.com
%% Begin main function
clear all, close all, clc
%% Define input parameters
total_time = 30;                % Total times for solving problem
d = 100;                        % Dimension of optimization problem
NP = 100;                       % Population size
MaxGen = round(100000/NP);      % Maximum Generation
result = zeros(total_time,d+1); % Repository for saving optimal results
Objf  = @OptimProblem;                   % Objective function
LB = ones(1,d)*-5.12; UB = ones(1,d)*5.12;  % Solution Space
%% Apply BCMO to solve optimization problem
tpad = cputime;                 % Start to calculate the elapsed time
for time=1:total_time
    x = BCMO(Objf,NP,MaxGen,d,LB,UB);   % Call BCMO solver
    result(time,:) = x;         % Save the final result obtained by each optimization time
end
%% Save the optimal result
totaltime = (cputime-tpad)      % Print the elapsed time
best = min(result(:,d+1))       % Print the best objective function value
worst = max(result(:,d+1))      % Print the worst objective function value
mean_ = mean(result(:,d+1))     % Print the mean objective function value
std_ = std(result(:,d+1))       % Print the standard deviation of objective function value
save result.mat result mean_ std_;  % Save all information about optimal result
save time.mat totaltime;        % Save the elapsed time