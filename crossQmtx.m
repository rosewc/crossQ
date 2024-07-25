function cq = crossQmtx(data,p,lag)
%CROSSQMTX Compute matrix of cross quantilogram values.
% Inputs
%   data=t by n array; only columns 1 and 2 are used
%   p=probability vector, length=m; must be ascending, with 0<p(1)<1.
%   lag=offset of column 1 relative to column 2; integer>=0
%     Example: If lag=2, then x(3:end) is compared to y(1:end-2).
% Output
%   cq=cross quantilogram matrix (m by m) 
% Algorithm inspired by @Umar, Matlab Answers, 2024-07-27.
% William Rose, 2024-07-24

% Check inputs
if lag<0 || abs(lag-round(lag))>0
    disp('Lag must be non-negative integer. Exiting.'); return
elseif p(1)<=0 || p(1)>=1
    disp('p(1) must be >0 and <1. Exiting.'); return
elseif ~all(p==sort(p))
    disp('p must be ascending. Exiting.'); return
end

% Inputs pass tests. Estimate cross quantilogram.
m=length(p);
cq = zeros(m);         % allocate correlation matrix

x=data(1+lag:end,1);            % column 1 = x
y=data(1:end-lag,2);            % column 2 = y 

% Calculate quantiles
qx = quantile(data(:,1), p);    % quantiles for column 1 (x)
qy = quantile(data(:,2), p);    % quantiles for column 2 (y)

% Estimate cross-quantile correlation
for i = 1:m  
    for j = 1:m
        if i==1
            xq=(x<=qx(1)); 
        else 
            xq=(qx(i-1)<x & x<=qx(i)); 
        end
        if j==1
            yq=(y<=qy(1));
        else 
            yq=(qy(j-1)<y & y<=qy(j)); 
        end
        cq(i,j) = corr(xq,yq);
    end
end

end