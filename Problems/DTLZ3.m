function PopWithValue = DTLZ3(Pop,obj_num)
%benchmarkŒ Ã‚DTLZ3
[N, D] = size(Pop);
M = obj_num;
g = 100*(D-M+1+sum((Pop(:,M:end)-0.5).^2-cos(20.*pi.*(Pop(:,M:end)-0.5)),2));
PopObj = repmat(1+g,1,M).*fliplr(cumprod([ones(N,1),cos(Pop(:,1:M-1)*pi/2)],2)).*[ones(N,1),sin(Pop(:,M-1:-1:1)*pi/2)];
PopWithValue = [Pop, PopObj];
end

