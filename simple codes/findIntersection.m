function b = findIntersection(a,x)

x = min(x):(max(x)-min(x))/1000:max(x);

% just compute the function here for the x
yfun1 = a.a1*exp(-((x-a.b1)/a.c1).^2);
yfun2 = a.a2*exp(-((x-a.b2)/a.c2).^2);
d = abs(yfun1-yfun2);
[PKS,LOCS] = findpeaks(d*-1,'NPeaks',1,'SortStr','ascend');

% figure
% hold on
% plot(yfun1)
% plot(yfun2)
% figure
% hold on
% plot(d)
% scatter([LOCS LOCS],[PKS PKS],'k')
% close all

% store
b.yfun1 = yfun1;
b.yfun2 = yfun2;
b.d = d;
b.peaks = PKS;
b.peakLocs = x(LOCS);
b.x = x;
