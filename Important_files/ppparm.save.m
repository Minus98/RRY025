function out=pparm(n,i,u)
%
% calculates p-parmeter
% according to Gozalez and Woods p 141.
% needed to calculate ordered Hadamard 
% transform
%
if (i==0) 
     out = bith(n-1,u);
else
     out = bith(n-1-i+1,u) - bith(n-2-i+1,u);
end
