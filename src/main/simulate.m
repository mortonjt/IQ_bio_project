

% r=rates 
% e=reaction order
x0=xlsread('../constants.xlsx','C3:C18');
e=xlsread('../constants.xlsx','F3:F18');
fwd_rxn=xlsread('../constants.xlsx','D3:D18');
rev_rxn=xlsread('../constants.xlsx','E3:E18');

erk = zeros(1,23);
for t=2:23

    
    
    erk(t) = erk(t)+dx;
end


plot(erk);
