clear all;
clc;
close all;


% Compare mean solutions to establish grid convergence.
% Toggle plots
% Figure option
LW = 2;         % LineWidth
FSn = 25;       % FontSize labels
FSa = 18;       % FontSize axis

pdfE = false;
%pdfE = true;

%path = '~/Dropbox/Britton/THESIS/Figures/nozzle/convergence/';
path = '/Users/bolson/Dropbox/Britton/THESIS/Figures/nozzle/convergence/';

% Figure 1- 2d Contours of U velocity
pfig(1) = 0;
f(1).name = 'Ucontours';
% Figure 2- Line rake of U velocity in plume
pfig(2) = 0;
f(2).name = 'WWplume';
% Figure 3- Line rake of U velocity in nozzle
pfig(3) = 0;
f(3).name = 'WWnoz';
% Figure 4- Boundary layer profile, raw
pfig(4) = 1;
f(4).name = 'UBLmean';
% Figure 5- Boundary layer profile, wall units
pfig(5) = 1;
f(5).name = 'UBLlog';
% Figure 6- Artificial terms
pfig(6) = 0;
f(6).name = 'artMU';
% Figure 7- Reversed flow
pfig(7) = 0;
f(7).name = 'reversed_flow';
% Figure 8- Reversed flow
pfig(8) = 0;
f(8).name = 'pressure';

%pfig(:) = 0;

% Load the 2 mesh sizes
%load('../data/2dmv2.mat');
%load('../data/2dcv2.mat');
load('../data/fullcor2d.mat');
load('../data/fullucor2d.mat');

Ht = 1.78;
Up = 32940*1.603;
Pamb = 1e6;

% Get some variables
var_map
uc = sqrt( dataC(:,:,U).^2 + dataC(:,:,V).^2) ;
um = sqrt( dataM(:,:,U).^2 + dataM(:,:,V).^2 );
xc = dataC(:,:,X);yc = dataC(:,:,Y);
xm = dataM(:,:,X);ym = dataM(:,:,Y);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 1- 2d Contours of U velocity %%%%%%%%
if (pfig(1) == 1);
% Contour plot
figure(1);  
%cnts = linspace(5e5,5e7,16);
cnts = linspace(-.2,1.1,16);
%cnts = linspace(0,0.1,20);
%Up=1;
contour(xc/Ht,yc/Ht,uc/Up,cnts,'k');
hold on;
contour(xm/Ht,-ym/Ht,um/Up,cnts,'color','blue');
h=legend('Mesh A','Mesh B','Location','NorthWest');set(h,'Interpreter','latex','FontSize',FSn);
legend boxoff;
xlim([-1 10]);ylim([-1 1]);
axis equal;
box on;
set(gca,'FontSize',FSa);

h=xlabel('$X/H_t$');set(h,'Interpreter','latex','FontSize',FSn);
h=ylabel('$Y/H_t$');set(h,'Interpreter','latex','FontSize',FSn);

% Plot geometry
hold on;
plot(xm(:,1)/Ht,ym(:,1)/Ht,'k--','Linewidth',LW);
plot(xm(:,end)/Ht,ym(:,end)/Ht,'k--','Linewidth',LW);


%corner pts
%cpts1 = [6.5356,.79471;
%        6.6132, .81168;
%        6.6569, .82266;
%        6.6885, .87709;
%        6.6875, .98059];
%cpts2 = [6.5496,.60948;
%        6.6373, .69778;
%        6.6997, .74755;
%        6.7966, .85447;
%        6.9299, .99889];
%    
%figure(11);hold all;
%for i=1:size(cpts1,1)
%    [val,xx,yy] = lineout(xc/Ht,yc/Ht,uc,[cpts1(i,1),cpts2(i,1)],[cpts1(i,2),cpts2(i,2)],50);
%    dist = sqrt( (xx(1)-xx).^2 + (yy(1)-yy).^2 );
%    
%    figure(11);subplot(3,2,i);hold on;
%    plot(dist,val/Up,'k');
%    
%    figure(1);hold on;
%    plot(xx,yy,'r')
%end
%
%for i=1:size(cpts1,1)
%    [val,xx,yy] = lineout(xm/Ht,-ym/Ht,um,[cpts1(i,1),cpts2(i,1)],[cpts1(i,2),cpts2(i,2)],50);
%    dist = sqrt( (xx(1)-xx).^2 + (yy(1)-yy).^2 );
%    
%    figure(11);subplot(3,2,i);hold on;
%    plot(dist,val/Up,'b');
%    
%end

