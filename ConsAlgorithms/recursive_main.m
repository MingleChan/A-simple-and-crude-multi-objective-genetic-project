function F = recursive_main(P, M)
%�ݹ鷨�����֧�伯
% Pop:      ���������Ⱥ
% M:        Ŀ�����
% N:        ��������
% D:        ���߱�������
if(M == 2)
    F = recursive_non_dom_sort_2D(P);
else
    [N, S] = size(P);
    D = S - M;

    P = [P, ones(N, 1)];                % ��ÿ����������һ�����ִ���߽���, ��ʼʱΪ1.

    P = recursive_A(P, D, M);              % ��һ��εݹ�

    max_Fs = max(P(:, end));            % �ҵ�����Fs������cell
    F = cell(1, max_Fs);

    for i = 1: N
        Fs = P(i, end);
        F{Fs} = [F{Fs}; P(i, :)];
    end
    for i = 1:size(F, 2)
        F{i}(:, end) = [];
    end
end
end

