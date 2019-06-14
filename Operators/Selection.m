function newPop = Selection(Pop, obj_num)
[N, V] = size(Pop);
newPop = zeros(N, V);
for i = 1:N
    sel = randperm(N, 2);
    val = dominate(Pop(sel(1),:), Pop(sel(2),:), obj_num);
    if(val==1)
        newPop(i,:) = Pop(sel(1),:);
    elseif(val==-1)
        newPop(i,:) = Pop(sel(2),:);
    else
        newPop(i,:) = Pop(sel(randperm(2,1)),:);
    end
end
end

