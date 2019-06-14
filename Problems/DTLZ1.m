function PopWithValue = DTLZ1(Pop,obj_num)
%benchmarkŒ Ã‚DTLZ1
[N, D] = size(Pop);
M = obj_num;
g = 100*(D-M+1+sum((Pop(:,M:end)-0.5).^2-cos(20.*pi.*(Pop(:,M:end)-0.5)),2));
PopObj = 0.5*repmat(1+g,1,M).*fliplr(cumprod([ones(N,1),Pop(:,1:M-1)],2)).*[ones(N,1),1-Pop(:,M-1:-1:1)];
PopWithValue = [Pop, PopObj];
end

