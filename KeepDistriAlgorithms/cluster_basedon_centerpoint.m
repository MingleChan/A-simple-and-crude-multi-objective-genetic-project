function ResultWithVal = cluster_basedon_centerpoint(NDSetWithVal, NIND, obj_num)
%基于中心点的聚类方法
ParentWithVal = [];   

i = 1;
while((size(ParentWithVal,1) + size(NDSetWithVal{i},1))<=NIND)
    ParentWithVal = [ParentWithVal; NDSetWithVal{i}];
    i = i + 1;
end
ParentWithVal = [ParentWithVal; NDSetWithVal{i}];
N_P = size(ParentWithVal, 1);
cluster_num = [ones(NIND, 1);zeros(N_P-NIND, 1)];
ParentWithValandNum = [ParentWithVal, cluster_num];


Cluster = cell(1, 1);
for i = 1:NIND
    Cluster{i} = ParentWithValandNum(i, :);       
end
center = ParentWithValandNum(1:NIND, :); 
ext = ParentWithValandNum(NIND+1:end, :);
[N, V] = size(ext);
D = V - obj_num - 1;

%计算每个个体与各中心点的相似度并指派到相应的类中      
dis_pbyo = pdist2(ext(:, D+1:D+obj_num), center(:, D+1:D+obj_num));
[~, Index] = min(dis_pbyo,[],2);
for ind = 1:size(Index, 1)
    Cluster{Index(ind)} = [Cluster{Index(ind)} ; ext(ind, :)];
end
E = 0;                                  %计算评价函数E
for i = 1:NIND
    j = size(Cluster{i}, 1);
    if(j>=2)
        o = Cluster{i}(Cluster{i}(:, end)==1,:);
        p = Cluster{i}(Cluster{i}(:, end)==0,:);
        E = sum(pdist2(o(1, D+1:D+obj_num), p(:, D+1:D+obj_num)),'all');
    end
end
for t = 1:5
    new_center = zeros(NIND, V);
    for i = 1:NIND                          %变换中心点
        j = size(Cluster{i}, 1);
        if(j>=2)
            o_w = Cluster{i}(Cluster{i}(:, end)==0,:);
            new_center(i, :) = o_w(randperm(size(o_w, 1), 1), :);
        else
            new_center(i, :) = Cluster{i};
        end
    end
    ext2 = ParentWithValandNum(~ismember(ParentWithValandNum, new_center, 'rows'), :);    %变换中心点后剩下的个体
    N = size(ext2, 1);   
    dis_pbyo = pdist2(ext2(:, D+1:D+obj_num), new_center(:, D+1:D+obj_num));
    [~, Index] = min(dis_pbyo,[],2);
    E_w = 0;
    for i = 1:size(Index)
        E_w = E_w + pdist2(ext2(i, D+1:D+obj_num), new_center(Index(i), D+1:D+obj_num));
    end
    if(E_w<E)
        ParentWithValandNum(ismember(ParentWithValandNum(:,1:end-1), new_center(:,1:end-1), 'rows'), end) = 1;
        ParentWithValandNum(~ismember(ParentWithValandNum(:,1:end-1), new_center(:,1:end-1), 'rows'), end) = 0;
        new_center(:, end) = 1;
        ext2(:, end) = 0;
        for i = 1:NIND
            Cluster{i} =  new_center(i,:);
        end
        for ind = 1:size(Index, 1)
            Cluster{Index(ind)} = [Cluster{Index(ind)} ; ext2(ind, :)];
        end
        E = E_w;
    end
end
ResultWithVal = ParentWithValandNum(ParentWithValandNum(:, end)==1, 1:end-1);
end


