w = Solution('liquidvapor.cti', 'water');
T_feed = 230 +273.15;

% Let y be the mass fraction of the evaorating vapor.
%The vapor is used to drive the steam turbine
% P_in >= 200 kPa and P_out >= 8 kPa
P_in  = 200e+03; 
P_out = 8e+03;
set(w, 'T', 25+273.15, 'Vapor', 0) %This is for the ambeint water leaving the separator
h6 = enthalpy_mass(w);
set(w, 'T', 230+273.15, 'Vapor', 0);
h1=enthalpy_mass(w);
h2 = h1;

n = zeros(1, 201); % Empty MAtrix for efficencies
W_out = zeros(1,201);% Empty matrix fo Work output from turbine
P_all = zeros(1,201); % Empty array for Electric Power produced
Quality = zeros(1, 201); % Empty Matrix for quality
Pressure = zeros(1,201);  % Empty Matrix for Pressure
Temp_Flash = zeros(1,201); % Empty Matrix for Temperature at state-2

% Two types of chambers : High Pressure yields small amount of steam, at higher pressure
%                     and Low pressure yields considerable amount of steam
%                     but at lower temperature

% Assume that the water leaving the flash chamber is at the ambient
    % temperature of 25 C.
q_in = (h1 - h6);

for i=1:201
    P = P_in + ((i-1)*10000);
    Pressure(1,i) = P/1000; % Gets stored in kPa
    set(w, 'P', P, 'H', h1); % This is the State-2 as h1 = h2
    Temp_Flash(1,i) = temperature(w);
    y = vaporFraction(w);     % The state 2 and state-3 are no different
    Quality(1,i) = y;
    set(w, 'P', P, 'Vapor', 1);
    h3 = enthalpy_mass(w); %Turbine are asumed to be isentropic h3 = hg at Pressure P
    s3 = entropy_mass(w); % s3 = sg at Pressure P      
    set(w, 'P', P_out, 'S', s3);
    h4 = enthalpy_mass(w);
    w_turb = y*(h3 - h4);
    Power_out = w_turb * 0.9;
    P_all(1,i) = Power_out;
    W_out(1, i) = w_turb;
    % We need to find q_in
    % (1-y) amount of water leaves the Flash chamber, at temperatre T_flash
    % q_in = heat of water entering at 260 - heat of water leaving the
    % flash chamber
    n(1, i) = (Power_out)/q_in;
    P_all(1,i) = P;
end

transpose(W_out)
max(n)
max(W_out)
