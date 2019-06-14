function Offspring = cross(Pop)
%模拟二进制交叉函数
[proC, disC] = deal(1, 20);
Parent1 = Pop(1:floor(end/2),:);
Parent2 = Pop(floor(end/2)+1:floor(end/2)*2,:);
[N,D]   = size(Parent1);

beta = zeros(N,D);
mu   = rand(N,D);
beta(mu<=0.5) = (2*mu(mu<=0.5)).^(1/(disC+1));
beta(mu>0.5)  = (2-2*mu(mu>0.5)).^(-1/(disC+1));
beta = beta.*(-1).^randi([0,1],N,D);
beta(rand(N,D)<0.5) = 1;
beta(repmat(rand(N,1)>proC,1,D)) = 1;
Offspring = [(Parent1+Parent2)/2+beta.*(Parent1-Parent2)/2
             (Parent1+Parent2)/2-beta.*(Parent1-Parent2)/2];
end

