% Time Series Analysis

load count.dat

% create time series obj
count1 = timeseries(count(:,1),1:24,'name', 'intersection1');
count2 = timeseries(count(:,2),1:24,'name', 'intersection2');
count3 = timeseries(count(:,3),1:24,'name', 'intersection3');

% Change Units
count1.DataInfo.Units = 'cars';

count1.TimeInfo.Units = 'hours';
count2.TimeInfo.Units = 'hours';
count3.TimeInfo.Units = 'hours';

% Change intepolation method: zero-order hold
count1.DataInfo.Interpolation = tsdata.interpolation('zoh');

% define and add events
e1 = tsdata.event('AMCommute',8);
e1.Units = 'hours';
count1 = addevent(count1, e1);
count2 = addevent(count2, e1);
count3 = addevent(count3, e1);

e2 = tsdata.event('PMCommute',18);
e2.Units = 'hours';
count1 = addevent(count1, e2);
count2 = addevent(count2, e2);
count3 = addevent(count3, e2);

% Create time series collection obj
tsc = tscollection({count1 count2}, 'name', 'count_coll');

tsc = addts(tsc, count3);

% Resample: interpolate values
tsc1 = resample(tsc, 1:0.5:24);

% Plot
hold on
plot(tsc1.intersection1, '-xb', 'Displayname', 'Intersection 1');
plot(tsc1.intersection2, '-.xm', 'Displayname', 'Intersection 2');
plot(tsc1.intersection1, ':xr', 'Displayname', 'Intersection 3');























