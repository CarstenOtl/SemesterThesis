close all

linewidth = 0.9 ;

[fNameArray_1 , fValueArray_1 , aNameArray_1, aValueArray_1, lNameArray_1, ...
    lValueArray_1, lNameArray_2, lValueArray_2, lNameArray_3, lValueArray_3, ...
    LineStyle, Marker, Color] = plot_settings(10, 9) ;

%% ----------------Crank Force --------------------
fig = figure; 
hold on
plot(ExuCrankForce(:,1),ExuCrankForce(:,2), 'Color', Color{1}, 'LineWidth',linewidth );
plot(ExuCrankForce(:,1),ExuCrankForce(:,3), 'Color', Color{2}, 'LineWidth',linewidth );
hold off
set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)
grid on 
xlabel('Time (s)')
ylabel('Reaction Force (N)')
leg = legend('Force X', 'Force Y');
set(leg, lNameArray_1, lValueArray_1);
%print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\crankForce_eps', '-depsc');

%% --------------- displacement plots----------------------------------------- 
fig = figure ;
xlim([0 5])
%plot the data 
hold on
plot(ExuDisplData(:,1), ExuDisplData(:,2), 'Color', Color{1}, 'LineWidth',linewidth) ;
% plot(FExuDisplData(:,1), FExuDisplData(:,2), 'Color', Color{2},'LineWidth',linewidth) ; %second set of data
plot(xsync, meDispl(k1:end), 'Color', Color{3},'LineWidth',linewidth) ; %thrid set of data
plot(xsync,Accel2Displ_x(k1:end), 'Color', Color{4}, 'LineWidth',linewidth) ;
plot(viconTimesync, vicon3trans(k2:end,1), 'Color', Color{5}, 'LineWidth',linewidth) ;
hold off
set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)
grid on 
xlabel('Time (s)')
ylabel('Displacements (m)')
%leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser Sensor', 'Accelerometer','Vicon')
leg = legend({'EXUDYN rigid', 'Laser Sensor', 'Accelerometer','Vicon'})

set(leg, lNameArray_3, lValueArray_3);
%set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') 
print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\displacements_eps', '-depsc');

%% Zoomed in plot _ displacements
fig = figure ;

hold on 
xlim([0 2])
plot(ExuDisplData(:,1), ExuDisplData(:,2), 'Color', Color{1}, 'LineWidth',linewidth) ;
% plot(FExuDisplData(:,1), FExuDisplData(:,2), 'Color', Color{2},'LineWidth',linewidth) ; %second set of data
plot(xsync, meDispl(k1:end), 'Color', Color{3},'LineWidth',linewidth) ; %thrid set of data
plot(xsync,Accel2Displ_x(k1:end), 'Color', Color{4}, 'LineWidth',linewidth) ;
plot(viconTimesync, vicon3trans(k2:end,1), 'Color', Color{5}, 'LineWidth',linewidth) ;
hold off
set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)
grid on 
xlabel('Time (s)')
ylabel('Displacements (m)')
%leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser Sensor', 'Accelerometer','Vicon')
leg = legend({'EXUDYN rigid', 'Laser Sensor', 'Accelerometer','Vicon'})

set(leg, lNameArray_3, lValueArray_3);

print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\zoom_displacements_eps', '-depsc');

%% -------------------- angle plots - crank --------------------------
fig2 = figure ;
hold on
plot(ExuCrankAngleData(:,1), ExuCrankAngleData(:,4), 'Color', Color{1},'LineWidth', linewidth) ;
%plot(FExuCrankAnglesData(:,1), FExuCrankAnglesData(:,4), 'Color', Color{2},'LineWidth',linewidth); 
plot(xsync(2:end), me_Theta(2:end), 'Color', Color{3},'LineWidth',linewidth);
%plot(x, encoder_Angle, 'Color', Color{4},'LineWidth',linewidth);
plot(viconTimesync, vicon2Angle(k2:end), 'Color', Color{5},'LineWidth',linewidth);
hold off
xlim([0 5])
set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)

