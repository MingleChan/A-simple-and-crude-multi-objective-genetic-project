function newParentWithVal = GA(Pop, arg, ConsFun, KeepDisFun, Problems)

[obj_num, decision_num, NIND, MAXGEN] = deal(arg(1), arg(2), arg(3), arg(4));
ub = 1; lb = 0;             % 决策变量边界

ConsAlgorithm = str2func(ConsFun);
KeepDisAlgorithm = str2func(KeepDisFun);
Problem = str2func(Problems);
figure;
for gen = 1:MAXGEN
    ParentPopWithVal = Problem(Pop, obj_num);                        %求出父代的函数值
    ChildPopWithVal = Selection(ParentPopWithVal, obj_num);          %二元锦标赛选择
    ChildPop = ChildPopWithVal(:,1:decision_num);
    ChildPop = cross(ChildPop);              %模拟二进制交叉
    ChildPop = mutation(ChildPop,lb,ub);              %多项式变异
    ChildPopWithVal = Problem(ChildPop, obj_num);             %求出子代的函数值
    
    UnionPopWithVal = [ParentPopWithVal;ChildPopWithVal];                       %合并父代和子代
    NDSetWithVal = ConsAlgorithm(UnionPopWithVal, obj_num);                     %求出非支配集
    newParentWithVal = KeepDisAlgorithm(NDSetWithVal, NIND, obj_num);         %拥挤距离
    
    Pop = newParentWithVal(:, 1:decision_num);
    cla();
    if(obj_num==2)
        scatter(newParentWithVal(:,decision_num+1),newParentWithVal(:,decision_num+2))
        xlabel('f(1)');ylabel('f(2)');
    elseif(obj_num==3)
        scatter3(newParentWithVal(:,decision_num+1),newParentWithVal(:,decision_num+2),newParentWithVal(:,decision_num+3))
        xlabel('f(1)');ylabel('f(2)');zlabel('f(3)');
    end
    drawnow;
end
end

