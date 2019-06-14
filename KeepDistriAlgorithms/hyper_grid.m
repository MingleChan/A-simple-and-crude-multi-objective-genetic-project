function newParentWithVal = hyper_grid(NDSetWithVal, NIND, obj_num)
%网格法保持种群分布性

div = 100;

newParentWithVal = [];   

i = 1;
while((size(newParentWithVal,1) + size(NDSetWithVal{i},1))<=NIND)
    newParentWithVal = [newParentWithVal; NDSetWithVal{i}];
    i = i + 1;
end
newParentWithVal = [newParentWithVal; NDSetWithVal{i}];

[~, V] = size(newParentWithVal);
D = V - obj_num;

while(size(newParentWithVal, 1)~=NIND)
    fmax = max(newParentWithVal(:, D+1:end),[],1);
    fmin = min(newParentWithVal(:, D+1:end),[],1);
    d    = (fmax-fmin)/div;
    GLoc = floor((newParentWithVal(:, D+1:end)-repmat(fmin,size(newParentWithVal(:, D+1:end),1),1))./repmat(d,size(newParentWithVal(:, D+1:end),1),1));
    GLoc(GLoc>=div)   = div - 1;
    GLoc(isnan(GLoc)) = 0;

    [~,~,Site] = unique(GLoc,'rows');
    CrowdG              = histc(Site,1:max(Site));
    [~, max_index_inCrowdG] = max(CrowdG);
    wateDel = find(Site==max_index_inCrowdG);
    wateDel = wateDel(1, 1);
    newParentWithVal(wateDel, :) = [];
end
end
