function F = banker_law(Pop, M)
%庄家法则构造非支配集
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

    while(size(Q, 1)>0)
        x = Q(1, :);
        Q(1, :) = [];
        x_is_nondom = true;                         % 非支配标志

        Q_Copy = Q;
        for i = 1:size(Q_Copy,1)
            y = Q_Copy(i, :);
            relation = dominate(x(1, :), y(1, :), M);
            if(relation==1)             % 如果x支配y，则把y从Q中去掉
                index = find(ismember(Q, y, 'rows'));
                Q(index, :) = [];           % 找出y在Q中的行号并删除y
            elseif(relation==-1)         % 若是y支配x，则标志非支配标志改为false
                x_is_nondom = false;
            end
        end
        if(x_is_nondom)
            NDSet = [NDSet; x];
        end
    end 
    F{E} = NDSet;
    E = E + 1;
    index = ~ismember(Pop, NDSet, 'rows');
    Pop = Pop(index, :);
    Q = Pop;
end
end
