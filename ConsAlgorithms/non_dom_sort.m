function F = non_dom_sort(Pop, M)
%��֧�����򷨹����֧�伯
% Pop��  ��������Ⱥ
% M  ��  Ŀ���������
% N  ��  ��Ⱥ��С
% D  ��  ���߱�������
[N, S] = size(Pop);
D = S - M;

F = cell(1, 1);
E = 1;

P = Pop;
while(size(P, 1)>0)
    NDSet = [];
    p = P(1, :);                             % ȡ����һ��������ʱ����NDSet
    NDSet = [NDSet; p];

    for i = 2:size(P,1)
        p = P(i, :);             
        NDSet = [NDSet; p];                  % ÿ�δ�P��ȡ��һ��������ʱ����NDSet��
        sign = true;

        NDSet_Copy = NDSet;
        for j = 1:(size(NDSet_Copy,1)-1)
            q = NDSet_Copy(j, :);
            relation = dominate(p(1, :), q(1, :), M);
            if(relation==1)             % ���p֧��q���ҳ���֧�������NDSet�е�λ�ò�ɾ��
                index = find(ismember(NDSet, NDSet_Copy(j,:), 'rows'));
                NDSet(index, :) = [];
            elseif(relation==-1)         
                sign = false;
            end
        end
        if(sign==false)
            NDSet(end,:) = [];
        end
    end
    F{E} = NDSet;
    E = E + 1;
    index = ~ismember(Pop, NDSet, 'rows');
    Pop = Pop(index, :);
    P = Pop;
end
end

