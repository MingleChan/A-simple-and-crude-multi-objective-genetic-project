function core = cluster_basedon_coredis(NDSetWithVal, NIND, obj_num)
%基于类核距离的层次聚类算法
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
    Cluster{E} = ParentWithVal(E, :);           %生成N个聚类
end

while(size(Cluster, 2)~=NIND)
    N = size(Cluster, 2);
    core = zeros(N, V);
    for E = 1:N                         %先找出各个聚类的核
        S = size(Cluster{E}, 1);
        if(S==1)
            core(E,:) = Cluster{E};
        elseif(S==2)
            core(E,:) = Cluster{E}(randperm(2, 1), :);
        else
            disIbyI = pdist2(Cluster{E}(:, D+1:D+obj_num), Cluster{E}(:, D+1:D+obj_num)); 
            [~, min_ind] = min(sum(disIbyI, 2));
            core(E,:) = Cluster{E}(min_ind, :);
        end
    end
    discbyc = pdist2(core(:, D+1:D+obj_num), core(:, D+1:D+obj_num));
    discbyc(discbyc==0) = inf;
    [r, c] = find(discbyc==min(discbyc, [], 'all'));
    r = r(1); c = c(1);
    miner = min(r, c); maxer = max(r, c);
    Cluster{miner} = [Cluster{miner}; Cluster{maxer}];
    Cluster(maxer) = [];
end

N = size(Cluster, 2);
core = zeros(N, V);
for E = 1:N                         %先找出各个聚类的核
    S = size(Cluster{E}, 1);
    if(S==1)
        core(E,:) = Cluster{E};
    elseif(S==2)
        core(E,:) = Cluster{E}(randperm(2, 1), :);
    else
        disIbyI = pdist2(Cluster{E}(:, D+1:D+obj_num), Cluster{E}(:, D+1:D+obj_num));
        [~, min_ind] = min(sum(disIbyI, 2));
        core(E,:) = Cluster{E}(min_ind, :);
    end
end

end

