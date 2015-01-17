% Freddy Yang
% Simulation of the Billiard Ball

function outvar=billiard_ball()
clear all;
    %initial conditions
    
    %set(0,'DefaultFigurePosition',[400,100,600,300]);
    r_RED = .05;
    x_RED = .3;
    y_RED = .56%;1-r_RED;
    %m_RED = 160; % mass of RED ball in grams
    x_velocity_RED = 3;
    y_velocity_RED = 4;  %with these magnitudes, a velocity of 5 will be applied

    r_BLUE = .05;
    x_BLUE = 1.5;
    y_BLUE = .7; %1-r_BLUE;
    %m_BLUE = 160; %
    x_velocity_BLUE = 0;
    y_velocity_BLUE = 0;
    
    deltat=.003;
    alpha_friction = .8;
    beta_friction = .99;
    %floor_friction = .995;
    
    t=0;
    t_final=5; % required by the instruction
    
    % keep drawing ball until it stops moving
    % draw mathematical walls
    %Draw_Disk(x_RED,y_RED,r_RED,'r');
    %Draw_Disk(x_blue,y_blue,r_blue);
    while ( t < t_final)% && (x_velocity_RED ~= 0))
       if (t+deltat>t_final)
            deltat=t_final-t;
       end
       t = t + deltat;
       x_RED = x_RED + x_velocity_RED * deltat;
       y_RED = y_RED + y_velocity_RED * deltat;
       
       x_BLUE = x_BLUE + x_velocity_BLUE * deltat;
       y_BLUE = y_BLUE + y_velocity_BLUE * deltat;
       
       % change direction and magnitude of velocity if the RED ball hits a wall       
       if (x_RED + r_RED  >=  2) % radius is divided by 2 so I will get a perfect circle instead of an ellipse when I have the x_axis = 2 * y_axis
            x_RED = 2 - r_RED;
            x_velocity_RED = alpha_friction*(x_velocity_RED * -1);
            y_velocity_RED = beta_friction*y_velocity_RED;
       end
       if (x_RED - r_RED <= 0)
           x_RED = r_RED;
           x_velocity_RED = alpha_friction*(x_velocity_RED * -1);
           y_velocity_RED = beta_friction*y_velocity_RED;
       end
       if ( y_RED - r_RED <=  0)
           y_RED = r_RED;
           x_velocity_RED = alpha_friction*(x_velocity_RED * 1);
           y_velocity_RED = beta_friction*(y_velocity_RED * -1);
       end
       if ( y_RED + r_RED >= 1)
           y_RED = 1 - r_RED;       
           x_velocity_RED = alpha_friction*(x_velocity_RED * 1);
           y_velocity_RED = beta_friction*(y_velocity_RED * -1);
       end    

       
       
       % change direction and magnitude of velocity if the BLUE ball hits a wall      
       if (x_BLUE + r_BLUE  >=  2) % radius is divided by 2 so I will get a perfect circle instead of an ellipse when I have the x_axis = 2 * y_axis
            x_BLUE = 2 - r_BLUE;
            x_velocity_BLUE = alpha_friction*(x_velocity_BLUE * -1);
            y_velocity_BLUE = beta_friction*y_velocity_BLUE;
       end
       if (x_BLUE - r_BLUE <= 0)
           x_BLUE = r_BLUE;
           x_velocity_BLUE = alpha_friction*(x_velocity_BLUE * -1);
           y_velocity_BLUE = beta_friction*y_velocity_BLUE;
       end
       if ( y_BLUE - r_BLUE <=  0)
           y_BLUE = r_BLUE;
           x_velocity_BLUE = alpha_friction*(x_velocity_BLUE * 1);
           y_velocity_BLUE = beta_friction*(y_velocity_BLUE * -1);
       end
       if ( y_BLUE + r_BLUE >= 1)
           y_BLUE = 1 - r_BLUE;       
           x_velocity_BLUE = alpha_friction*(x_velocity_BLUE * 1);
           y_velocity_BLUE = beta_friction*(y_velocity_BLUE * -1);
       end    

      % interact if two ball collides
      if (norm([x_RED, y_RED] - [x_BLUE, y_BLUE]) <=  r_RED*2)
            theta = atand ((y_RED - y_BLUE)/(x_RED - x_BLUE))*180/pi;   
            
            % find the new delta t after the collision
            
            v_blue_new = sqrt((x_velocity_BLUE - x_velocity_RED)^2 + (y_velocity_BLUE - y_velocity_RED)^2)
            distance = norm([x_RED, y_RED] - [x_BLUE, y_BLUE])-2*r_RED;
            deltat_new = (distance)/abs(v_blue_new);

            x_RED = x_RED + x_velocity_RED * deltat_new;
            y_RED = y_RED + y_velocity_RED * deltat_new;
       
            x_BLUE = x_BLUE + x_velocity_BLUE * deltat_new;
            y_BLUE = y_BLUE + y_velocity_BLUE * deltat_new;
            
            if (theta < 0)
                theta_temp  = norm( theta );
                velocity_n_RED = cos(theta_temp) * x_velocity_RED - sin(theta_temp) * y_velocity_RED;
                velocity_t_RED = sin(theta_temp) * x_velocity_RED + cos(theta_temp) * y_velocity_RED;            
                velocity_n_BLUE = cos(theta_temp) * x_velocity_BLUE - sin(theta_temp) * y_velocity_BLUE;
                velocity_t_BLUE = sin(theta_temp) * x_velocity_BLUE + cos(theta_temp) * y_velocity_BLUE;
            else
                velocity_n_RED = cos(theta) * x_velocity_RED + sin(theta) * y_velocity_RED;
                velocity_t_RED = - sin(theta) * x_velocity_RED + cos(theta) * y_velocity_RED;            
                velocity_n_BLUE = cos(theta) * x_velocity_BLUE + sin(theta) * y_velocity_BLUE;
                velocity_t_BLUE = - sin(theta) * x_velocity_BLUE + cos(theta) * y_velocity_BLUE;
            end
            temp = velocity_n_BLUE;
            velocity_n_BLUE = velocity_n_RED;
            velocity_n_RED = temp;
            
            x_velocity_RED = cos(theta)*velocity_n_RED - sin(theta)*velocity_t_RED;
            y_velocity_RED = sin(theta)*velocity_n_RED + cos(theta)*velocity_t_RED;
            x_velocity_BLUE = cos(theta)*velocity_n_BLUE - sin(theta)*velocity_t_BLUE;
            y_velocity_BLUE = sin(theta)*velocity_n_BLUE + cos(theta)*velocity_t_BLUE;
           
            
            v_blue_new_2 = sqrt((x_velocity_BLUE - x_velocity_RED)^2 + (y_velocity_BLUE - y_velocity_RED)^2)
      end
  
            
       Draw_Disk(x_RED,y_RED,r_RED,'r');
       hold on
       Draw_Disk(x_BLUE,y_BLUE,r_BLUE,'b');

       hold off
       drawnow
    end
 end


function outvar=Draw_Disk(x,y,r,color)
    n=100;
    for i=1:n
       theta=i*(2*pi/n);
       X(i)=x+r*cos(theta); % radius is divided by 2 so I will get a perfect circle instead of an ellipse when I have the x_axis = 2 * y_axis
       Y(i)=y+r*sin(theta);
    end
    
    axis equal;
    axis([0 2, 0 1]);
    fill(X,Y,color); % fills (in red 'r') the 2-D polygon defined by vectors X and Y

    %axis equal off
    set(gca, 'color', [0 1 0])
    %specify xlim
    title('Simulation of Billiard Ball','FontSize',14);
    set(gca,'xtick',[]); set(gca,'xticklabel',[]);
    set(gca,'ytick',[]); set(gca,'yticklabel',[]);
    %set(gca,'plotboxaspectratio',[2,1,1]);
    %xlim([0,2]);
    %ylim([0,1]);
    %set (gcf,'Position',[400,100,600,300], 'color','w')
    %xlim([0,2]);
    % drawnow
    
end