grid on 
xlabel('Time (s)')
ylabel('Angle (rad)')
%leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser','Motor Resolver', 'Vicon')
leg = legend('EXUDYN rigid', 'Laser', 'Vicon')
set(leg, lNameArray_1, lValueArray_1) ;
%set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') 

print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\crankangles_eps', '-depsc');

%% Zoomed in plot - crank angles

fig2 = figure ;

hold on
plot(ExuCrankAngleData(:,1), ExuCrankAngleData(:,4), 'Color', Color{1},'LineWidth', linewidth) ;
%plot(FExuCrankAnglesData(:,1), FExuCrankAnglesData(:,4), 'Color', Color{2},'LineWidth',linewidth); 
plot(xsync, me_Theta, 'Color', Color{3},'LineWidth',linewidth);
%plot(x, encoder_Angle, 'Color', Color{4},'LineWidth',linewidth);
plot(viconTimesync, vicon2Angle(k2:end), 'Color', Color{5},'LineWidth',linewidth);
hold off
xlim([2.5 4])
set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)

grid on 
xlabel('Time (s)')
ylabel('Angle (rad)')
%leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser','Motor Resolver', 'Vicon')
leg = legend('EXUDYN rigid', 'Laser', 'Vicon')
set(leg, lNameArray_1, lValueArray_1) ;

print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\zoom_crankangles_eps', '-depsc');

%% -------------------- angle plots - con rod ------------------------
% fig3 = figure ;
% hold on 
% plot(ExuConrodAnglesData(:,1), ExuConrodAnglesData(:,4), 'Color', Color{1},'LineWidth',linewidth) ;
% plot(FExuConrodAnglesData(:,1), FExuConrodAnglesData(:,4), 'Color', Color{2},'LineWidth',linewidth);
% plot(x, me_Phi, 'Color', Color{3},'LineWidth',linewidth);
% plot(viconTime, vicon2rot(:,1), 'Color', Color{5},'LineWidth',linewidth);
% hold off
% xlim([0 3])
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% grid on
% xlabel('Time (s)')
% ylabel('Angle (rad)')
% leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser sensor', 'Vicon')
% set(leg, lNameArray_1, lValueArray_1);
% %set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') 
% 
% %print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\conrodangles_eps', '-depsc');
% 
% %% zoomed - angles Conrod
% fig3 = figure ;
% 
% xlim([0 1])
% hold on 
% plot(ExuConrodAnglesData(:,1), ExuConrodAnglesData(:,4), 'Color', Color{1},'LineWidth',linewidth) ;
% plot(FExuConrodAnglesData(:,1), FExuConrodAnglesData(:,4), 'Color', Color{2},'LineWidth',linewidth);
% plot(x, me_Phi, 'Color', Color{3},'LineWidth',linewidth);
% plot(viconTime, vicon2rot(:,1), 'Color', Color{5},'LineWidth',linewidth);
% hold off
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% grid on
% xlabel('Time (s)')
% ylabel('Angle (rad)')
% leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser sensor', 'Vicon')
% set(leg, lNameArray_1, lValueArray_1);
% %set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') 
% 
% print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\zoom_conrodangles_eps', '-depsc');

%% -------------------- angVel plots - crank -------------------------
fig4 = figure ; 
hold on 
xlim([0 3])
%plot(ExuCrankAngVelData(:,1), ExuCrankAngVelData(:,4),'Color', Color{1},'LineWidth',linewidth);
%plot(FExuCrankAngVelData(:,1), FExuCrankAngVelData(:,4),'Color', Color{2},'LineWidth',linewidth);
%plot(xsync(2:end), me_crankAngvel, 'Color', Color{3},'LineWidth',linewidth);
plot(ExuCrankAngVelData(:,1), ExuCrankAngVelData(:,4),'Color', Color{1},'LineWidth',linewidth);
%plot(x, filt_encoder_velocity ,'Color', Color{4},'LineWidth',linewidth);
%plot(viconTime, vicon1angVel(:,1),'Color', Color{5},'LineWidth',linewidth);
hold off

