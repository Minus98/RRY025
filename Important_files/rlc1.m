function output=rlc1(input)
%
% John Conway, Image Processing, ERR041
%    Sept 2000
%
disp('Raster scans a binary image finding runlengths of zeros (Black pixels)')
disp(' A one (white pixel) is represented by a runlength of size 0')
%
disp(' ')
% input('Number of bits for run length');
disp('Each Run is presented by a 7 bit number, and hence can represent runs')
disp(' from 0 to 127') 
nb = 7;
% disp(' Maximum run length is');
%
maxrun= (2^(nb)) - 1;
%
disp(' ')
disp(' ')
disp('Input image has size s1 x s2 pixels where')
[s1 s2]=size(input)
s3 = s1*s2;
%
vec1=double(reshape(input', [1 s3]));
num = zeros(maxrun+1,1);
%
count = 1;
mcount = 0;
%
for i=1:s3
  if ((vec1(i) == 0)&(count<maxrun)) 
    count = count +1;
  else
%
    if (count>mcount)
      mcount = count;
    else
    end
%
    num(count) = num(count)+1;
    count = 1;
  end
end
%
%
xx = linspace(0, maxrun, maxrun+1);
bar(xx, num)
xlabel('Length of zero runs');
ylabel('Number of runs');
%
disp( 'Figure 1 shows histogram of how often each run length value')
disp( 'occurs in image')
disp('  ')
disp('  ')
disp( 'The grand total of the number of runs in image (sum of columns of')
disp( ' above histogram) is') 
nruns=sum(num)
%
disp('Given the numbers above show that a compression ratio of')
nrlc =nruns*nb;
comp1 = s3./nrlc
disp('is possible just using run length coding')
%
disp(' ')
disp(' ')
disp('Pausing, press return to continue')
pause
%
disp('Now consider combining run length and source encoding;')
disp('which means giving common run values short codes and uncommon ones')
disp('long codes')
disp(' ')
disp(' ')
disp( 'Note entropy of run length distribution in Fig 1 is')
ent = iment(num)
disp( ' What is the total compression we can achieve combining run-length')
disp( ' and source/entropy encoding?')
% disp( 'Compression ratio using  Entropy coding')
% comp2 = s3./(nruns.*ent)

