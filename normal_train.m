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
model = svmtrain(train_lablee, train_image, '-s 0 -t 2 -c 6');
tic;
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
[predict_label, accuracy, dec_values] =svmpredict(test_lablee, test_image, model);
toc;