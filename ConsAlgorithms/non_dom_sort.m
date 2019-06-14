function F = non_dom_sort(Pop, M)
%非支配排序法构造非支配集
% Pop：  待操作种群
% M  ：  目标变量个数
% N  ：  种群大小
% D  ：  决策变量个数
[N, S] = size(Pop);
D = S - M;

F = cell(1, 1);
E = 1;

P = Pop;
while(size(P, 1)>0)
    NDSet = [];
    p = P(1, :);                             % 取出第一个个体暂时放入NDSet
    NDSet = [NDSet; p];

    for i = 2:size(P,1)
        p = P(i, :);             
        NDSet = [NDSet; p];                  % 每次从P中取出一个个体临时放入NDSet中
        sign = true;

        NDSet_Copy = NDSet;
        for j = 1:(size(NDSet_Copy,1)-1)
            q = NDSet_Copy(j, :);
            relation = dominate(p(1, :), q(1, :), M);
            if(relation==1)             % 如果p支配q，找出被支配个体在NDSet中的位置并删除
                index = find(ismember(NDSet, NDSet_Copy(j,:), 'rows'));
                NDSet(index, :) = [];
            elseif(relation==-1)         
                sign = false;
            end
        end
        if(sign==false)
            NDSet(end,:) = [];
        end
    end
    F{E} = NDSet;
    E = E + 1;
    index = ~ismember(Pop, NDSet, 'rows');
    Pop = Pop(index, :);
    P = Pop;
end
end

