%% 清空环境变量
%clear;close;clc;
%% 创建问题、算法、目标数量索引cell
%parpool('local',2);
cd(fileparts(mfilename('fullpath')));
addpath(genpath(cd));   

Problems  = {'DTLZ1','DTLZ2','DTLZ3','DTLZ4','DTLZ5'};
ConsAlgorithms = {'non_dom_sort','exclusions','banker_law','arena_principle','quick_sort','improved_quick_sort'};
Obj_nums = {'2','3','4','6','8'};
%% 运行算法
Pro_num = size(Problems, 2);
ConsAlg_num = size(ConsAlgorithms, 2);
Obj_num = size(Obj_nums, 2);
times = 4;

Matpathname = [fileparts(mfilename('fullpath')), '\Result\MAT\'];

for i = 1:Pro_num
    TimeArray = zeros(Obj_num, ConsAlg_num);
    for j = 1:ConsAlg_num
        for k = 1:Obj_num
            tic;
            for l = 1:times
                if(Obj_nums{k}=='2'||Obj_nums{k}=='3')
                    subplot(2,2,l);
                end
                SolveSet = EMOA_BasedOn_NSGA2('Problem',Problems{i},'ConsAlgorithm',ConsAlgorithms{j},'Obj_num',Obj_nums{k});
                SolveSetName = [Problems{i},'_',ConsAlgorithms{j},'_', Obj_nums{k},'_',num2str(l)];
                save([Matpathname,SolveSetName], 'SolveSet');
            end
            timeAvg = toc/times;
            fprintf("%s问题采用%s算法，目标数为%s时，运行%d次的平均时间：%fs\n",Problems{i},ConsAlgorithms{j},Obj_nums{k},times,timeAvg);
            TimeArray(k,j) = timeAvg;
        end
    end
    CPUtimefilename = [Problems{i},'_CPUtime.mat'];
    save([Matpathname,CPUtimefilename], 'TimeArray');
end