function ResultWithVal = cluster_basedon_clusterdis(NDSetWithVal, NIND, obj_num)
%基于类距离的层次聚类算法
ParentWithVal = [];   

i = 1;
while((size(ParentWithVal,1) + size(NDSetWithVal{i},1))<=NIND)
    ParentWithVal = [ParentWithVal; NDSetWithVal{i}];
    i = i + 1;
end
ParentWithVal = [ParentWithVal; NDSetWithVal{i}];

[N, V] = size(ParentWithVal);
D = V - obj_num;

Cluster = cell(1, 1);
for E = 1:N
    Cluster{E} = ParentWithVal(E, :);
end

while(size(Cluster, 2)~=NIND)
    N = size(Cluster, 2);
    disCbyC = zeros(N, N);
    for i = 1:N
        for j = i:N
            disCbyC(i, j) = sum(pdist2(Cluster{i}(:, D+1:D+obj_num), Cluster{j}(:, D+1:D+obj_num)),'all');
        end
    end
    disCbyC(disCbyC==0) = inf;
    [r, c] = find(disCbyC==min(disCbyC, [], 'all'));
    r = r(1); c = c(1);
    miner = min(r, c); maxer = max(r, c);
    Cluster{miner} = [Cluster{miner}; Cluster{maxer}];
    Cluster(maxer) = [];
end
ResultWithVal = [];
for E = 1:NIND
    N = size(Cluster{E}, 1);
    if(N==1)
        ResultWithVal = [ResultWithVal; Cluster{E}];
    elseif(N==2)
        ResultWithVal = [ResultWithVal; Cluster{E}(randperm(2, 1), :)];
    else
        disIbyI = zeros(N, N);
        disIbyI = pdist2(Cluster{E}(:, D+1:D+obj_num), Cluster{E}(:, D+1:D+obj_num));
        [~, min_ind] = min(sum(disIbyI, 2));
        ResultWithVal = [ResultWithVal; Cluster{E}(min_ind, :)];
    end
end
end

