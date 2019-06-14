function ResultPopWithVal = EMOA_BasedOn_NSGA2(varargin)
%�����ʽ��EMOA_BasedOn_NSGA2('ConsAlgorithm','non_dom_sort','Problem','DTLZ1','Obj_num','2');
%clear;
%close;clc;
defaultConsAlgorithm = 'non_dom_sort';
expectConsAlgorithm = {'non_dom_sort','exclusions','banker_law','arena_principle','quick_sort','improved_quick_sort'};
defaultProblem = 'DTLZ1';
expectProblem = {'DTLZ1','DTLZ2','DTLZ3','DTLZ4','DTLZ5'};
defaultObjnum = '2';
expectObjnum = {'2','3','4','6','8'};

p = inputParser;
addParameter(p,'ConsAlgorithm', defaultConsAlgorithm, @(x) any(validatestring(x,expectConsAlgorithm)));
addParameter(p,'Problem', defaultProblem, @(x) any(validatestring(x,expectProblem)));
addParameter(p,'Obj_num', defaultObjnum, @(x) any(validatestring(x,expectObjnum)));
parse(p, varargin{:});

obj_num = str2double(p.Results.Obj_num);

switch p.Results.Problem
    case 'DTLZ1'           % ���߱�������
        decision_num = obj_num + 4;
    otherwise
        decision_num = obj_num + 9;
end

switch obj_num              % ��Ⱥ��С�ͽ�������
    case 2
        NIND = 100;  MAXGEN = 200; 
    case 3
        NIND = 200;  MAXGEN = 300; 
    case 4
        NIND = 300;  MAXGEN = 400; 
    case 6
        NIND = 500;  MAXGEN = 600; 
    case 8
        NIND = 600;  MAXGEN = 800; 
end

arg = [obj_num, decision_num, NIND, MAXGEN];

minvalue = repmat(zeros(1,decision_num),NIND,1);               %������Сֵ
maxvalue = repmat(ones(1,decision_num),NIND,1);                %�������ֵ    
Pop = rand(NIND,decision_num).*(maxvalue-minvalue)+minvalue;    %�����µĳ�ʼ��Ⱥ

P = PF(p.Results.Problem, NIND, obj_num);

figure;
if(obj_num==2)
    scatter(P(:,end-1),P(:,end),'d','MarkerFaceColor','r','MarkerEdgeColor','r');
elseif(obj_num==3)
    scatter3(P(:,end-2),P(:,end-1),P(:,end),'d','MarkerFaceColor','r','MarkerEdgeColor','r');
end

ResultPopWithVal = GA(Pop, arg, p.Results.ConsAlgorithm, 'gathering_distance', p.Results.Problem);

end

