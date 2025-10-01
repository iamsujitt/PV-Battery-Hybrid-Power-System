function duty = MPPT_control(V, I, deltaD_in)
    % Initialize parameters
    duty_init = 0.05;
    duty_min = 0;
    duty_max = 0.75;
    
    % Persistent variables to maintain state between function calls
    persistent Vold Pold duty_old;
    
    % Initialize persistent variables if empty
    if isempty(Vold)
        Vold = 0;
        Pold = 0;
        duty_old = duty_init;
    end
    
    % Calculate current power
    P = V * I;
    
    % Calculate changes in voltage and power
    dv = V - Vold;
    dp = P - Pold; 
    
    % Set initial duty cycle to previous value
    duty = duty_old;
    deltaD = deltaD_in;
    
    % MPPT algorithm (Perturb and Observe method)
    if dp ~= 0
        if dv < 0
            duty = duty_old - deltaD;
        else
            duty = duty_old + deltaD;
        end
    else
        if dv < 0
            duty = duty_old + deltaD;
        else
            duty = duty_old - deltaD;
        end
    end
    
    % Ensure duty cycle stays within bounds
    if duty >= duty_max
        duty = duty_max;
    elseif duty < duty_min
        duty = duty_min;
    end
    
    % Update persistent variables for next iteration
    duty_old = duty;
    Vold = V;
    Pold = P;
end
