function F = arena_principle(Pop, M)
%��̨���������֧�伯
% Pop��  ��������Ⱥ
% M  ��  Ŀ���������
% N  ��  ��Ⱥ��С
% D  ��  ���߱�������

F = cell(1, 1);
E = 1;

Q = Pop;
while(size(Pop, 1)>0)
    NDSet = [];

    while(size(Q,1)>1)
        x = Q(1, :);
        Q(1, :) = [];
        sign = false; 
        Q_Copy = Q;
        p1 = 0;
        for i = 1:size(Q_Copy,1)
            y = Q_Copy(i, :);
            relation = dominate(x(1, :), y, M);
            if(relation==1)             % ���x֧��y�����y��Q��ȥ��   ==1)
                index = find(ismember(Q, y, 'rows'));
                Q(index, :) = [];           % �ҳ�y��Q�е��кŲ�ɾ��y
            elseif(relation==-1)         % ����y֧��x������y�滻��x
                x = y;
                V1 = y;
                index = find(ismember(Q, y, 'rows'));
                Q(index, :) = [];     
                sign = true;
            end
        end
        if(sign)                             % �����������̨����������������̨����ǰ��ı�������Ƚϲ���̭��������̨��֧��ĸ���
            V2 = V1;
            Q_Copy = Q;
            for k = 1:size(Q_Copy, 1)
                relation = dominate(V2, Q_Copy(k, :), M);
                if(relation==1)             % ���x֧��y�����y��Q��ȥ��
                    index = find(ismember(Q, Q_Copy(k, :), 'rows'));
                    Q(index, :) = [];           % �ҳ�y��Q�е��кŲ�ɾ��y
                end
            end                                 % ��֮ǰ��������֧�������̭�󣬽��������������֧�伯
            NDSet = [NDSet;V2];
        else                                    % ���û����������������ֱ�Ӱ���������������֧�伯
            NDSet = [NDSet;x];
        end  
    end
    NDSet = [NDSet;Q];
    F{E} = NDSet;
    E = E + 1;
    index = ~ismember(Pop, NDSet, 'rows');
    Pop = Pop(index, :);
    Q = Pop;
end
end

