forwardrates = xlsread('constant.xlsx',1,'E3:E21');
reverserates = xlsread('constant.xlsx',1,'F3:F21');

dt = .01;

%initial concentrations
%ordered by substrate id
concentrations = xlsread('constant.xlsx',1,'H3:H24');
    
%equations
equ = zeros();

%
equ(1) = reverserates(1)*concentrations(13)+forwardrates(14)-forwardrates(1)*concentrations(1)*concentrations(2);
equ(2) = reverserates(1)*concentrations(13)+reverserates(10)*concentrations(8)+forwardrates(13)-forwardrates(1)*concentrations(1)*concentrations(2)-forwardrates(10)*concentrations(15)*concentrations(2);
equ(3) = forwardrates(3)*concentrations(12)*concentrations(4)+forwardrates(12)*concentrations(9)*concentrations(12)-forwardrates(2)*concentrations(13)*concentrations(3);

equ(4) = forwardrates(4)*concentrations(11)-forwardrates(3)*concentrations(12)*concentrations(4)+forwardrates(19)*concentrations(9)*concentrations(11);
equ(5) = forwardrates(5)*concentrations(11)*concentrations(10)-forwardrates(6)*concentrations(5)-forwardrates(5)*concentrations(11)*concentrations5);
equ(6) = forwardrates(8)*concentrations(9)-forwardrates(7)*concentrations(5)*concentrations(6);

equ(7) = forwardrates(18)*concentrations(14)-forwardrates(9)*concentrations(9)*concentrations(7);
equ(8) = forwardrates(10)*concentrations(15)*concentrations(2)-reverserates(10)*concentrations(8)-forwardrates(16)*concentrations(8);
equ(9) = forwardrates(7)*concentrations(5)*concentrations(6)-forwardrates(8)*concentrations(9);

equ(10) = forwardrates(6)*concentrations(5)-forwardrates(5)*concentrations(11)*concentrations(10);
equ(11) = forwardrates(3)*concentrations(12)*concentrations(4)-forwardrates(4)*concentrations(11)-forwardrates(19)*concentrations(9)*concentrations(11);
equ(12) = forwardrates(2)*concentrations(13)*concentrations(3)+forwardrates(17)*concentrations(8)*concentrations(3)-forwardrates(3)*concentrations(12)*concentrations(4)-forwardrates12)*concentrations(9)*concentrations(12);

equ(13) = forwardrates(1)*concentrations(1)*concentrations(2)-forwardrates(11)*concentrations(13)-reverserates(1)*concentrations(13);
equ(14) = forwardrates(9)*concentrations(9)*concentrations(7)-forwardrates(18)*concentrations(14);
equ(15) = forwardrates(15)*concentrations(14)+reverserates(10)*concentrations(8)-forwardrates(10)*concentrations(15)*concentrations(2);





