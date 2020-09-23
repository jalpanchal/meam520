clear
clc

addpath('../Core') % references ROS interface and arm controller files you'll need for every lab


gripper_positions = [];

% To compute the workspace
% We do this by computing all the poistions the gripper can reach.
% This is done by looping through the various positions of all the joints. 
% The step size for the angles can be varied to get better resolution.
for th_1  = -1.4 :0.3 :1.4
    for th_2 = -1.2 :0.5 : 1.4
        for th_3 = -1.8 : 0.5: 1.7
            for th_4 = -1.9 : 0.5 : 1.7
                for th_5 = -2 : 0.5 : 1.5
                        
                        q = [th_1, th_2, th_3, th_4, th_5, 0];
                        [jointPositions, T0e] = calculateFK(q);
                        gripper_positions = [gripper_positions; T0e([13,14,15])];
                                         
                end
            end
        end
    end                
end


% plot the workspace
x = gripper_positions(:,1)
y = gripper_positions(:,2)
z = gripper_positions(:,3)

x_axs = [1.1*min(x),1.1*max(x)]
y_axs = [1.1*min(y),1.1*max(y)]
z_axs = [1.1*min(z),1.1*max(z)]

b_x = boundary(y,z)
b_y = boundary(x,z)
b_z = boundary(x,y)
b_3d = boundary(gripper_positions)

% Zero configuration
q = [0,0,0,0,0,0]
[jointPositions, T0e] = calculateFK(q);


plot3(x,y,z, 'o', 'Color','#FF0000')

grid on
xlabel('Xo')
ylabel('Yo')
zlabel('Zo')
xlim([1.1*min(x),1.1*max(x)])
ylim([1.1*min(y),1.1*max(y)])
zlim([1.1*min(z),1.1*max(z)])

hold on
plot3(x, 1.1*max(y)*ones(size(y)),z, '-', 'Color', '#add8e6')
plot3(x(b_y), 1.1*max(y)*ones(size(x(b_y))), z(b_y), '-', 'Color', '#FF0000')
plot3(1.1*max(x)*ones(size(x)),y,z, '-', 'Color', '#add8e6')
plot3(1.1*max(x)*ones(size(y(b_x))), y(b_x), z(b_x), '-', 'Color', '#FF0000')
plot3(x, y, 1.1*min(z)*ones(size(z)), '-', 'Color', '#add8e6')
plot3(x(b_z), y(b_z),1.1*min(z)*ones(size(x(b_z))) , '-', 'Color', '#FF0000')

% plot robot at zero confoguration
plot3(jointPositions(:,1),jointPositions(:,2), jointPositions(:,3),'Color','#000000', 'LineWidth', 5)

% plot axes
plot3(x_axs, zeros(size(x_axs)), zeros(size(x_axs)), 'Color','#A9A9A9', 'LineWidth', 3)
plot3(zeros(size(y_axs)), y_axs, zeros(size(y_axs)), 'Color','#A9A9A9', 'LineWidth', 3)
plot3(zeros(size(z_axs)), zeros(size(z_axs)), z_axs, 'Color','#A9A9A9', 'LineWidth', 3)


trisurf(b_3d,x,y,z, 'Facecolor', 'r', 'FaceAlpha', '0.1')





 





