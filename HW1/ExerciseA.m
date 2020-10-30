clc
clear

%import data from file
families = importdata('families.txt');  
dataSet = families.data;

sampleSize = 600;

randomSample = datasample(dataSet,600); 

%% ai) The proportion of husband-wife family
%take a simple sample of 600 families

typesOfFamilies=randomSample(:,1);
numberHusbandWife=length(find(typesOfFamilies==1)); %number of columns with family type = 1 in the data 

proportionHusbandWife=numberHusbandWife/sampleSize; %The proportion of husband-wife family

%use the estimated standard error for the sample proportion
estimatedStandardError1 = sqrt(proportionHusbandWife*(1-proportionHusbandWife)/(sampleSize - 1))

confidenceInterval95_1 = [proportionHusbandWife-(1.96*estimatedStandardError1) proportionHusbandWife+(1.96*estimatedStandardError1)]


fprintf('The proportion of husband-wife family is %.3f\n',...
     proportionHusbandWife);
 
%% aii) The average number of children per family.

numberOfChildren=randomSample(:,3);
sumNumberOfChildren=sum(numberOfChildren);

averageNumberChildren=sumNumberOfChildren/sampleSize;
sumSampleVariance=0;

for i=1:sampleSize
    sumSampleVariance1=(numberOfChildren(i)-averageNumberChildren)^2;
    sumSampleVariance=sumSampleVariance1+sumSampleVariance; %the sum from s^2
end

%the sample standard deviation
sampleStandardDeviation2=sqrt(1/(sampleSize-1)*sumSampleVariance);

%sample estimated standard error
estimatedStandardError2 = sampleStandardDeviation2/sqrt(sampleSize)

%C.I
confidenceInterval95_2 = [averageNumberChildren-(1.96*estimatedStandardError2) averageNumberChildren+(1.96*estimatedStandardError2)]


fprintf('The average number of children per family %.3f\n',...
     averageNumberChildren);


%% aiii The average number of persons per family.

numberOfPersons=randomSample(:,2);

sumNumberOfPersons=sum(numberOfPersons);

averageNumberPersons=sumNumberOfPersons/sampleSize; 

sumSampleVariance22=0;

for i=1:sampleSize 
    sumSampleVariance2=sum(numberOfPersons(i)-averageNumberPersons)^2; %the sum from s^2
    sumSampleVariance22=sumSampleVariance2+sumSampleVariance22;
end

sampleStandardDeviation3=sqrt(1/(sampleSize-1)*sumSampleVariance22);

estimatedStandardError3 = sampleStandardDeviation3/sqrt(sampleSize)

CINeg = averageNumberPersons - 1.96 * estimatedStandardError3;
CIPos = averageNumberPersons + 1.96 * estimatedStandardError3;

confidenceInterval95_3=[CINeg CIPos]


fprintf('The average number of persons per family are %.3f\n',...
     averageNumberPersons);
 