function plotcrossQmtx(cq,p,lag)
%PLOTCROSSQMTX Plot cross quantilogram matrix as a surface.
% Inputs
%   cq=numeric array, m by m
%   p=numeric vector, length m, must be ascending, with lowest value >0
%   lag (optional, used for title, if present)
% Output = plot.
% Augment p by 1, and add row & column to cq, so that all rows
% and columns of cq will be plotted on the surface.  
% Plot surf(pa,pa,cqa') so that quantiles of x (rows of cq) vary along 
% horizontal axis.  
% Due to the behavior of surf(), I adjust ticks and tick labels so that 
% the probability bounds for each quantile will display correctly.
% William Rose, 2024-07-27

% Check inputs
[nr,nc]=size(cq);
if p(1)<=0
    disp('p(1) must be >0. Exiting.'); return
elseif nr~=length(p) || nc~=length(p)
    disp('cq must have size=length(p)^2. Exiting.'); return
elseif ~all(p==sort(p))
    disp('p must be ascending.  Exiting.'); return
end

% Inputs pass the tests.  Make plot.
figure
if isrow(p), p=p'; end      % force p to be a column vector 
pa=[p;2*p(end)-p(end-1)];   % add element to p
cqa=[cq,zeros(length(p),1);zeros(1,length(p)+1)]; % add row, column to cq

surf(pa,pa,cqa');           % plot augmented cq as surface
map=[linspace(0,1,51)',linspace(0,1,51)',ones(51,1);...  % custom colormap
      ones(50,1),linspace(.98,0,50)',linspace(.98,0,50)'];
colormap(map); axis equal; view(0,90)
c=colorbar; c.Label.String='Correlation';
if nargin==3
    title(['Cross Quantilogram at Lag=',num2str(lag)])
else
    title('Cross Quantilogram')
end
xlabel('X quantile'); ylabel('Y Quantile');
if length(p)<10
    xticks(pa)                      % every p value
    xticklabels(num2str([0;p]));
    yticks(pa)                      % every p value
    yticklabels(num2str([0;p]));
else
    xticks([pa(1:2:end)])           % every other p value
    xticklabels(num2str([0;p(2:2:end)]));
    yticks([pa(1:2:end)])           % every other p value
    yticklabels(num2str([0;p(2:2:end)]));
end    

end