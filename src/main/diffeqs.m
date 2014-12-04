fwdK = xlsread('constant.xlsx',1,'E3:E21');
revK = xlsread('constant.xlsx',1,'F3:F21');

dt = .01;

%initial C
%ordered by substrate id
C = xlsread('constant.xlsx',1,'H3:H24');

%equations
equ = zeros(15);


equ(1) = revK(1)*C(13)+fwdK(14)-fwdK(1)*C(1)*C(2);                                      %d(EGF)/dt     
equ(2) = revK(1)*C(13)+revK(10)*C(8)+fwdK(13)-fwdK(1)*C(1)*C(2)-fwdK(10)*C(15)*C(2);    %d(EGF:EGFR)/dt
equ(3) = fwdK(3)*C(12)*C(4)+fwdK(12)*C(9)*C(12)-fwdK(2)*C(13)*C(3);

equ(4) = fwdK(4)*C(11)-fwdK(3)*C(12)*C(4)+fwdK(19)*C(9)*C(11);
equ(5) = fwdK(5)*C(11)*C(10)-fwdK(6)*C(5)-fwdK(5)*C(11)*C(5);
equ(6) = fwdK(8)*C(9)-fwdK(7)*C(5)*C(6);

equ(7) = fwdK(18)*C(14)-fwdK(9)*C(9)*C(7);
equ(8) = fwdK(10)*C(15)*C(2)-revK(10)*C(8)-fwdK(16)*C(8);
equ(9) = fwdK(7)*C(5)*C(6)-fwdK(8)*C(9);

equ(10) = fwdK(6)*C(5)-fwdK(5)*C(11)*C(10);
equ(11) = fwdK(3)*C(12)*C(4)-fwdK(4)*C(11)-fwdK(19)*C(9)*C(11);
equ(12) = fwdK(2)*C(13)*C(3)+fwdK(17)*C(8)*C(3)-fwdK(3)*C(12)*C(4)-fwdK(12)*C(9)*C(12);

equ(13) = fwdK(1)*C(1)*C(2)-fwdK(11)*C(13)-revK(1)*C(13);
equ(14) = fwdK(9)*C(9)*C(7)-fwdK(18)*C(14);
equ(15) = fwdK(15)*C(14)+revK(10)*C(8)-fwdK(10)*C(15)*C(2);

%
newC = zeros(15);
for i=1:100
    for j=1:15
        newC(j) = C(j)+equ(j);
    end
    C = newC;
end