set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)
grid on 
xlabel('Time (s)')
ylabel('Angular Velocity (Hz)')

%leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser sensor' ,'Motor resolver', 'Vicon')
leg = legend('EXUDYN rigid', 'Laser sensor' ,'Motor resolver', 'Vicon')
set(leg, lNameArray_3, lValueArray_3);
%set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') ;

%print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\crankangVelTest_eps', '-depsc');

%% zoomed - crank AngVel
fig4 = figure ; 
hold on 
xlim([0.1 0.8])
%plot(ExuCrankAngVelData(:,1), ExuCrankAngVelData(:,4),'Color', Color{1},'LineWidth',linewidth);
%plot(FExuCrankAngVelData(:,1), FExuCrankAngVelData(:,4),'Color', Color{2},'LineWidth',linewidth);
%plot(xsync(2:end), me_crankAngvel, 'Color', Color{3},'LineWidth',linewidth);
plot(ExuCrankAngVelData(:,1), ExuCrankAngVelData(:,4),'Color', Color{1},'LineWidth',linewidth);
%plot(x, filt_encoder_velocity ,'Color', Color{4},'LineWidth',linewidth);
%plot(viconTime, vicon1angVel(:,1),'Color', Color{5},'LineWidth',linewidth);
hold off

set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)
grid on 
xlabel('Time (s)')
ylabel('Angular Velocity (rad/s)')

%leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser sensor' ,'Motor resolver', 'Vicon')
leg = legend('Laser sensor','EXUDYN rigid', 'Laser sensor' ,'Motor resolver', 'Vicon')
set(leg, lNameArray_3, lValueArray_3);

%print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\zoom_crankangVel_eps', '-depsc');

%% -------------------- angVel plots - con rod -----------------------
% fig5 = figure ;
% hold on
% plot(ExuConrodAngVelData(:,1), ExuConrodAngVelData(:,4),'Color', Color{1},'LineWidth',linewidth)
% plot(FExuConrodAngVelData(:,1), FExuConrodAngVelData(:,4),'Color', Color{2},'LineWidth',linewidth);
% plot(x, me_conrodAngvel, 'Color', Color{3},'LineWidth',linewidth);
% plot(viconTime, vicon2angVel(:,1),'Color', Color{5},'LineWidth',linewidth);
% hold off
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% grid on 
% xlabel('Time (s)')
% ylabel('Angular Velocity (rad/s)')
% 
% leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser sensor', 'Vicon')
% set(leg, lNameArray_1, lValueArray_1);
% %set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') ;
% 
% print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\conrodangVel_eps', '-depsc');
% 
% %% zoomed - conrod AngVel
% fig5 = figure ;
% xlim([0 1])
% hold on 
% plot(ExuConrodAngVelData(:,1), ExuConrodAngVelData(:,4),'Color', Color{1},'LineWidth',linewidth)
% plot(FExuConrodAngVelData(:,1), FExuConrodAngVelData(:,4),'Color', Color{2},'LineWidth',linewidth);
% plot(x, me_conrodAngvel, 'Color', Color{3},'LineWidth',linewidth);
% plot(viconTime, vicon2angVel(:,1),'Color', Color{5},'LineWidth',linewidth);
% hold off
% 
% set(gcf, fNameArray_1, fValueArray_1)
% grid on 
% xlabel('Time (s)')
% ylabel('Angular Velocity (rad/s)')
% 
% leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser sensor', 'Vicon')
% set(leg, lNameArray_1, lValueArray_1);
% %set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') ;
% 
% %print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\zoom_conrodangVel_eps', '-depsc');

