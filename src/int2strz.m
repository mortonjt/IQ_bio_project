function [result]=int2strz(x,n)

if x~=0
    digits=floor(log10(x))+1;
else
    digits=1;
end

if digits<n
    del=n-digits;
    i=0;padding=[];
    for i=1:del
       padding=[padding,'0']; 
    end
    result=[padding,int2str(x)];
else
    result=int2str(x);
end

