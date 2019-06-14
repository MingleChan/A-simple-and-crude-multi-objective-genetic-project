function F = quick_sort(Pop, M)
%快速排序法构造非支配集
F = cell(1, 1);
E = 1;

P = Pop;
while(size(Pop,1)>0)
    NDSet = [];
    i = 1; j = size(Pop, 1);
    while(size(P, 1)>1)
        x = P(1, :);
        non_dominated_sign = true;
        while(i<j)
            while((i<j)&&(dominate(x, P(j, :), M)==1))
                j = j - 1;
            end
            if(i<j)
                if(dominate(x, P(j, :), M)==-1)
                    non_dominated_sign = false;
                end
                P(i, :) = P(j, :);
                i = i + 1;
            end
            while((i<j)&&(dominate(P(i, :), x, M)>=0))
                if(dominate(x, P(i, :), M)==-1)
                    non_dominated_sign = false;
                end
                i = i + 1;
            end 
            if(i<j)
                P(j, :) = P(i, :);
                j = j - 1;
            end
        end
        if(non_dominated_sign)
            NDSet = [NDSet; x];
        end
        j = i - 1;
        i = 1;
        P = P(i:j, :);
    end
    NDSet = [NDSet; P(:, :)];
    F{E} = NDSet;
    E = E + 1;
    index = ~ismember(Pop, NDSet, 'rows');
    Pop = Pop(index, :);
    P = Pop;
end

end

