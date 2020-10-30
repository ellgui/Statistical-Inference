%% Assignment 2C
clc
clear

% import dataset
dataSet = importdata('gamma-arrivals.txt');  
sampleSize=length(dataSet);

%% ci)
%Estimate the standard errors of the parameters fit by method of moments 
% by using bootstrap.

%Use the formula from p.17 in the lecture notes.
lambdaHat1 =0.0127;
alphaHat1 =1.0121;
numberOfSamples = 1000;

%R = gamrnd(A,B,m,n,...) generates an m-by-n-by-... array containing...
%random numbers from the gamma distribution with parameters A and B. 
bootstrapMME = gamrnd(alphaHat1 * ones(numberOfSamples,sampleSize), 1/lambdaHat1 * ones(numberOfSamples,sampleSize));

meanMME = zeros(numberOfSamples,1);
stdME = zeros(numberOfSamples,1);
alphaHatBoot1 = zeros(numberOfSamples,1);
lambdaHatBoot1 = zeros(numberOfSamples,1);

for i = 1:numberOfSamples
   meanMME(i) = mean(bootstrapMME(i,:));
   stdME(i) = std(bootstrapMME(i,:));
   alphaHatBoot1(i) = meanMME(i)^2 / stdME(i)^2;
   lambdaHatBoot1(i) = alphaHatBoot1(i) / meanMME(i);
end

%From equation in from page 17
alphaBar1 = mean(alphaHatBoot1);
alphaStandardError1 = sqrt((1/(numberOfSamples-1)) * sum((alphaHatBoot1 - alphaBar1).^2));
lambdaBar1 = mean(lambdaHatBoot1);
lambdaStandardError1 = sqrt((1/(numberOfSamples-1)) * sum((lambdaHatBoot1 - lambdaBar1).^2));

%% cii)
%Estimate the standard errors of the parameters fit by by maximum likelihood by using bootstrap.

%Use the formula form p.17 in the lecture notes.
lambdaHat2 =0.0128;
alphaHat2 =1.0263;

%R = gamrnd(A,B,m,n,...) generates an m-by-n-by-... array containing...
%random numbers from the gamma distribution with parameters A and B. 
bootstrapML = gamrnd(alphaHat2 * ones(numberOfSamples,sampleSize), 1/lambdaHat2 * ones(numberOfSamples,sampleSize));

meanML = zeros(numberOfSamples,1);
stdML = zeros(numberOfSamples,1);
alphaHatBoot2 = zeros(numberOfSamples,1);
lambdaHatBoot2 = zeros(numberOfSamples,1);

for i = 1:numberOfSamples
   meanML(i) = mean(bootstrapML(i,:));
   stdML(i) = std(bootstrapML(i,:));
   alphaHatBoot2(i) = meanML(i)^2 / stdML(i)^2;
   lambdaHatBoot2(i) = alphaHatBoot2(i) / meanML(i);
end

%From equation in lecture notes from page 17
alphaBar2 = mean(alphaHatBoot2);
alphaStandardError2 = sqrt((1/(numberOfSamples-1)) * sum((alphaHatBoot2 - alphaBar2).^2));
lambdaBar2 = mean(lambdaHatBoot2);
lambdaStandardError2 = sqrt((1/(numberOfSamples-1)) * sum((lambdaHatBoot2 - lambdaBar2).^2));

%% Di) Use bootstrap to form 95% approximate confidence intervals for
%the parameter estimates obtained by the method of moments

%Y = prctile(X,p) returns percentiles of the elements in a data vector or
%array X for the percentages p in the interval [0,100].

%CI for alphaMME
c1_alpha1=prctile(alphaHatBoot1,2.5);
c2_alpha1=prctile(alphaHatBoot1,97.5);

CI1_alpha1 = 2*alphaBar1 - c1_alpha1;
CI2_alpha1 = 2*alphaBar1 - c2_alpha1;

confidenceInterval95_alphaMME=[CI1_alpha1 CI2_alpha1]

%CI for lambdaMME
c1_lambda1=prctile(lambdaHatBoot1,2.5);
c2_lambda1=prctile(lambdaHatBoot1,97.5);

CI1_lambda1 = 2*lambdaBar1 - c1_lambda1;
CI2_lambda1 = 2*lambdaBar1 - c2_lambda1;

confidenceInterval95_lambdaMME=[CI1_lambda1 CI2_lambda1]

%% Dii) Use bootstrap to form 95% approximate confidence intervals for
%the parameter estimates obtained by maximum likelihood


%CI for alphaMLE
c1_alpha2=prctile(alphaHatBoot2,2.5);
c2_alpha2=prctile(alphaHatBoot2,97.5);

CI1_alpha2 = 2*alphaBar2 - c1_alpha2;
CI2_alpha2 = 2*alphaBar2 - c2_alpha2;

confidenceInterval95_alphaMLE=[CI1_alpha2 CI2_alpha2]

%CI for lambdaMLE
c1_lambda2=prctile(lambdaHatBoot2,2.5);
c2_lambda2=prctile(lambdaHatBoot2,97.5);

CI1_lambda2 = 2*lambdaBar2 - c1_lambda2;
CI2_lambda2 = 2*lambdaBar2 - c2_lambda2;


confidenceInterval95_lambdaMLE=[CI1_lambda2 CI2_lambda2]
