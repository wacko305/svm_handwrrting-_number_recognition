predict = zeros(1,10);
predict_correct = zeros(1,10);
correct = zeros(1,10);
for i=1:length(predict_label)
    index = predict_label(i);
    if index == 0
        predict(1) = predict(1)+1;       
    end
    if index == 1
        predict(2) = predict(2)+1;
    end
    if index == 2
        predict(3) = predict(3)+1;
    end
    if index == 3
        predict(4) = predict(4)+1;
    end
    if index == 4
        predict(5) = predict(5)+1;
    end
    if index == 5
        predict(6) = predict(6)+1;
    end
    if index == 6
        predict(7) = predict(7)+1;
    end
    if index == 7
        predict(8) = predict(8)+1;
    end
    if index == 8
        predict(9) = predict(9)+1;
    end
    if index == 9
        predict(10) = predict(10)+1;
    end
end

for i=1:length(test_lablee)
    index = test_lablee(i);
    if index == 0
        correct(1) = correct(1)+1;
        if index == predict_label(i)
            predict_correct(1) = predict_correct(1)+1;
        end
    end
    if index == 1
        correct(2) = correct(2)+1;
        if index == predict_label(i)
            predict_correct(2) = predict_correct(2)+1;
        end
    end
    if index == 2
        correct(3) = correct(3)+1;
        if index == predict_label(i)
            predict_correct(3) = predict_correct(3)+1;
        end
    end
    if index == 3
        correct(4) = correct(4)+1;
        if index == predict_label(i)
            predict_correct(4) = predict_correct(4)+1;
        end
    end
    if index == 4
        correct(5) = correct(5)+1;
        if index == predict_label(i)
            predict_correct(5) = predict_correct(5)+1;
        end
    end
    if index == 5
        correct(6) = correct(6)+1;
        if index == predict_label(i)
            predict_correct(6) = predict_correct(6)+1;
        end
    end
    if index == 6
        correct(7) = correct(7)+1;
        if index == predict_label(i)
            predict_correct(7) = predict_correct(7)+1;
        end
    end
    if index == 7
        correct(8) = correct(8)+1;
        if index == predict_label(i)
            predict_correct(8) = predict_correct(8)+1;
        end
    end
    if index == 8
        correct(9) = correct(9)+1;
        if index == predict_label(i)
            predict_correct(9) = predict_correct(9)+1;
        end
    end
    if index == 9
        correct(10) = correct(10)+1;
        if index == predict_label(i)
            predict_correct(10) = predict_correct(10)+1;
        end
    end
end
predict = round(predict);
correct = floor(correct);  %���ǲ�����ȷ�����
predict_correct = floor(predict_correct); %����Ԥ���ÿ��������ȷ�����
erro = zeros(1,10);
erro = correct - predict_correct;     
erro = floor(erro);  %����ÿ������Ԥ�����ĸ���
correct_ratio = predict_correct./correct;
x = 0:9;
y1 = predict_correct;
y2 = erro;
y3 = correct;
figure;
plot(x,y1,'-*g',x,y2,':hr',x,y3,'--ob');
axis([0,9,0,50])  %ȷ��x����y���ͼ��С
text(x,y1,num2str([x;y1].','(%d,%d)'))
text(x,y2,num2str([x;y2].','(%d,%d)'))
text(x,y3,num2str([x;y3].','(%d,%d)'))
legend('Ԥ����ȷ�ĸ���','Ԥ�����ĸ���','ÿ�����ֲ�������');   %���ϽǱ�ע
xlabel('�������')  %x����������
ylabel('����') %y����������

x = 0:9;
y4 = correct_ratio;
figure;
plot(x,y4,'-..k');
axis([0,9,0,1]);
text(x,y4,num2str([x;y4].','(%d,%.2f)'))
xlabel('�������')  %x����������
ylabel('��ȷ��') %y����������
legend('��ȷ��');   %���ϽǱ�ע