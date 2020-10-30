%% Assignment 2B
clc
clear

% import dataset
dataSet = importdata('gamma-arrivals.txt');  
sizeDataSet=length(dataSet);
%% bi) % parameter estimate by Method of moment

xBar = mean(dataSet);
xStandardDev = std(dataSet);
lambdaHat1 = xBar/(xStandardDev)^2;
alphaHat1 = lambdaHat1 * xBar;
%% bii) %parameter estimate by MLE

%gamfit returns the maximum likelihood estimates (MLEs) for the parameters of the gamma distribution given the data in vector data. 
MLE = gamfit(dataSet); 

alphaHat2=MLE(1); 
lambdaHat2=1/MLE(2); 
%in the matlab function, lambda in the gamma distribution is 
%defined as 1/lambda (thereby we need to do 1/lambda)

%% biii)

sortedDataSet = sort(dataSet);
y1 = gampdf(sortedDataSet, alphaHat1, 1/lambdaHat1); %lambda is defined as 1/lambda in gampdf
y2 = gampdf(sortedDataSet, alphaHat2, 1/lambdaHat2);
%gampdf computes the gamma pdf at each of the values in X using the corresponding 
%shape parameters (alpha) in A and scale parameters(lambda) in B.

%used normalized to get the same scale on the axis
yyaxis left 
histogram(dataSet,'Normalization','pdf');

yyaxis right
plot(sortedDataSet,y1,'-',sortedDataSet,y2,'-.')
legend('Histogram of dataset','Method of moments','Method of maximum likelihood') 

