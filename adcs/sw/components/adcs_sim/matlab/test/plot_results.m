% UW HuskySat-1, ADCS Subsystem
%   Last Updated: T. Reynolds 9.8.17

% Plot Results from a run of sim_init.m


% ----- Extract data ----- %
states = logsout.getElement('states').Values;
    sc_quat = states.quaternion; % [ rad ]
    sc_omega = states.body_rates; % [ rad/s ]
    sc_pos_eci = states.position; % [ m ]
    sc_vel_eci = states.velocity; % [ m\s ]
    
disturbances = logsout.getElement('disturbances').Values;

orbit_data = logsout.getElement('orbit_data').Values;

act_meas = logsout.getElement('act_meas').Values;
    
control = logsout.getElement('control').Values;
    ctrl_RW         = control.torque;
    ctrl_dipole     = control.magnetic_dipole;
sens_meas = logsout.getElement('sens_meas').Values;

commands    = logsout.getElement('commands').Values;

sc_mode = logsout.getElement('sc_mode').Values;

ctrl_status    = logsout.getElement('ctrl_status').Values;

sc_in_sun    = logsout.getElement('sc_in_sun').Values;

sc_in_sun_fsw    = logsout.getElement('sc_in_sun_fsw').Values;

orbit_tle_fsw    = logsout.getElement('orbit_tle_fsw').Values;

cur_gps_time     = logsout.getElement('cur_gps_time').Values;

% ----- End extract ----- % 


% ---- Plot Results ---- %
figure(1)
subplot(2,2,1)
plot(sc_quat,'LineWidth',1)
subplot(2,2,2)
plot(sc_omega,'LineWidth',1)
subplot(2,2,3)
plot(sc_pos_eci,'LineWidth',1)
subplot(2,2,4)
plot(sc_vel_eci,'LineWidth',1)

figure(2)
subplot(1,2,1)
plot(ctrl_dipole,'LineWidth',1)
subplot(1,2,2)
plot(ctrl_RW,'LineWidth',1)

figure(3), hold on
plot(sc_mode,'LineWidth',1)
plot(ctrl_status,'LineWidth',1)

REKM = 6378.135; % earth radius [km]
figure(4), hold on
[X, Y, Z]=sphere(100);
X=X.*REKM*1e3;
Y=Y.*REKM*1e3;
Z=Z.*REKM*1e3;
Earth_im = imread('Flat_earth_cds.jpg', 'jpg');
surf(X, Y, Z,'CData',flip(Earth_im,1),'FaceColor','texturemap','EdgeColor','none');
plot3(states.position.Data(:,1),states.position.Data(:,2),states.position.Data(:,3),'r','LineWidth',1)
%quiver3(0,0,0,avg_sc2sun(1),avg_sc2sun(2),avg_sc2sun(3),'LineWidth',1)
xlabel('x-direction [m]')
ylabel('y-direction [m]')
zlabel('z-direction [m]')
%saveas(gcf, strcat(figdir, 'traj_visualization_test1'),'fig')

% ----- End Plots ----- %