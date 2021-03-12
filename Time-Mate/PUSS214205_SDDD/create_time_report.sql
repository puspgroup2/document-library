INSERT into TimeReports(userName, totalMinutes, week)
values("Bullpojken", 666, 52);

DELETE from TimeReports 
WHERE userName = 'Bullpojken'
AND week = 52;