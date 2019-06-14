function F = arena_principle(Pop, M)
%擂台赛法则构造非支配集
% Pop：  待操作种群
% M  ：  目标变量个数
% N  ：  种群大小
% D  ：  决策变量个数

F = cell(1, 1);
E = 1;

Q = Pop;
while(size(Pop, 1)>0)
    NDSet = [];

    while(size(Q,1)>1)
        x = Q(1, :);
        Q(1, :) = [];
        sign = false; 
        Q_Copy = Q;
        p1 = 0;
        for i = 1:size(Q_Copy,1)
            y = Q_Copy(i, :);
            relation = dominate(x(1, :), y, M);
            if(relation==1)             % 如果x支配y，则把y从Q中去掉   ==1)
                index = find(ismember(Q, y, 'rows'));
                Q(index, :) = [];           % 找出y在Q中的行号并删除y
            elseif(relation==-1)         % 若是y支配x，则用y替换掉x
                x = y;
                V1 = y;
                index = find(ismember(Q, y, 'rows'));
                Q(index, :) = [];     
                sign = true;
            end
        end
        if(sign)                             % 如果发生了擂台主交换，则将最后的擂台主与前面的保留个体比较并淘汰被最新擂台主支配的个体
            V2 = V1;
            Q_Copy = Q;
            for k = 1:size(Q_Copy, 1)
                relation = dominate(V2, Q_Copy(k, :), M);
                if(relation==1)             % 如果x支配y，则把y从Q中去掉
                    index = find(ismember(Q, Q_Copy(k, :), 'rows'));
                    Q(index, :) = [];           % 找出y在Q中的行号并删除y
                end
            end                                 % 将之前被保留的支配个体淘汰后，将最后的擂主并入非支配集
            NDSet = [NDSet;V2];
        else                                    % 如果没发生擂主交换，则直接把最初的擂主并入非支配集
            NDSet = [NDSet;x];
        end  
    end
    NDSet = [NDSet;Q];
    F{E} = NDSet;
    E = E + 1;
    index = ~ismember(Pop, NDSet, 'rows');
    Pop = Pop(index, :);
    Q = Pop;
end
end

