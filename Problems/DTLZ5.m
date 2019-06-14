function PopWithValue = DTLZ5(Pop,obj_num)
%benchmarkŒ Ã‚DTLZ5
M = obj_num;
g = sum((Pop(:,M:end)-0.5).^2,2);
Temp   = repmat(g,1,M-2);
Pop(:,2:M-1) = (1+2*Temp.*Pop(:,2:M-1))./(2+2*Temp);
PopObj = repmat(1+g,1,M).*fliplr(cumprod([ones(size(g,1),1),cos(Pop(:,1:M-1)*pi/2)],2)).*[ones(size(g,1),1),sin(Pop(:,M-1:-1:1)*pi/2)];
PopWithValue = [Pop, PopObj];
end