%% -------------------- acceleration x - con rod ------------------
fig = figure 
hold on 
xlim([3 4])
plot(ExuConrodAccel(:,1), ExuConrodAccelBody(:,1), 'Color', Color{1},'LineWidth',linewidth);
%plot(FExuConrodAccelData(:,1), FExuConrodAccelBody(:,1), 'Color', Color{2},'LineWidth',linewidth);
plot(xsync, accel1_xData(k1:end), 'Color', Color{4},'LineWidth',linewidth);
hold off

set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)
grid on 
xlabel('Time (s)')
ylabel('Acceleration (m/{s}^2)')
leg = legend('EXUDYN rigid', 'Accelerometer')
% leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Accelerometer')
set(leg, lNameArray_1, lValueArray_1) ;
%set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') ;

print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\conrodAccelX_eps', '-depsc');

%% zoomed - acceleration x plot - con rod ------------------
fig = figure 
hold on 
xlim([3.5 3.7])
plot(ExuConrodAccel(:,1), ExuConrodAccelBody(:,1), 'Color', Color{1},'LineWidth',linewidth);
%plot(FExuConrodAccelData(:,1), FExuConrodAccelBody(:,1), 'Color', Color{2},'LineWidth',linewidth);
plot(xsync, accel1_xData(k1:end), 'Color', Color{4},'LineWidth',linewidth);
hold off

set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)
grid on 
xlabel('Time (s)')
ylabel('Acceleration (m/{s}^2)')
leg = legend('EXUDYN rigid', 'Accelerometer')
% leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Accelerometer')
set(leg, lNameArray_1, lValueArray_1) ;
%set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') ;

print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\zoom_conrodAccelX_eps', '-depsc');

%% -------------------- acceleration y plot - conrod -------------------

fig = figure 
hold on 
grid on 
xlim([3 4])
plot(ExuConrodAccel(:,1), ExuConrodAccelBody(:,2), 'Color', Color{1},'LineWidth',linewidth);
%plot(FExuConrodAccelData(:,1), FExuConrodAccelBody(:,1), 'Color', Color{2},'LineWidth',linewidth);
plot(xsync, accel1_yData(k1:end), 'Color', Color{4},'LineWidth',linewidth) ;
hold off

set(gcf, fNameArray_1, fValueArray_1)
%set(gca, aNameArray_1, aValueArray_1)
yticks(-5000:1500:5000)
grid on 
xlabel('Time (s)')
ylabel(['Acceleration (m/{s}^2)'])
leg = legend('EXUDYN rigid', 'Accelerometer')
% leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Accelerometer')
set(leg, lNameArray_1, lValueArray_1) ;
%set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') ;

print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\conrodAccelY_eps', '-depsc');

%% ------Zoomed -- acceleration y plot - conrod -------------------
fig = figure 
hold on 
grid on 
xlim([3.5 3.7])
plot(ExuConrodAccel(:,1), ExuConrodAccelBody(:,2), 'Color', Color{1},'LineWidth',linewidth);
%plot(FExuConrodAccelData(:,1), FExuConrodAccelBody(:,1), 'Color', Color{2},'LineWidth',linewidth);
plot(xsync, accel1_yData(k1:end), 'Color', Color{4},'LineWidth',linewidth) ;
hold off

set(gcf, fNameArray_1, fValueArray_1)
%set(gca, aNameArray_1, aValueArray_1)
yticks(-5000:1500:5000)
grid on 
xlabel('Time (s)')
ylabel(['Acceleration (m/{s}^2)'])
leg = legend('EXUDYN rigid', 'Accelerometer')
% leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Accelerometer')
set(leg, lNameArray_1, lValueArray_1) ;
%set(findall(gcf,'-property','Interpreter'),'Interpreter','latex') ;

print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\zoom_conrodAccelY_eps', '-depsc');

