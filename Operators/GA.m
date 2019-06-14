function newParentWithVal = GA(Pop, arg, ConsFun, KeepDisFun, Problems)

[obj_num, decision_num, NIND, MAXGEN] = deal(arg(1), arg(2), arg(3), arg(4));
ub = 1; lb = 0;             % ���߱����߽�

ConsAlgorithm = str2func(ConsFun);
KeepDisAlgorithm = str2func(KeepDisFun);
Problem = str2func(Problems);
figure;
for gen = 1:MAXGEN
    ParentPopWithVal = Problem(Pop, obj_num);                        %��������ĺ���ֵ
    ChildPopWithVal = Selection(ParentPopWithVal, obj_num);          %��Ԫ������ѡ��
    ChildPop = ChildPopWithVal(:,1:decision_num);
    ChildPop = cross(ChildPop);              %ģ������ƽ���
    ChildPop = mutation(ChildPop,lb,ub);              %����ʽ����
    ChildPopWithVal = Problem(ChildPop, obj_num);             %����Ӵ��ĺ���ֵ
    
    UnionPopWithVal = [ParentPopWithVal;ChildPopWithVal];                       %�ϲ��������Ӵ�
    NDSetWithVal = ConsAlgorithm(UnionPopWithVal, obj_num);                     %�����֧�伯
    newParentWithVal = KeepDisAlgorithm(NDSetWithVal, NIND, obj_num);         %ӵ������
    
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

