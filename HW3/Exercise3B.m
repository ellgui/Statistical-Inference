%% Assignment 3B
clear
clc

% import dataset
dataSet = importdata('bodytemp.txt');
%% ai) Using normal theory, form a 95% confidence interval 
%%for the difference of mean heart rates between males and females. 
%Is the use of normal approximation reasonable?

%readtable creates one variable in T for each column in the file and reads
%...variable names from the first row of the file
readableData = readtable('bodytemp.txt');
fieldGender = 'Gender';
fieldTemp = 'Temp';
fieldRate = 'Rate';

structData = struct(fieldGender,0,fieldTemp,0,fieldRate,0);
m=1;
n=1;

male(1,65)=struct(structData);
female(1,65)=struct(structData);
both(1,130)=struct(structData);

for i=1:130
    %create a struct with both genders
    both(i) = struct(fieldGender,readableData.gender(i),fieldTemp,readableData.temperature(i),fieldRate,readableData.rate(i)); 
    if readableData.gender(i) == 1 %all the 1s are males
        male(m) = struct(fieldGender,readableData.gender(i),fieldTemp,readableData.temperature(i),fieldRate,readableData.rate(i));
        m = m+1;
    else %all the 2s are females
        female(n) = struct(fieldGender,readableData.gender(i),fieldTemp,readableData.temperature(i),fieldRate,readableData.rate(i));
        n = n+1;
    end
end

%the male and female data with rates
maleData=[male.Rate];
femaleData=[female.Rate];
bothData=[both.Temp];

figure(1)
qqplot(femaleData)
ylabel('Quantiles of female rate sample')
figure(2)
qqplot(maleData)
ylabel('Quantiles of male rate sample')


%normfit(x) returns estimates of normal distribution parameters, since we use normal theory 
%(the mean muHat and standard deviation sigmaHat), given the sample data in x.

[muHatRateMale,sigmaRateTempMale] = normfit([male.Rate]);
[muHatRateFemale,sigmaRateTempFemale] = normfit([female.Rate]);


sampleSize=65;
meanMale=mean([male.Rate]);
meanFemale=mean([female.Rate]);
varianceMale=var([male.Rate]);
varianceFemale=var([female.Rate]);

%approximate CI for large sample test for the difference between two means
CIDiffMeans=[meanFemale-meanMale-1.96*sqrt(varianceMale/sampleSize+varianceFemale/sampleSize) ...
    meanFemale-meanMale+1.96*sqrt(varianceMale/sampleSize+varianceFemale/sampleSize)]


%% aii) Two sample t-test
%Use a parametric test to compare the heart rates between males and females.

pooledSampleVar= (((sampleSize-1)/(sampleSize*2-2))*varianceMale)+... %calculate the pooled sample variance
    (((sampleSize-1)/(sampleSize*2-2))*varianceFemale);

%unbiasedVarianceEstimate=pooledSampleVar*sampleSize*2/(sampleSize^2); %calculate the unbiased variance estimate

CIparametric=[meanFemale-meanMale-1.960*sqrt(pooledSampleVar)*sqrt(sampleSize*2/sampleSize^2) ...
   meanFemale-meanMale+1.960*sqrt(pooledSampleVar)*sqrt(sampleSize*2/sampleSize^2)];

%% aiii)
%Use a nonparametric test to compare the heart rates between males and females

%assume samples are independent --> ranksum test (non-parametric)
%[p,h] = ranksum(x,y) also returns a logical value indicating the test decision. The result h = 1 indicates a rejection of the null hypothesis, 
%and h = 0 indicates a failure to reject the null hypothesis at the 5% significance level.
% also returns the p-value of a two-sided Wilcoxon rank sum test. 
[p,h] = ranksum(maleData,femaleData)

