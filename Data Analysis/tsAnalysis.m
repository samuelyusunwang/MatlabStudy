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
plot(tsc1.intersection3, ':xr', 'Displayname', 'Intersection 3');
legend('show', 'Location', 'Best')
hold off

% Add data sample
tsc1 = addsampletocollection(tsc1, 'time', 3.25, 'intersection1', 5);

% Delete data sample
tsc1 = delsamplefromcollection(tsc1, 'index', find(isnan(tsc1.intersection2.Data)));

% Add back data sample
tsc1 = addsampletocollection(tsc1, 'time', 3.25, 'intersection1', 5);

% Interpolate the missing values in tsc1 using the current time vector
tsc1 = resample(tsc1, tsc1.Time);

% Remove a ts from ts collection
tsc1 = removets(tsc1, 'intersection3')

tsc1.intersection2.DataInfo.Units = 'cars'

% Set StartDate
tsc1.TimeInfo.StartDate = 'DEC-25-2009 00:00:00';

% specify time format
tsc1.TimeInfo.Format = 'HH:MM';

% Plot ts collection member
figure; hold on;
plot(tsc1.intersection1, '-b');
plot(tsc1.intersection2, '.-m');
hold off;













