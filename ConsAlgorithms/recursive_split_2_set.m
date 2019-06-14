function [L, H] = recursive_split_2_set(Pop, D, M, x_split)
%��Pop���ݵ�M��Ŀ��ֵ�ָ��L��H��������Ⱥ
N = size(Pop, 1);

L = Pop(find(Pop(:,D+M)<=x_split),:);
H = Pop(find(Pop(:,D+M)>x_split),:);

if(isempty(L)||isempty(H))
    L = Pop(1:floor(N/2),:);
    H = Pop((floor(N/2)+1):end,:);
end
end