%% ------------------ Slider Acceleration -----------
% fig = figure 
% hold on 
% % plot(ExuSliderAccel(:,1), ExuSliderAccel(:,2), 'Color', Color{1},'LineWidth',linewidth);
% % plot(FExuSliderAccel(:,1), FExuSliderAccel(:,2), 'Color', Color{2},'LineWidth',linewidth);
% plot(x, filt_kistler_accel2_x, 'Color', Color{4},'LineWidth',linewidth);
% hold off
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% grid on 
% xlabel('Time (s)')
% ylabel('X - Accelerations of the Slider (m/{s}^2)')
% leg = legend('EXUDYN rigid','EXUDYN flexible', 'Accelerometer')
% set(leg, lNameArray_1, lValueArray_1) ;
% 
% %print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\sliderAccel_eps', '-depsc');
% 
% %% ----- Zoomed -- Slider Acceleration -----------
% fig = figure 
% hold on 
% % plot(ExuSliderAccel(:,1), ExuSliderAccel(:,2), 'Color', Color{1},'LineWidth',linewidth);
% % plot(FExuSliderAccel(:,1), FExuSliderAccel(:,2), 'Color', Color{2},'LineWidth',linewidth);
% plot(x, filt_kistler_accel2_x, 'Color', Color{4},'LineWidth',linewidth);
% hold off 
% xlim([1.8 2.3])
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% grid on 
% xlabel('Time (s)')
% ylabel('X - Accelerations of the Slider (m/{s}^2)')
% leg = legend('EXUDYN rigid','EXUDYN flexible', 'Accelerometer')
% set(leg, lNameArray_1, lValueArray_1) ;
% 
% % print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis\figures\zoom_sliderAccel_eps', '-depsc');

%% -------------------- convergence #FE plot -------------------------
% fig = figure
% 
% scatter


%% ------------ plots bearing temperature data ----------
% X = categorical({'PTFE composites', 'PTFE polyamide', 'Filament wound'});
% X = reordercats(X, {'PTFE composites', 'PTFE polyamide', 'Filament wound'});
% ymin =[-200 -30 -50];
% ymax = [250 110 140];
% 
% barplot(ymin,ymax, Color)
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% ylabel('Temperature range (°C)')
% set(gca, 'YGrid', 'on', 'XGrid', 'off')
% 
% print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis\figures\bushingsTemp_eps', '-depsc');

%% -------- bearings friction coeff plot -----------
% ymin= [0.03 ;0.06; 0.03] ;
% ymax= [0.25; 0.15 ;0.08] ;
% h = bar(X, [ymin, ymax-ymin], 'stacked','FaceColor','flat', 'EdgeColor','none') ;
% h(1).Visible = 'off';
% 
% for i = 1:length(ymin)
%         h(1).CData(i,:)= Color{i};
%         h(2).CData(i,:)= Color{i};
% end
% 
% set(gcf, fNameArray_1, fValueArray_1)
% %set(gca, aNameArray_1, aValueArray_1)%,%'YLim', [0, max(ymax)])
% ylabel('Coefficient of Friction')
% set(gca, 'YGrid', 'on', 'XGrid', 'off', 'box', 'off')
% 
% print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis\figures\bushingsFrictionCoeff_eps', '-depsc');

%% -------- bearings static load capacity plot -----------
% 
% ymin = [0 ;0 ;0 ];
% ymax = [250; 80; 200];
% 
% barplot(ymin, ymax, Color)
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% ylabel('Static load capacity (N/{mm}^2)')
% set(gca, 'YGrid', 'on', 'XGrid', 'off')
% 
% print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis\figures\bushingsStaticload_eps', '-depsc');

%% ----------  bearings dynamic load capacity plot -----------
% ymin = [0 ;0 ;0 ];
% ymax = [80; 40 ; 140];
% 
% barplot(ymin, ymax, Color)
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% ylabel('Dynamic load capacity (N/{mm}^2)')
% set(gca, 'YGrid', 'on', 'XGrid', 'off')
% 
% print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis\figures\bushingsDynamicload_eps', '-depsc');

