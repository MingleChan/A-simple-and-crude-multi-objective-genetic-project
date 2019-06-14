function H = recursive_B(L, H, D, M)
%递归法构造非支配集调用的第二层次的递归
[N_L, ~] = size(L);
[N_H, ~] = size(H);

if(N_L == 1)
    for i = 1: N_H
        le = 0; equal = 0; ge = 0;
        for j = 1: M
            if(L(1, D+j) < H(i, D+j))
                le = le + 1;
            elseif(L(1, D+j) == H(i, D+j))
                equal = equal + 1;
            else
                ge = ge + 1;
            end
        end
        if((le>0)&&(ge==0))          % 说明L1支配Hi， 更新Hi的边界层次
            H(i, end) = max((L(1, end)+1), H(i, end));
        elseif((le==0)&&(ge==0))
            le = 0; equal = 0; ge = 0;
            for k = M+1 : size(L, 2)-1-D
                if(L(1, D+k) < H(i, D+k))
                    le = le + 1;
                elseif(L(1, D+k) == H(i, D+k))
                    equal = equal + 1;
                else
                    ge = ge + 1;
                end
            end
            if((le>0)&&(ge==0))
                H(i, end) = max((L(1, end)+1), H(i, end));
            elseif((le==0)&&(ge==0))
                H(i, end) = L(1, end);
            end   
        end
    end
elseif(N_H == 1)
    for i = 1: N_L
        le = 0; equal = 0; ge = 0;
        for j = 1: M
            if(L(i, D+j) < H(1, D+j))
                le = le + 1;
            elseif(L(i, D+j) == H(1, D+j))
                equal = equal + 1;
            else
                ge = ge + 1;
            end
        end
        if((le>0)&&(ge==0))          % 说明Li支配H1， 更新H1的边界层次
            H(1, end) = max((L(i, end)+1), H(1, end));
        elseif((le==0)&&(ge==0))      % 说明H1支配Li， 更新Hi的边界层次
            le = 0; equal = 0; ge = 0;
            for k = M+1 : size(L, 2)-1-D
                if(L(i, D+k) < H(1, D+k))
                    le = le + 1;
                elseif(L(i, D+k) == H(1, D+k))
                    equal = equal + 1;
                else
                    ge = ge + 1;
                end
            end
            if((le>0)&&(ge==0))
                H(1, end) = max((L(i, end)+1), H(1, end));
            elseif((le==0)&&(ge==0))
                H(1, end) = L(i, end);
            end   
        end
    end
elseif(M == 2)    
    for i = 1: N_H
        for j = 1: N_L
            le = 0; equal = 0; ge = 0;
            for k = 1: 2
                if(L(j, D+k) < H(i, D+k))
                    le = le + 1;
                elseif(L(j, D+k) == H(i, D+k))
                    equal = equal + 1;
                else 
                    ge = ge + 1;
                end
            end
            if((le>0)&&(ge==0))          % 说明Lj支配Hi， 更新Hi的边界层次
                H(i, end) = max((L(j, end)+1), H(i, end));
            elseif((le==0)&&(ge==0))
                le = 0; equal = 0; ge = 0;
                for k = M+1 : size(L, 2)-1-D
                    if(L(j, D+k) < H(i, D+k))
                        le = le + 1;
                    elseif(L(j, D+k) == H(i, D+k))
                        equal = equal + 1;
                    else
                        ge = ge + 1;
                    end
                end
                if((le>0)&&(ge==0))
                    H(i, end) = max((L(j, end)+1), H(i, end));
                elseif((le==0)&&(ge==0))
                    H(i, end) = L(j, end);
                end
            end
        end
    end
else
    if(max(L(:, D+M)) <= min(H(:, D+M)))
        H = recursive_B(L, H, D, M-1);
    elseif(min(L(:, D+M)) <= max(H(:, D+M)))
        if(N_L > N_H)
            for i = 0: M-1
                L = sortrows(L, D+M-i);
            end
            x_M_split = L(floor(N_L/2), D+M);
        else
            for i = 0: M-1
                H = sortrows(H, D+M-i);
            end
            x_M_split = H(floor(N_H/2), D+M);
        end
        [L1, L2] = recursive_split_2_set(L, D, M, x_M_split);
        [H1, H2] = recursive_split_2_set(H, D, M, x_M_split);
        H1 = recursive_B(L1, H1, D, M);
        H2 = recursive_B(L1, H2, D, M-1);
        H2 = recursive_B(L2, H2, D, M);
        H = [H1; H2];
    end
end
end




