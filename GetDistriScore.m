clear;close;clc;
%% 创建问题、算法、目标数量索引cell
Problems  = {'DTLZ1', 'DTLZ2', 'DTLZ3', 'DTLZ4', 'DTLZ5'};
%Problems  = {'DTLZ5'};
KeepDisAlgorithms = {'gathering_distance','hyper_grid','cluster_basedon_centerpoint','cluster_basedon_clusterdis', 'cluster_basedon_coredis' };
Obj_nums = {'2', '3'};
%Obj_nums = {'2'};
%% 运行算法
Pro_num = size(Problems, 2);
KDAlg_num = size(KeepDisAlgorithms, 2);
Obj_num = size(Obj_nums, 2);
times = 4;

Matpathname = [fileparts(mfilename('fullpath')), '\Result\Score\'];

for i = 1:Pro_num
    Spread_s = zeros(Obj_num, KDAlg_num);
    Spacing_s = zeros(Obj_num, KDAlg_num);
    HV_s = zeros(Obj_num, KDAlg_num);
    for j = 1:Obj_num
        for k = 1:KDAlg_num
            Score = zeros(times,3);
            for l = 1:times
                SS = [Problems{i},'_',KeepDisAlgorithms{k},'_',Obj_nums{j},'_',num2str(l),'.mat'];
                S = load(SS);
                SolveSet = S.SolveSet;
                N = size(SolveSet, 1);
                P = PF(Problems{i}, N, str2double(Obj_nums{j}));
                Score(l,1) = Spacing(SolveSet, str2double(Obj_nums{j}), P);
                Score(l,2) = Spread(SolveSet, str2double(Obj_nums{j}), P);
                Score(l,3) = HV(SolveSet, str2double(Obj_nums{j}), P);
            end
            Spacing_s(j, k) = min(Score(:, 1));
            Spread_s(j, k) = min(Score(:, 2));
            HV_s(j, k) = max(Score(:, 3));
            [~,ind] = max(Score(:, 3));
            SS = [Problems{i},'_',KeepDisAlgorithms{k},'_',Obj_nums{j},'_',num2str(ind),'.mat'];
            S = load(SS);
            SolveSet = S.SolveSet;
            N = size(SolveSet, 1);
            P = PF(Problems{i}, N, str2double(Obj_nums{j}));
            close;
            fig = figure('Name',[Problems{i},' with ',KeepDisAlgorithms{k},' Obj_num: ', Obj_nums{j}]);
            if(Obj_nums{j}=='2')
                scatter(P(:,end-1),P(:,end),'d','MarkerFaceColor','k');
                hold on;
                scatter(SolveSet(:,end-1),SolveSet(:,end),'MarkerFaceColor','r');
                drawnow;
            elseif(Obj_nums{j}=='3')
                scatter3(P(:,end-2),P(:,end-1),P(:,end),'d','MarkerFaceColor','k');
                hold on;
                scatter3(SolveSet(:,end-2),SolveSet(:,end-1),SolveSet(:,end),'MarkerFaceColor','r');
                drawnow;
            end
            hold off;
            figurename = [Problems{i},'_',KeepDisAlgorithms{k},'_', Obj_nums{j}];
            saveas(fig,[Matpathname, figurename, '.jpg']);
        end
    end
    Name_Spacing = [Problems{i},'_Spacing'];
    Name_Spread = [Problems{i},'_Spread'];
    Name_HV = [Problems{i},'_HV'];
    save([Matpathname,Name_Spacing], 'Spacing_s');
    save([Matpathname,Name_Spread], 'Spread_s');
    save([Matpathname,Name_HV], 'HV_s');
end