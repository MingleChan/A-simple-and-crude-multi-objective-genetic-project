function F = exclusions(Pop, M)
%�ų��������֧�伯
% Pop��  ��������Ⱥ
% M  ��  Ŀ���������
% N  ��  ��Ⱥ��С
% D  ��  ���߱�������
[N, S] = size(Pop);
D = S - M;

F = cell(1, 1);
E = 1;

Q = Pop;
while(size(Pop,1)>0)
    NDSet = [];

    while(size(Q, 1)>1)
        sign = true;                         % ��֧���־
        p = Q(1, :);
        Q(1, :) = [];
        Union = [Q; NDSet];                  % ��p��Q��ʣ�������Ѿ�����NDSet�ĸ��嶼Ҫ�Ƚ�
        for i = 1 : size(Union, 1)
            q = Union(i, :);
            relation = dominate(p(1, :), q(1, :), M);
            if(relation==1)             % ���p֧��q�����q��Q��ȥ��
                index = find(ismember(Q, q, 'rows'));
                Q(index, :) = [];           % �ҳ�q��Q�е��кŲ�ɾ��q
            elseif(relation==-1)         % ����q֧��p�����־��֧���־��Ϊfalse
                sign = false;
            end
        end
        if(sign)
            NDSet = [NDSet; p];
        end
    end
    NDSet = [NDSet; Q];                     % ��Q�н�ʣ1����0������ʱ����Ȼ�Ƿ�֧����壬ֱ�Ӳ����֧�伯
    F{E} = NDSet;
    E = E + 1;
    index = ~ismember(Pop, NDSet, 'rows');
    Pop = Pop(index, :);
    Q = Pop;
end
end

