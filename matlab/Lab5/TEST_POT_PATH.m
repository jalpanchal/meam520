clc
clear


addpath('maps')

qStart = [0,0,0,0,0,0];
qGoal = [0 ,-pi/4,pi/4,0,0,0];

map = loadmap('map1.txt');



qCurr = qStart;
isDone = false;
path = [];

while(~isDone)
[qNext, isDone] = potentialFieldStep_jal(qCurr, map, qGoal);

if isnan(qNext)
%     qCurr
%     qNext
    break
end

path = [path; qNext];

qCurr = qNext;


% pause(0.1);
end

path = [qStart;
        path;
        qGoal]
    
    
