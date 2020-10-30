clc
clear

%import data from file
families = importdata('families.txt');  
dataSet = families.data;

numberSamples = 100;
sampleSize = 400;
numberOfFamilies=43886;

%% bi) For each sample, find the average family income.

 averageIncome = zeros(numberSamples,1);
 standardDevIncome = zeros(numberSamples,1);
 
 sampleIncome = zeros(numberSamples,sampleSize);
 
 for i = 1:numberSamples
     sampleIncome(i,:) = randsample(dataSet(:,4),sampleSize);
     averageIncome(i) = mean(sampleIncome(i,1:sampleSize)); %the average income for each sample
     standardDevIncome(i) = std(sampleIncome(i,:));
 end
 
 %% bii) Find the average and standard deviation of these 100 estimates and make a histogram of the estimates.

meanAverageIncome = mean(averageIncome);
standardDevIncomeAverage=std(averageIncome);
 
fprintf('The average and the standard deviation of the 100 estimates (sample size=400) are %.2f respectively %.2f\n',...
     meanAverageIncome, standardDevIncomeAverage);

 %histogram of the estimates
 figure(1)
 hist(averageIncome,10);
 hold on
  
 
 %% biii) Superimpose a plot of a normal density with that mean and standard deviation...
    % of the histogram and comment on how well it appears to fit.
clf  
histogram(averageIncome,'Normalization','pdf')   
hold on
x = 35000:1:48000;
y = normpdf(x,meanAverageIncome,standardDevIncomeAverage);
figure(1)
plot(x,y);
    

%% biv) For each of the 100 samples, find a 95% confidence interval for the population average income. 
%How many of those intervals actually contain the population target.

 sampleMean = zeros(100,1);
 sampleStandardDev = zeros(100,1);
 estimatedStandardDev = zeros(100,1);
 populationIncome=dataSet(:,4);
 
 trueAveragepopulationIncome=sum(populationIncome)/numberOfFamilies; %population income average
 CINeg = zeros(numberSamples,1);
 CIPos = zeros(numberSamples,1);
 
 x = 1:2:200; 
 plot(x,ones(100)*trueAveragepopulationIncome); %plot "the true value" as the straight horizontal line
 hold on
 
 for i=1:numberSamples
     sampleMean(i) = mean(sampleIncome(i,:)); %xbar för each sample
     sampleStandardDev(i) = sqrt((sampleSize/(sampleSize-1))*...
         (mean(sampleIncome(i,:).^2)-sampleMean(i)^2)); %s for each sample
     estimatedStandardDev(i) = sampleStandardDev(i)/sqrt(sampleSize);
     
     CINeg(i) = sampleMean(i)-1.96*estimatedStandardDev(i);
     CIPos(i) = sampleMean(i)+1.96*estimatedStandardDev(i);
     
     plot([x(i) x(i)],[(sampleMean(i)-1.96*estimatedStandardDev(i)), (sampleMean(i)+1.96*estimatedStandardDev(i))]) %plot CI to see how many that contains the true value
     hold on
 end
 
 CIPopulationAverageIncome = [CINeg CIPos]; %matrix with CI interval for each sample (100x2)
 
 
 %% bv) Take 100 samples of size 100. 
 %Compare the averages, standard deviations and histograms to those obtained for a sample of size 400 
 %and explain how the theory of simple random sampling relates to the comparisons.
numberSamples = 100;
sampleSize2 = 100;

averageIncome2 = zeros(numberSamples,1);
standardDevIncome2 = zeros(numberSamples,1);

sampleIncome2 = zeros(numberSamples,sampleSize2);

for i = 1:numberSamples
    sampleIncome2(i,:) = randsample(dataSet(:,4),sampleSize2);
    averageIncome2(i) = mean(sampleIncome2(i,1:sampleSize2)); %the average income
    standardDevIncome2(i) = std(sampleIncome2(i,:));
end

meanAverageIncome2 = mean(averageIncome2);
standardDevIncomeAverage2=std(averageIncome2);
 
fprintf('The average and the standard deviation of the 100 estimates (sample size=100) are %.2f respectively %.2f\n',...
     meanAverageIncome2, standardDevIncomeAverage2);

 %histogram of the estimates
figure(3) 
histogram(averageIncome,'Normalization','pdf'); 
hold on 
histogram(averageIncome2,'Normalization','pdf'); 
hold on
legend('Sample size = 400','Sample size = 100');

 

 