%figure(1);
%xlim([6 7.5])
%ylim([.2 1.2])


if (pdfE)
fig2pdf([path,f(1).name],1);
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 2- Line rake of U velocity in plume %
if (pfig(2) == 1);
% Line out of data in exit plume x = [0,2.5,5,7.5] Ht
Xexit = 11.7;
varC = dataC(:,:,WW);
varM = dataM(:,:,WW);
varDIM = Up*Up;
for i=1:4
    
xLO = Xexit + (i-1)*2.5*Ht;
% Interpolate onto line med
NN = 50;
[ZIc,XI,YIc] = lineout(xc(ceil(end/2):end,:),yc(ceil(end/2):end,:),varC(ceil(end/2):end,:),[xLO,xLO],[-3,3]*Ht,NN);
[ZIm,XI,YIm]= lineout(xm(ceil(end/2):end,:),ym(ceil(end/2):end,:),varM(ceil(end/2):end,:),[xLO,xLO],[-3,3]*Ht,NN);

figure(2);
subplot(2,2,i);
plot(ZIc/varDIM,YIc/Ht,'k-','LineWidth',LW);
hold on;
plot(ZIm/varDIM,-YIm/Ht,'b-','LineWidth',LW);
h = title(['$X= ',num2str(2.5*(i-1)),'H_t$']); set(h,'Interpreter','latex','FontSize',FSn/2);
h = xlabel('$U/U_p^2$');set(h,'Interpreter','latex','FontSize',FSn/2);
h = ylabel('$Y/H_t$');set(h,'Interpreter','latex','FontSize',FSn/2);

ylim([-3 3]);
%xlim([-.1 .6])

end
subplot(2,2,1);
h = legend('Mesh A','Mesh B');set(h,'Interpreter','latex','FontSize',FSn/2);
legend boxoff;
box on;

if (pdfE)
fig2pdf([path,f(2).name],2);
end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 3- Line rake of U velocity in       %
%% nozzle, through the shock
if (pfig(3) == 1);
% Line out of data in exit plume x = -[.5,1.0,1.5,2.0] Ht
Xexit = 11.7;
varC = dataC(:,:,WW);
varM = dataM(:,:,WW);
varDIM = Up*Up;
for i=1:4
    
xLO = Xexit - i*1*Ht;
% Interpolate onto line med
NN = 50;
[ZIc,XI,YIc] = lineout(xc(ceil(end/4):end,:),yc(ceil(end/4):end,:),varC(ceil(end/4):end,:),[xLO,xLO],[-1,1]*Ht,NN);
[ZIm,XI,YIm]= lineout(xm(ceil(end/4):end,:),ym(ceil(end/4):end,:),varM(ceil(end/4):end,:),[xLO,xLO],[-1,1]*Ht,NN);

figure(3);
subplot(2,2,i);
plot(ZIc/varDIM,YIc/Ht,'k-','LineWidth',LW);
hold on;
plot(ZIm/varDIM,-YIm/Ht,'b-','LineWidth',LW);
h = title(['$X= ',num2str(-1*i),'H_t$']); set(h,'Interpreter','latex','FontSize',FSn/2);
h = xlabel('$U/U_p^2$');set(h,'Interpreter','latex','FontSize',FSn/2);
h = ylabel('$Y/H_t$');set(h,'Interpreter','latex','FontSize',FSn/2);

ylim([-1 1]);
%xlim([-.1 1])

end
subplot(2,2,1);
h = legend('Mesh A','Mesh B');
set(h,'Interpreter','latex','FontSize',FSn/2);
legend boxoff;
box on;

