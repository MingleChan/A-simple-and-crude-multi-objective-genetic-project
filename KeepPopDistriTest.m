%% 清空环境变量
%clear;close;clc;
cd(fileparts(mfilename('fullpath')));
addpath(genpath(cd));   
%% 创建问题、算法、目标数量索引cell
% Problems  = {'DTLZ1', 'DTLZ2', 'DTLZ3', 'DTLZ4', 'DTLZ5'};
Problems  = {'DTLZ1', 'DTLZ2', 'DTLZ3', 'DTLZ4', 'DTLZ5'};
KeepDisAlgorithms = {'gathering_distance','hyper_grid','cluster_basedon_centerpoint','cluster_basedon_clusterdis', 'cluster_basedon_coredis' };
% KeepDisAlgorithms = {'cluster_basedon_centerpoint','cluster_basedon_clusterdis', 'cluster_basedon_coredis'};
% Obj_nums = {'2', '3'};
Obj_nums = {'2', '3'};
%% 运行算法
Pro_num = size(Problems, 2);
KDAlg_num = size(KeepDisAlgorithms, 2);
Obj_num = size(Obj_nums, 2);
times = 4;

Matpathname = [fileparts(mfilename('fullpath')), '\Result\MAT2\'];

for i = 1:Pro_num
    for j = 1:Obj_num
        switch Problems{i}
            case 'DTLZ1'           % 决策变量个数
                decision_num = str2double(Obj_nums{j})  + 4;
            otherwise
                decision_num = str2double(Obj_nums{j})  + 9;
        end
        switch str2double(Obj_nums{j})                     
            case 2
                NIND = 100;  MAXGEN = 300; 
            case 3
                NIND = 200;  MAXGEN = 500; 
        end
        arg = [str2double(Obj_nums{j}), decision_num, NIND, MAXGEN];

        minvalue = repmat(zeros(1,decision_num),NIND,1);               %个体最小值
        maxvalue = repmat(ones(1,decision_num),NIND,1);                %个体最大值    
        Pop = rand(NIND,decision_num).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群
        for k = 1:KDAlg_num
            for l = 1:times
                SolveSet = GA(Pop, arg,  'quick_sort', KeepDisAlgorithms{k}, Problems{i});
                SolveSetName = [Problems{i},'_',KeepDisAlgorithms{k},'_', Obj_nums{j},'_',num2str(l)];
                save([Matpathname,SolveSetName], 'SolveSet');
            end
        end
    end
end