function F = exclusions(Pop, M)
%排除法构造非支配集
% Pop：  待操作种群
% M  ：  目标变量个数
% N  ：  种群大小
% D  ：  决策变量个数
[N, S] = size(Pop);
D = S - M;

F = cell(1, 1);
E = 1;

Q = Pop;
while(size(Pop,1)>0)
    NDSet = [];

    while(size(Q, 1)>1)
        sign = true;                         % 非支配标志
        p = Q(1, :);
        Q(1, :) = [];
        Union = [Q; NDSet];                  % 将p与Q中剩余个体和已经放入NDSet的个体都要比较
        for i = 1 : size(Union, 1)
            q = Union(i, :);
            relation = dominate(p(1, :), q(1, :), M);
            if(relation==1)             % 如果p支配q，则把q从Q中去掉
                index = find(ismember(Q, q, 'rows'));
                Q(index, :) = [];           % 找出q在Q中的行号并删除q
            elseif(relation==-1)         % 若是q支配p，则标志非支配标志改为false
                sign = false;
            end
        end
        if(sign)
            NDSet = [NDSet; p];
        end
    end
    NDSet = [NDSet; Q];                     % 当Q中仅剩1个或0个个体时，必然是非支配个体，直接并入非支配集
    F{E} = NDSet;
    E = E + 1;
    index = ~ismember(Pop, NDSet, 'rows');
    Pop = Pop(index, :);
    Q = Pop;
end
end