if (pdfE)
fig2pdf([path,f(3).name],3);
end


end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 4- BL profile at the in nozzle inlet
if (pfig(4) == 1);
[y,imC] = min( abs( xc(:,1) ));
[y,imM] = min( abs( xm(:,1) ));
    

figure(4);
yy = yc(imC,1:ceil(end/2));
yy = yy - yy(1);
uu = uc(imC,1:ceil(end/2));hold all;
%semilogx( yy / Ht, uu / Up, 'k');
plot( yy / Ht, uu / Up, 'k','LineWidth',LW);

yy = ym(imM,1:ceil(end/2));
yy = yy - yy(1);
uu = um(imM,1:ceil(end/2));
%semilogx( yy / Ht, uu / Up, 'b');
plot( yy / Ht, uu / Up, 'b','LineWidth',LW);
xlim([0 .15])

h = ylabel('$U/U_p$'); set(h,'Interpreter','latex','FontSize',FSn);
h = xlabel('$Y/H_t$'); set(h,'Interpreter','latex','FontSize',FSn);
h = legend('Mesh A','Mesh B','Location','NorthWest');
set(h,'Interpreter','latex','FontSize',FSn);
legend boxoff;
box on;

if (pdfE)
fig2pdf([path,f(4).name],4);
end


end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 5- BL profile at the in nozzle inlet.. loglaw
if (pfig(5) == 1);
[y,imC] = min( abs( xc(:,1) ));
[y,imM] = min( abs( xm(:,1) ));
    

figure(5);
yy = yc(imC,1:ceil(end/2));
yy = yy - yy(1);
% Scaling
mu_w = dataC(imC,1,MU);
rho_w = dataC(imC,1,RHO);
dudy = ( uc(imC,2) - uc(imC,1) )/ ( yc(imC,2) - yc(imC,1) );
tauw = mu_w * dudy
utau = sqrt( tauw / rho_w );
del = mu_w / ( rho_w * utau );
uu = uc(imC,1:ceil(end/2));

% Van Driest
uvd(1) = 0;
for i=2:max(size(uu))
    dup = uu(i) - uu(i-1);
    uvd(i) = uvd(i-1) + sqrt( dataC(imC,i,RHO) / rho_w) * dup;
end

semilogx( yy / del, uvd / utau, 'k','LineWidth',LW);hold all;

yy = ym(imM,1:ceil(end/2));
yy = yy - yy(1);
% Scaling
mu_w = dataM(imM,1,MU);
rho_w = dataM(imM,1,RHO);
dudy = ( um(imM,2) - um(imM,1) )/ ( ym(imM,2) - ym(imM,1) );
tauw = mu_w * dudy
utau = sqrt( tauw / rho_w );
del = mu_w / ( rho_w * utau );
uu = um(imM,1:ceil(end/2));

% Van Driest
uvd(1) = 0;
for i=2:max(size(uu))
    dup = uu(i) - uu(i-1);
    uvd(i) = uvd(i-1) + sqrt( dataM(imM,i,RHO) / rho_w) * dup;
end

semilogx( yy / del, uvd / utau, 'b','LineWidth',LW);
%xlim([0 30])

x1 = logspace(-.5,1.2,20);
x2 = logspace(.8,3,20);
k = .39;
C = 5.2;
hold on;
semilogx(x1,x1,'k--');hold on;
semilogx(x2,1/k*log(x2)+C,'k--');

xlim([.5 2000])
h = ylabel('$U/U_{\tau}$'); set(h,'Interpreter','latex','FontSize',FSn);
h = xlabel('$Y/\delta_\eta$'); set(h,'Interpreter','latex','FontSize',FSn);
h = legend('Mesh A','Mesh B','Location','NorthWest');
set(h,'Interpreter','latex','FontSize',FSn);
set(gca,'FontSize',FSa);
% Fix to make sure Latex fits in
a = get(gca,'Position');
a(1) = a(1)*1.15;
set(gca,'Position',a);

legend boxoff;

