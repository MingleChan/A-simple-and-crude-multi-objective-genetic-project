function P = recursive_A(P, D, M)
%�ݹ鷨�����֧�伯���õĵ�һ��εĵݹ�
[N, ~] = size(P);

if(N == 2)
    le = 0; equal = 0; ge = 0;
    for i = 1: M
        if(P(1, D+i) < P(2, D+i))
            le = le + 1;
        elseif(P(1, D+i) == P(2, D+i))
            equal = equal + 1;
        else
            ge = ge + 1;
        end
    end
    if((le>0)&&(ge==0))          % ˵��P1֧��P2�� ����P2�ı߽���
        P(2, end) = max((P(1, end)+1), P(2, end));
    elseif((le==0)&&(ge>0))      % ˵��P2֧��P1�� ����P1�ı߽���
        P(1, end) = max((P(2, end)+1), P(1, end));
    end
    
elseif(N > 2)
    for i = 0: M-1
        P = sortrows(P, D+M-i);
    end
    x_M_split = P(floor(N/2), D+M);
    [L, H] = recursive_split_2_set(P, D, M, x_M_split);
    L = recursive_A(L, D, M);
    H = recursive_B(L, H, D, M-1);
    H = recursive_A(H, D, M);
    P = [L; H];
end

end

