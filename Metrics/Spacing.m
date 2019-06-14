function Score = Spacing(PopWithVal,M, ~)
% <metric> <min>
% Spacing

PopObj = PopWithVal(:, size(PopWithVal,2)-M+1:end);
Distance = pdist2(PopObj,PopObj,'cityblock');
Distance(logical(eye(size(Distance,1)))) = inf;
Score    = std(min(Distance,[],2));
end