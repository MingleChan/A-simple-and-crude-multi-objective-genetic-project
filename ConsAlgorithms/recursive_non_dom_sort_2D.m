function F = recursive_non_dom_sort_2D(P)
%针对两个目标优化问题构造非支配集
[N, S] = size(P);

P = sortrows(P,[S-1, S]);
F = cell(1, 1);
F{1} = P(1, :);
E = 1;

for i = 2:N
    N_Fe = size(F{E}, 1);
    nd = 0; d = 0;
    for j = 1:N_Fe
        if((P(i,S-1)==F{E}(j,S-1))&&(P(i,S)==F{E}(j,S)))            % 如果Pi与F{E}中某一元素相同，则直接并入F{E}
             break;
        elseif((P(i,S-1)>F{E}(j,S-1))&&(P(i,S)<F{E}(j,S)))         
            nd = nd + 1;
        else
            d = d + 1;
        end
    end
    if((nd==0)&&(d==0))
        F{E} = [F{E}; P(i,:)];
    elseif((nd>0)&&(d==0))                                          % 如果Pi不被F{E}支配，则寻找最小的b，将Pi并入Fb                    
        N_F = size(F, 2);
        for b = 1:N_F
            N_Fe_in = size(F{b}, 1);
            nd_in = 0; d_in = 0;
            for l = 1:N_Fe_in
                if((P(i,S-1)==F{b}(l,S-1))&&(P(i,S)==F{b}(l,S)))
                     break;
                elseif((P(i,S-1)>F{b}(l,S-1))&&(P(i,S)<F{b}(l,S)))
                    nd_in = nd_in + 1;
                else
                    d_in = d_in + 1;
                end
            end
            if((nd_in>=0)&&(d_in==0))  
                F{b} = [F{b}; P(i,:)];break;  
            end
        end
    else
        E = E + 1;
        F{E} = P(i,:);
    end
end
end

