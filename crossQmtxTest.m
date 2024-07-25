%crossQmtxTest.m
% Script to test functions crossQmtx.m and plotcrossQmtx.m.
% Use stock price data in file aapl_sbux_stockprice5y.xlsx.
% William Rose, 2024-07-24

clear

data=readmatrix("aapl_sbux_stockprice5y.xlsx",'Range','b2:c1259');
p=0.1:0.1:1.0;                  % probabilities for quantiles
lag=1;                          % lag of column 1 relative to column 2

cq=crossQmtx(data,p,lag);   % estimate cross quantilogram

% Plot heat map
plotcrossQmtx(cq,p,lag)