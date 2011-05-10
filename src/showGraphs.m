
global gtime gPos gMosquitoInImage;

[gAzimuth, gElevation] = mosquitoPxPositionToAzimuthAndElevation(gMosquitoInImage(:,1), gMosquitoInImage(:,2));

figure(1)
subplot(3,1,1);
plot(gtime, gPos(:,1));
grid on;
subplot(3,1,2);
% plot(gtime, gMosquitoInImage(:,1)-320, 'b');
% hold on;
plot(gtime, gAzimuth(:,1), 'r')
% hold off;
grid on
subplot(3,1,3);
% plot(gtime, 
integralX = zeros(180,1);
integralX(1) = gAzimuth(1,1);
for i = 2:N
    integralX(i) = integralX(i-1) + gAzimuth(i,1);
end
plot(gtime, integralX);
grid on;


%%
figure(2)
subplot(3,1,1);
plot(gtime, gPos(:,2));
grid on;
subplot(3,1,2);
% plot(gtime, gMosquitoInImage(:,2)-240, 'b');
plot(gtime, gElevation(:,1), 'r')
grid on;
subplot(3,1,3);
%
integralY = zeros(180,1);
integralY(1) = gElevation(1,1);
for i = 2:N
    integralY(i) = integralY(i-1) + gElevation(i,1);
end
plot(gtime, integralY);
grid on;

%%

figure(3)
plot(gPos(:,1), -gPos(:,2));
hold on;
plot(gPos(1,1), -gPos(1,2), 'yo');
hold off;
set(gca, 'XLim', [xLimLo xLimHi]);
set(gca, 'YLim', [yLimLo yLimHi]);