if (pdfE)
fig2pdf([path,f(5).name],5);
end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 6- 
if (pfig(6) == 1);
figure(6);hold all;
    
[vm2,xim,yim] = lineout(xm,ym,dataM(:,:,MU),[11.7,11.7],[-1.347,1.347],50);
[vc2,xic,yic] = lineout(xc,yc,dataC(:,:,MU),[11.7,11.7],[-1.347,1.347],50);
[vm,xim,yim] = lineout(xm,ym,dataM(:,:,MUb),[11.7,11.7],[-1.347,1.347],50);
[vc,xic,yic] = lineout(xc,yc,dataC(:,:,MUb),[11.7,11.7],[-1.347,1.347],50);
%plot(yim/Ht,vm2,'r','Linewidth',LW);hold on;
plot(-yic/Ht,vc./vc2,'k','Linewidth',LW);
plot(yim/Ht,vm./vm2,'b','Linewidth',LW);

[vm,xim,yim] = lineout(xm,ym,dataM(:,:,MUa),[11.7,11.7],[-1.347,1.347],50);
[vc,xic,yic] = lineout(xc,yc,dataC(:,:,MUa),[11.7,11.7],[-1.347,1.347],50);
plot(-yic/Ht,vc./vc2,'k--','Linewidth',LW/2);
plot(yim/Ht,vm./vm2,'b--','Linewidth',LW/2);


h = legend('$\mu^*_{\eta}$ Mesh A','$\mu^*_{\eta}$ Mesh B');
set(h,'Interpreter','latex','FontSize',FSn);
legend boxoff;
box on;

h = xlabel('$Y/H_t$'); set(h,'Interpreter','latex','FontSize',FSn);
h = ylabel('$\mu*/\mu$'); set(h,'Interpreter','latex','FontSize',FSn);

if (pdfE)
fig2pdf([path,f(6).name],6);
end


end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 7- 
if (pfig(7) == 1);
figure(7);hold all;

rho_in = dataM(10,end/2,RHO);
u_in = Ht*Ht*dataM(10,end/2,U);

load('../data/reversed/coarsev2.mat');
plot(time*Up/Ht/1000,Rmom/rho_in/u_in,'k','Linewidth',LW);

load('../data/reversed/mediumv2.mat');
plot(time*Up/Ht/1000,Rmom/rho_in/u_in,'b','Linewidth',LW);

xlim([0 330])
h = legend('Mesh A','Mesh B');set(h,'Interpreter','latex','FontSize',FSn);
legend boxoff;
box on;

h = xlabel('$t U_p/H_t$'); set(h,'Interpreter','latex','FontSize',FSn);
%h = ylabel('$\int{\rho u \mathrm{dV}} / (\rho_{\mathrm{in}}u_{\mathrm{in}}{H_t}^2L)$');
h = ylabel('$M_{\mathrm{bubble}}/M_{\mathrm{inlet}}$');
set(h,'Interpreter','latex','FontSize',FSn);

if (pdfE)
fig2pdf([path,f(7).name],7);
end


end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 8- 
if (pfig(8) == 1);
figure(8);hold all;

plot(xc(:,end/2)/Ht,dataC(:,end/2,P)/Pamb,'k','Linewidth',LW)
hold on;
plot(xm(:,end/2)/Ht,dataM(:,end/2,P)/Pamb,'b','Linewidth',LW)

%% Load the experimental mean
efile = '../data/experiment/NOZZLE_DATA/MEAN/CENTERLINE/MeanCentPress.txt'
Pexp = load(efile);
plot(Pexp(:,1)+.2,Pexp(:,2),'r')

h = xlabel('$X/H_t$');set(h,'Interpreter','latex','FontSize',FSn);
h = ylabel('$P/P_{\mathrm{amb}}$');set(h,'Interpreter','latex','FontSize',FSn);

h = legend('Mesh A','Mesh B','Exp');
set(h,'Interpreter','latex','FontSize',FSn);
legend boxoff;
box on;

xlim([-1 10])
ylim([.3 1.2])

if (pdfE)
fig2pdf([path,f(8).name],8);
end


end
