function P = PF(Problem, N, M)
switch(Problem)
    case 'DTLZ1'
        P = UniformPoint(N,M)/2;
    case 'DTLZ2'
        P = UniformPoint(N,M);
        P = P./repmat(sqrt(sum(P.^2,2)),1,M);
    case 'DTLZ3'
        P = UniformPoint(N,M);
        P = P./repmat(sqrt(sum(P.^2,2)),1,M);
    case 'DTLZ4'
        P = UniformPoint(N,M);
        P = P./repmat(sqrt(sum(P.^2,2)),1,M);
    case 'DTLZ5'
        P = [0:1/(N-1):1;1:-1/(N-1):0]';
        P = P./repmat(sqrt(sum(P.^2,2)),1,size(P,2));
        P = [P(:,ones(1,M-2)),P];
        P = P./sqrt(2).^repmat([M-2,M-2:-1:0],size(P,1),1);
end
end

