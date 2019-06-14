function F = recursive_main(P, M)
%递归法构造非支配集
% Pop:      待构造的种群
% M:        目标个数
% N:        个体数量
% D:        决策变量个数
if(M == 2)
    F = recursive_non_dom_sort_2D(P);
else
    [N, S] = size(P);
    D = S - M;

    P = [P, ones(N, 1)];                % 在每个个体后面加一个数字代表边界层次, 初始时为1.

    P = recursive_A(P, D, M);              % 第一层次递归

    max_Fs = max(P(:, end));            % 找到最大的Fs，建立cell
    F = cell(1, max_Fs);

    for i = 1: N
        Fs = P(i, end);
        F{Fs} = [F{Fs}; P(i, :)];
    end
    for i = 1:size(F, 2)
        F{i}(:, end) = [];
    end
end
end

