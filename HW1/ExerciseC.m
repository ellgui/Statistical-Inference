clc
clear

%import data from file
families = importdata('families.txt');  
dataSet = families.data;


%% ci) What are the sampling fractions for proportional allocation and optimal allocation?
% sample fraction=n/N

typesOfRegions=dataSet(:,5);
income=dataSet(:,4);

sizeNorth = length(find(typesOfRegions==1)); 
sizeEast = length(find(typesOfRegions==2));
sizeSouth = length(find(typesOfRegions==3));
sizeWest = length(find(typesOfRegions==4));

%w_i
sampleFractionNorth=sizeNorth/(size(typesOfRegions,1));
sampleFractionEast=sizeEast/(size(typesOfRegions,1));
sampleFractionSouth=sizeSouth/(size(typesOfRegions,1));
sampleFractionWest=sizeWest/(size(typesOfRegions,1));

%sample fraction for proportional allocation
sampleFractionPropNorth=sampleFractionNorth;
sampleFractionPropEast=sampleFractionEast;
sampleFractionPropSouth=sampleFractionSouth;
sampleFractionPropWest=sampleFractionWest;

%sample fraction for optimal allocation

%find the income to each region
incomeMatrix=[typesOfRegions,dataSet(:,4)];

%creating an income matrix for each region
incomeMatrixNorth=incomeMatrix(1:sizeNorth,:);
incomeMatrixEast=incomeMatrix(sizeNorth+1:sizeEast+sizeNorth,:);
incomeMatrixSouth=incomeMatrix(sizeEast+sizeNorth+1:sizeEast+sizeNorth+sizeSouth,:);
incomeMatrixWest=incomeMatrix(sizeEast+sizeNorth+sizeSouth+1:sizeEast+sizeNorth+sizeSouth+sizeWest,:);

%standard deviation for each region
standardDevNorth=std(incomeMatrixNorth(:,2));
standardDevEast=std(incomeMatrixEast(:,2));
standardDevSouth=std(incomeMatrixSouth(:,2));
standardDevWest=std(incomeMatrixWest(:,2));

%average total SD
standardDevAverage=sampleFractionNorth*standardDevNorth+sampleFractionEast*standardDevEast+...
    sampleFractionSouth*standardDevSouth+sampleFractionWest*standardDevWest;

sampleFractionOptimalNorth=(sampleFractionNorth*standardDevNorth)/standardDevAverage;
sampleFractionOptimalEast=(sampleFractionEast*standardDevEast)/standardDevAverage;
sampleFractionOptimalSouth=(sampleFractionSouth*standardDevSouth)/standardDevAverage;
sampleFractionOptimalWest=(sampleFractionWest*standardDevWest)/standardDevAverage;


%% cii) Allocate 500 observations proportionally to the four regions and 
%estimate the average income from the stratified sample.
% Estimate the standard error and form a 95% confidence interval. 
%Compare your results to the results of the simple random sample.

observations = 500;

proportionNorth=sizeNorth/(size(typesOfRegions,1));
proportionEast=sizeEast/(size(typesOfRegions,1));
proportionSouth=sizeSouth/(size(typesOfRegions,1));
proportionWest=sizeWest/(size(typesOfRegions,1));


%proportion allocation

sampleNorth=datasample(incomeMatrixNorth(:,2),round(observations*proportionNorth)); % 500*w_j observations sampled uniformly at random from the data in each income matrix.
averageIncomeNorth=mean(sampleNorth);
standardDevNorth=std(sampleNorth);

sampleEast=datasample(incomeMatrixEast(:,2),round(observations*proportionEast));
averageIncomeEast=mean(sampleEast);
standardDevEast=std(sampleEast);

sampleSouth=datasample(incomeMatrixSouth(:,2),round(observations*proportionSouth));
averageIncomeSouth=mean(sampleSouth);
standardDevSouth=std(sampleSouth);

sampleWest=datasample(incomeMatrixWest(:,2),round(observations*proportionWest));
averageIncomeWest=mean(sampleWest);
standardDevWest=std(sampleWest);

totalAverage=proportionNorth*averageIncomeNorth+proportionEast*averageIncomeEast+proportionSouth*averageIncomeSouth+...
    proportionWest*averageIncomeWest; %xbar_s

totalEstimatedMeanVariance=proportionNorth*(standardDevNorth)^2+proportionEast*(standardDevEast)^2+proportionSouth*(standardDevSouth)^2+...
    proportionWest*(standardDevWest)^2;

totalVariance=totalEstimatedMeanVariance/observations;

%s_xstrat
totalEstimatedStandardError=sqrt((proportionNorth^2*standardDevNorth^2)/sizeNorth+(proportionEast^2*standardDevEast^2)/sizeEast...
    +(proportionSouth^2*standardDevSouth^2)/sizeSouth+(proportionWest^2*standardDevWest^2)/sizeWest);

CIneg = (totalAverage - 1.96 * totalEstimatedStandardError);
CIPos = (totalAverage + 1.96 * totalEstimatedStandardError);
CIIncome = [CIneg CIPos]

fprintf('The average income is %.2f and the standard deviation from the stratified sample is %.2f\n\n',totalAverage, totalEstimatedStandardError);





