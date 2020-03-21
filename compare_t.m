clear;
clc;
for i=1:700
    str  = strcat('D:\software\MATLAB2020a\bin\QQQ\train1\',num2str(i));
    name = strcat(str,'.bmp');
    name = char(name);
    current_img = imread(name);   %将当前图片赋值给一个变量
    current_img = imbinarize(current_img,5/255);
    current_img = reshape(current_img,1,[]); %将矩阵变形
    current_img = double(current_img);
    train_image(i,:) = current_img;
end
load    train-lablee.txt  
tic;
model1 = svmtrain(train_lablee, train_image, '-t 0');
train_time1 = toc;
tic;
model2 = svmtrain(train_lablee, train_image, '-t 1');
train_time2 = toc;
tic;
model3 = svmtrain(train_lablee, train_image, '-t 2');
train_time3 = toc;
tic;
model4 = svmtrain(train_lablee, train_image, '-t 3');
train_time4 = toc;


for i=1:300
    str  = strcat('D:\software\MATLAB2020a\bin\QQQ\test1\',num2str(i));
    name = strcat(str,'.bmp');
    name = char(name);
    current_img = imread(name);    %将当前图片赋值给一个变量
    current_img = imbinarize(current_img,5/255);
    current_img = reshape(current_img,1,[]); %将矩阵变形
    current_img = double(current_img);
    test_image(i,:) = current_img;
end
load    test-lablee.txt  
tic;
[predict_label1, accuracy1, dec_values1] =svmpredict(test_lablee, test_image, model1);
test_time1 = toc;
tic;
[predict_label2, accuracy2, dec_values2] =svmpredict(test_lablee, test_image, model2);
test_time2 = toc;
tic;
[predict_label3, accuracy3, dec_values3] =svmpredict(test_lablee, test_image, model3);
test_time3 = toc;
tic;
[predict_label4, accuracy4, dec_values4] =svmpredict(test_lablee, test_image, model4);
test_time4 = toc;

head = ["核函数类型";"训练时间/s";"测试时间/s";"准确率/%"];
type_s = [0,1,2,3];
traintime = [train_time1, train_time2, train_time3, train_time4];
testtime = [test_time1, test_time2,test_time3,test_time4];
accuracy = [accuracy1(1),accuracy2(1),accuracy3(1),accuracy4(1)];
results = [type_s;traintime;testtime;accuracy];
all = [head,results];
xlswrite('compare_result.xlsx',all);
msgbox('数据已写入compare_result表格！');