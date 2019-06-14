function relation = dominate(x, y, M)
%�Ƚ�x��y��֧���ϵ
% ����ֵ��
%        1�� x ֧�� y
%        0:  x ���� y
%       -1:  y ֧�� x
%        2:  x y�޹�
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

