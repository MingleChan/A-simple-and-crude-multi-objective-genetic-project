function newParentWithVal = gathering_distance(NDSetWithVal, NIND, obj_num)
%聚集密度法保持种群分布性

newParentWithVal = [];   

i = 1;
while((size(newParentWithVal,1) + size(NDSetWithVal{i},1))<=NIND)
    newParentWithVal = [newParentWithVal; NDSetWithVal{i}];
    i = i + 1;
end

[N, V] = size(NDSetWithVal{i});
D = V - obj_num;
Individual_dis = zeros(N, 1);
SetWithValandDis = [NDSetWithVal{i}, Individual_dis];    % 把每个个体的聚集距离附加在最后一列

for m = 1:obj_num
    SetWithValandDis = sortrows(SetWithValandDis, D+m);
    for i = 2:N-1
        SetWithValandDis(i, end) = SetWithValandDis(i, end) + (SetWithValandDis(i+1, D+m) - SetWithValandDis(i-1, D+m));
    end
    SetWithValandDis(1, end) = inf;
end

SetWithValandDis = sortrows(SetWithValandDis, V+1, 'descend');
SetWithVal = SetWithValandDis(:, 1:end-1);

Ind = NIND - size(newParentWithVal, 1);
newParentWithVal = [newParentWithVal;SetWithVal(1:Ind, :)];
end
