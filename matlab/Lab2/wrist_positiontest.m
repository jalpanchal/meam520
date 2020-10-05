
syms c1 s1 d1 c2 s2 a2 c3 s3 a3 c4 s4 d4 c5 s5 d5
H01 = [ c1 0 -s1 0;
        s1 0 c1 0;
        0 -1 0 d1;
        0 0 0 1];
    
H12 = [s2 c2 0 a2*s2;
      -c2 s2 0 -a2*c2;
      0 0 1 0;
      0 0 0 1];
  
  
H23 = [-s3 -c3 0 -a3*s3;
       c3 -s3 0 a3*c3;
       0 0 1 0;
       0 0 0 1];
   
H34 = [s4 0 -c4 0;
       -c4 0 -s4 0;
        0 -1 0 0 ;
        0 0 0 1];
H4e = [c5 -s5 s5 0;
       s5 c5 -c5 0;
       0 0 1 d4+d5;
       0 0 0 1];
   
H03 = H01*H12*H23;
H3e = H34*H4e

w = H03([13 14 15]);





a1 = [76.2, 146.05, 187.325];
% q1 = [0,0,0,0,0,0];
% q2 = [-0.986, 0, 0.123, 0,1.5,0];
% q3 = [pi/2, 0, pi/4,0,pi/2,0];
% q4 = [0, 1.5, 1.2, 0,0,0];
q5 = [0, 0.3456, -0.5, 0,0,0];

q = q5;
w_1= calc_wrist_pos(a1,q)

q_test = angle_ik(a1, w_1)
q


function [w_value] = calc_wrist_pos(a, q)

    w_value =  [a(2)*cos(q(1))*sin(q(2)) - a(3)*cos(q(1))*sin(q(2))*sin(q(3)) + a(3)*cos(q(1))*cos(q(2))*cos(q(3));
                a(2)*sin(q(1))*sin(q(2)) - a(3)*sin(q(1))*sin(q(2))*sin(q(3)) + a(3)*sin(q(1))*cos(q(2))*cos(q(3));
                a(1) + a(2)*cos(q(2)) - a(3)*cos(q(2))*sin(q(3)) - a(3)*cos(q(3))*sin(q(2))];

end


function [q_value] = angle_ik(a, pos)

    theta1 = atan2(pos(2),pos(1));
    
    theta3 = asin((a(2)^2+ a(3)^2 -(pos(1)^2 + pos(2)^2)-((a(1)-pos(3))^2))/(2*a(2)*a(3)));
    
    theta3_cy = -pi/2 + acos((-a(2)^2 - a(3)^2 +(pos(1)^2 + pos(2)^2)+((a(1)-pos(3))^2))/(2*a(2)*a(3)))
    
    if pos(1) < 0 || pos(2) <0 
        alpha = -1* atan2((sqrt(pos(1)^2 + pos(2)^2)),(a(1)-pos(3)));
    else
        alpha = +1* atan2((sqrt(pos(1)^2 + pos(2)^2)),(a(1)-pos(3)));
    end
    beta = atan2((a(3)*cos(theta3)),(a(2)-a(3)*sin(theta3)));
%     beta = pi/2;
%     alpha_2 = +1* atan2(-1*(a(1)-pos(3)), (sqrt(pos(1)^2 + pos(2)^2)))*180/pi
%     beta_2 = atan2((a(3)*cos(theta3)),(a(2)+a(3)*sin(theta3)))*180/pi
    a_deg = alpha*180/pi
    b_deg = beta*180/pi
    theta2 = pi-alpha-beta;

    
    q_value = [theta1,
                theta2
               theta3];
end
        