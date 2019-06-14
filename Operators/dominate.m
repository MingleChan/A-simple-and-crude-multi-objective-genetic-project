function relation = dominate(x, y, M)
%比较x和y的支配关系
% 返回值：
%        1： x 支配 y
%        0:  x 等于 y
%       -1:  y 支配 x
%        2:  x y无关
%%%%%%%%%%%%%%%%%%%
D = size(x, 2) - M;

le = 0; equal = 0; ge = 0;
for i = 1: M
    if(x(1, D+i) < y(1, D+i))
        le = le + 1;
    elseif(x(1, D+i) == y(1, D+i))
        equal = equal + 1;
    else
        ge = ge + 1;
    end
end
if((le > 0)&&(ge == 0))
    relation = 1;
elseif((le == 0)&&(ge == 0)&&(equal > 0))
    relation = 0;
elseif((le == 0)&&(ge > 0))
    relation = -1;
else
    relation = 2;
end

end

