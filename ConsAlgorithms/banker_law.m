function F = banker_law(Pop, M)
%ׯ�ҷ������֧�伯
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

    while(size(Q, 1)>0)
        x = Q(1, :);
        Q(1, :) = [];
        x_is_nondom = true;                         % ��֧���־

        Q_Copy = Q;
        for i = 1:size(Q_Copy,1)
            y = Q_Copy(i, :);
            relation = dominate(x(1, :), y(1, :), M);
            if(relation==1)             % ���x֧��y�����y��Q��ȥ��
                index = find(ismember(Q, y, 'rows'));
                Q(index, :) = [];           % �ҳ�y��Q�е��кŲ�ɾ��y
            elseif(relation==-1)         % ����y֧��x�����־��֧���־��Ϊfalse
                x_is_nondom = false;
            end
        end
        if(x_is_nondom)
            NDSet = [NDSet; x];
        end
    end 
    F{E} = NDSet;
    E = E + 1;
    index = ~ismember(Pop, NDSet, 'rows');
    Pop = Pop(index, :);
    Q = Pop;
end
end
