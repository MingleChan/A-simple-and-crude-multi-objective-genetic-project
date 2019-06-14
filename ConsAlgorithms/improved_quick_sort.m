function F = improved_quick_sort(Pop, M)
%用改进快速排序法进行非支配集构造
F = cell(1, 1);
E = 1;

P = Pop;
while(size(Pop,1)>0)
    NDSet = [];
    i = 1; j = size(Pop, 1);
    while(size(P, 1)>1)
        x = P(1, :);
        x_is_nd = true;
        y_is_nd = true;
        y_is_empty = true;
        while(i<j)
            while((i<j)&&((dominate(x, P(j, :), M)==1)||((~y_is_empty)&&(dominate(y, P(j, :), M)==1))))
                j = j - 1;
            end
            if(dominate(x, P(j, :), M)==-1)
                x_is_nd = false;
            end
            if((~y_is_empty)&&(dominate(y, P(j, :), M)==-1))
                y_is_nd = false;
            end
            if((y_is_empty)&&(i<j))
                y = P(j, :);
                y_is_empty = false;
                j = j - 1;
            end
            if(i<j)
                P(i, :) = P(j, :);
            end
            while((i<j)&&(dominate(P(i, :), x, M)>=0))
                if((~y_is_empty)&&(dominate(y, P(i, :), M)==1))
                    break;
                end
                if(dominate(x, P(i, :), M)==-1)
                    x_is_nd = false;
                end
                if((~y_is_empty)&&(dominate(y, P(i, :), M)==-1))
                    y_is_nd = false;
                end
                i = i + 1;
            end 
            if(i<j)
                P(j, :) = P(i, :);
            end
        end
        if((~y_is_empty)&&(y_is_nd))
            NDSet = [NDSet; y];
        end
        if(x_is_nd)
            NDSet = [NDSet; x];
        end
        j = i - 1;
        i = 1;
        P = P(i:j, :);
    end
    NDSet  = [NDSet; P(:, :)];
    F{E} = NDSet;
    E = E + 1;
    index = ~ismember(Pop, NDSet, 'rows');
    Pop = Pop(index, :);
    P = Pop;
end

end