%% ----------  bearings sliding velocity plot -----------
% ymin = [0 ;0 ;0 ];
% ymax = [2; 1 ; 0.5];
% 
% barplot(ymin, ymax, Color)
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% ylabel('Sliding velocity (m/s)')
% set(gca, 'YGrid', 'on', 'XGrid', 'off')
% 
% print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis\figures\bushingsSlidingVel_eps', '-depsc');

%% ------------- Ramp profile Demo -------
% load('RampProfileDemoData.mat') needs to be loaded 
% fig = figure 
% hold on 
% plot(data, 'Color', Color{1},'LineWidth',linewidth);
% hold off 
% ylim([-1 5])
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% grid on 
% xlabel('Time (s)')
% ylabel('Speed of the motor (RPM)')
%leg = legend('EXUDYN rigid','EXUDYN flexible', 'Accelerometer')
%set(leg, lNameArray_1, lValueArray_1) ;
%print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis\figures\rampProfileDemo_eps', '-depsc');

%% -------------- Bode Plot Butterworth filter ---------
% fc = 10;
% fs = 20000;
% 
% [b,a] = butter(4,fc/(fs/2), 'high');
% %w = logspace(-1,3);
% [h,w]=freqz(b,a,[], 500);
% 
% %% Vicon positions plot 
% %slider
% fig = figure 
% 
% hold on
% xlim([0,10])
% plot(viconTimesync, vicon3trans(k2:end,1),'Color', Color{1},'LineWidth',linewidth)
% plot(viconTimesync, vicon3trans(k2:end,2),'Color', Color{2},'LineWidth',linewidth)
% hold off 
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% grid on 
% xlabel('Time (s)')
% ylabel('Position in (m)')
% %leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser Sensor', 'Accelerometer','Vicon')
% leg = legend('X', 'Y')
% 
% set(leg, lNameArray_1, lValueArray_1);
% 
% print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\viconSliderPos_eps', '-depsc');
% %%
% %conrod 
% fig = figure 
% 
% hold on
% xlim([2,12])
% plot(viconTimesync, vicon1trans(k2:end,1),'Color', Color{1},'LineWidth',linewidth)
% plot(viconTimesync, vicon1trans(k2:end,2),'Color', Color{2},'LineWidth',linewidth)
% hold off 
% 
% set(gcf, fNameArray_1, fValueArray_1)
% set(gca, aNameArray_1, aValueArray_1)
% grid on 
% xlabel('Time (s)')
% ylabel('Position in (m)')
% %leg = legend('EXUDYN rigid', 'EXUDYN flexible', 'Laser Sensor', 'Accelerometer','Vicon')
% leg = legend('X', 'Y')
% 
% set(leg, lNameArray_1, lValueArray_1);
% 
% print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\viconConrodPos_eps', '-depsc');
% 
%% Moment Measurements
fig = figure 

hold on 
xlim([0 10])
plot(xsync, Mz(k1:end), 'Color', Color{1},'LineWidth',linewidth)
hold off 

set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)
grid on 
xlabel('Time (s)')
ylabel('Torque (Nm)')
%leg = legend('X', 'Y')

print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor Thesis_1\figures\moments_eps', '-depsc');

%% Resolver Ramp Signal 
fig = figure 

hold on 
xlim([0 20])
plot(x, y2, 'Color', Color{1},'LineWidth',linewidth)
hold off 

set(gcf, fNameArray_1, fValueArray_1)
set(gca, aNameArray_1, aValueArray_1)
grid on 
xlabel('Time (s)')
ylabel('Speed (RPM)')
%leg = legend('X', 'Y')

%print('C:\Users\babarr\Documents\Bachelor\Latex\Bachelor
%Thesis_1\figures\moments_eps', '-depsc'); % for windows

print('/Users/test/Desktop/MotorNosie_eps', '-depsc') %for mac 

