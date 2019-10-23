%% Generalized Rastrigin Function
%% Programmer: Thang Le-Duc
%% Email: thang.ld@vgu.edu.vn; le.duc.thang0312@gmail.com
function f = OptimProblem(x)
f=(sum(x.^2-10*cos(x.*2*pi)+10)); % Limited Bounds: [-5.12 5.12]; Min = 0
end   