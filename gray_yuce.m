clc;clear
han1 = [83.0 79.8 78.1 85.1 86.6 88.2 90.3 86.7 93.3 92.5 90.9 96.9
   101.7 85.1 87.8 91.6 93.4 94.5 97.4 99.5 104.2 102.3 101.0 123.5
   92.2 114.0 93.3 101.0 103.5 105.2 109.5 109.2 109.6 111.2 121.7 131.3
   105.0 125.7 106.6 116.0 117.6 118.0 121.7 118.7 120.2 127.8 121.8 121.9
   139.3 129.5 122.5 124.5 135.7 130.8 138.7 133.7 136.8 138.9 129.6 133.7
   137.5 135.3 133.0 133.4 142.8 141.6 142.9 147.3 159.6 162.1 153.5 155.9
   163.2 159.7 158.4 145.2 124.0 144.1 157.0 162.6 171.8 180.7 173.5 176.5];
han1(end,:) = [];%相当与han1 = han1(1:6,:);  以前六行预测第七行  12个月
m = size(han1,2);%把月份提取出来  size(han1,1) 提取行数   size(han1,2) 提取列数
        % m1 = size(han1,1);  
        % x00 = mean(han1,1);
x0 = mean(han1,2); %每行的平均值 12列数相加求平均值
x1 = cumsum(x0); %对x0的每行数逐渐累加
alpha = 0.4;
n = length(x0); %长度，数据的维度，n=6
z1 = alpha*x1(2:n) + (1 - alpha)*x1(1:n-1);  %求邻域生成数 
     %αx1(k)-（1-α）x1(k-1)   α已确定 下一步白化微分方程
Y = x0(2:n); %x0为原始初值 数据向量
B = [-z1,ones(n-1,1)]; %数据矩阵
ab = B\Y; %B逆*Y 求出ab    可用最小二乘估法求得参数的估计值
k = 6; %2-7  ab(2)是调取b的值，ab(1)是调取a的值
x7hat = (x0(k)-ab(2)/ab(1))*(exp(-ab(1)*k)-exp(-ab(1)*(k-1)));%预测结果  估计值
z = m*x7hat;
u = sum(han1)/sum(sum(han1));%列和 比上 总值  12个数  求出相应系数
v = z*u; %根据Z值，z*相应系数，求出来年对应月数的值
