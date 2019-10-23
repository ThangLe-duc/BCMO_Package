function best = BCMO(fitnessFunc,NP,MaxGeneration,d,LB,UB)
%% 100-LINE MATLAB SOURCE CODES of BALANCING COMPOSITE MOTION OPTIMIZATION (BCMO), First Edition, October 2019
%% AUTHORS: Thang Le-Duc, Quoc-Hung Nguyen, H. Nguyen-Xuan
%% PROGRAMMER: Thang Le-Duc
%% EMAILS:
%         thang.ld@vgu.edu.vn; le.duc.thang0312@gmail.com
%         hung.nq@vgu.edu.vn
%         ngx.hung@hutech.edu.vn
%% PARAMETERS:
%       fitnessFunc              - input objective function
%       NP                       - number of individuals
%       MaxGeneration            - number of optimization iterations
%       d                        - dimension of problem
%       LB, UB                   - lower and upper bounds of design variables (DVs)
%% INITIALIZATION
% Uniformly initialize population and evaluate objective function values
xn=zeros(NP,d);
ObjVal=zeros(NP,1);
for ith=1:NP
    xn(ith,:)=rand(1,d).*(UB-LB)+LB;
end
for ith=1:NP
    ObjVal(ith)=fitnessFunc(xn(ith,:));
end
% Ranking the individuals based on their objective function values
[ObjVal,Index] = sort(ObjVal);
xn = xn(Index,:);
% Print the results per iteration
fprintf('\n						 Best\t\t Mean\t\n')
fprintf('Generation\tf-count\t\t f(x)\t\t Population\n')
%% MAIN OPTIMIZATION LOOP
for i=1:MaxGeneration     % Begin optimization loop
    fprintf('\t%i\t\t%i\t\t\t %f\t %f\n',...
        i,(i*NP),ObjVal(1),mean(ObjVal))
% Save the information of the previous iteration
xntmp = xn;
ObjValPre = ObjVal;
% Generate trial vector u1t
k1 = randi([2 NP]);
k2 = randi([2 k1]);
if rand > 0.5 kvt1 = rand(1,d); else kvt1 = -rand(1,d); end
if rand > 0.5 kvr1 = rand(1,d); else kvr1 = -rand(1,d); end
vt1 = kvt1.*(xntmp(k2,:) - xntmp(k1,:));
vr1 = kvr1.*(xntmp(1,:) - xntmp(k2,:));
u1t = (LB + UB)/2 + vt1 + vr1;
u1t = limitBounds(u1t,LB,UB);
new_Obj1 = fitnessFunc(u1t);
% Update instant global point xOin and the best individual
if new_Obj1 < ObjValPre(1)
    xIO = u1t;
    ObjVal(1) = new_Obj1;
else
    xIO = xntmp(1,:);
end
ist = 2;
xn(1,:) = xIO;
% Composite motion of the remaining individuals
for ith=ist:NP
    % Calculate vj and vij
    if ith==1 j = 1; else j = randi([1 ith-1]); end
    if rand > 0.5
        kvj = exp(1)^(-(j/NP)*(1/d)*norm((xIO - xntmp(j,:)),1)).*rand(1,d);
    else
        kvj = exp(1)^(-(1-j/NP)*(1/d)*norm((xIO - xntmp(j,:)),1)).*(-rand(1,d));
    end
    if rand > 0.5 kvij = rand(1,d); else kvij = -rand(1,d); end
    vj = kvj.*(xIO - xntmp(j,:));
    vij = kvij.*(xntmp(j,:) - xntmp(ith,:));
    % Update the movement of ith individual
    xntmp(ith,:) = xntmp(ith,:) + vij + vj;
    xntmp(ith,:) = limitBounds(xntmp(ith,:),LB,UB);
    new_Obji = fitnessFunc(xntmp(ith,:));
    xn(ith,:) = xntmp(ith,:);
    ObjVal(ith) = new_Obji;
end
% Ranking the individuals based on their objective function values
[ObjVal,Index] = sort(ObjVal);
xn = xn(Index,:);
if i==MaxGeneration     % convergence criteria
    xval = xn(1,:);     % because of no trial vector, so xIO is the 1st-ranked in xn
    fval = ObjVal(1);
    disp('_____________________________________________________')
    fprintf('Optimal solution of BCMO is found at generation: %i, fval = %s, xval = %s \n',i,mat2str(fval),mat2str(xval));
    break
end  
end   % End optimization loop
%% SAVE THE RESULTS
best=[xval fval];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% THIS FUNCTION IS USED TO CORRECT INDIVIDUALS OUT OF THE BOUNDS
function xn = limitBounds(xn,Lb,Ub)
xn_tmp = xn;
I = xn_tmp < Lb;
xn_tmp(I) = Lb(I);
J = xn_tmp > Ub;
xn_tmp(J) = Ub(J);
% Update the corrected individuals
xn = xn_tmp;
end