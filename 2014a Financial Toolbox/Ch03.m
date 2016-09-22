
%% eg01: construct efficient frontier
ExpReturn = [0.1, 0.2, 0.5];
ExpCovariance = [ 0.005  -0.010   0.004;
                 -0.010   0.040  -0.002;
                  0.004  -0.002   0.023];
NumPorts = 10;

frontcon(ExpReturn, ExpCovariance, NumPorts);

[PortRisk, PortReturn, PortWts] = frontcon(ExpReturn, ExpCovariance, NumPorts)


%% eg02: optimal risk portfolio

NumPorts = 20;

[PortRisk, PortReturn, PortWts] = portopt(ExpReturn, ExpCovariance, NumPorts);

RisklessRate = 0.08;
BorrowRate = 0.12;
RiskAversion = 3;

portalloc(PortRisk, PortReturn, PortWts, RisklessRate, BorrowRate, RiskAversion);

[RiskyRisk, RiskyReturn, RiskyWts,RiskyFraction, OverallRisk, OverallReturn] = ...
    portalloc (PortRisk, PortReturn, PortWts, RisklessRate, BorrowRate, RiskAversion)


%% eg03: constraints
ExpReturn = [0.1, 0.2, 0.15];
ExpCovariance = [ 0.005  -0.010   0.004;
                 -0.010   0.040  -0.002;
                  0.004  -0.002   0.023];
             
NumPorts = 8;

AssetBounds = [-0.10, -0.10, -0.10;
                1.10,  1.10,  1.10];

Groups = [0 1 1;
          1 0 0];

GroupBounds = [0  0.80;
               0  0.70];

[PortRisk, PortReturn, PortWts] = frontcon(ExpReturn, ExpCovariance, NumPorts, [], AssetBounds, Groups, GroupBounds)


%% Linear Constraint Equations
%{
A = [-1   -1    0;
      1    1    0;
      0    0   -1;
      0    0    1;
     -1    0    0;
      1    0    0;
      0   -1   -1;
      0    1    1];
  
b = [-0.30;
      0.75;
     -0.10;
      0.55;
     -0.20;
      0.50;
     -0.50;
      0.50]
    
ConSet = [A, b];
%}

ExpReturn = [0.1, 0.2, 0.15];
ExpCovariance = [ 0.005  -0.010   0.004;
                 -0.010   0.040  -0.002;
                  0.004  -0.002   0.023];

Group = [1    1    0;
         0    0    1;
         1    0    0;
         0    1    1];

GroupMin = [0.30 0.10 0.20 0.50];
GroupMax = [0.75 0.55 0.50 0.50];

ConSet = portcons('Default', 3, 'GroupLims', Group, GroupMin, GroupMax);

[PortRisk, PortReturn, PortWts] = portopt(ExpReturn, ExpCovariance, [], [], ConSet)


%% Active Return/Risk Efficient Frontier

NumAssets = 5;
ExpReturn = [0.2074 0.1971 0.2669 0.1323 0.2535]/100;
Sigmas = [2.6570 3.6297 3.9916 2.7145 2.6133]/100;
Correlations = [1.0000 0.6092 0.6321 0.5833 0.7304
                0.6092 1.0000 0.8504 0.8038 0.7176
                0.6321 0.8504 1.0000 0.7723 0.7236
                0.5833 0.8038 0.7723 1.0000 0.7225
                0.7304 0.7176 0.7236 0.7225 1.0000];

ExpCovariance = corr2cov(Sigmas, Correlations);

Index = ones(NumAssets, 1)/NumAssets;

AbsConSet = portcons('PortValue', 1, NumAssets, 'AssetLims', zeros(NumAssets,1), ones(NumAssets,1));

ActiveConSet = abs2active(AbsConSet, Index);

[ActiveRisk, ActiveReturn, ActiveWeights] = portopt(ExpReturn, ExpCovariance, 21, [], ActiveConSet);

ActiveRisk = real(ActiveRisk);

plot(ActiveRisk*100, ActiveReturn*100, 'blue')
grid('on')
xlabel('Active Risk (std in percent)')
ylabel('Active Return (Percent)')
title('Tracking Error Efficient Frontier')




















      
      
