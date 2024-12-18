function mcgama
%This program is a direct conversion of the corresponding Fortran program in
%S. Zhang & J. Jin "Computation of Special Functions" (Wiley, 1996).
%online: http://iris-lee3.ece.uiuc.edu/~jjin/routines/routines.html
%
%Converted by f2matlab open source project:
%online: https://sourceforge.net/projects/f2matlab/
% written by Ben Barrowes (barrowes@alum.mit.edu)
%

%     ==========================================================
%     Purpose: This program computes the gamma function Γ(z)
%     or ln[Γ(z)]for a complex argument using
%     subroutine CGAMA
%     Input :  x  --- Real part of z
%     y  --- Imaginary part of z
%     KF --- Function code
%     KF=0 for ln[Γ(z)]
%     KF=1 for Γ(z)
%     Output:  GR --- Real part of ln[Γ(z)]or Γ(z)
%     GI --- Imaginary part of ln[Γ(z)]or Γ(z)
%     Examples:
%     x         y           Re[Γ(z)]Im[Γ(z)]
%     --------------------------------------------------------
%     2.50      5.00     .2267360319D-01    -.1172284404D-01
%     5.00     10.00     .1327696517D-01     .3639011746D-02
%     2.50     -5.00     .2267360319D-01     .1172284404D-01
%     5.00    -10.00     .1327696517D-01    -.3639011746D-02
%     x         y          Re[lnΓ(z)]Im[lnΓ(z)]
%     ---------------------------------------------------------
%     2.50      5.00    -.3668103262D+01     .5806009801D+01
%     5.00     10.00    -.4285507444D+01     .1911707090D+02
%     2.50     -5.00    -.3668103262D+01    -.5806009801D+01
%     5.00    -10.00    -.4285507444D+01    -.1911707090D+02
%     ==========================================================
x=[];y=[];kf=[];gr=[];gi=[];
x=0;
y=0;
gr=0;
gi=0;
fprintf(1,'%s \n','  please enter kf, x and y');
%     READ(*,*)KF,X,Y
kf=1;
x=2.5;
y=5.0;
fprintf(1,'%0.15g \n');
if(kf == 1);
  fprintf(1,'%s ','       x         y           re[Γ(z)]');fprintf(1,'%s \n', '           im[Γ(z)]');
else;
  fprintf(1,'%s ','       x         y          re[lnΓ(z)]');fprintf(1,'%s \n', '         im[lnΓ(z)]');
end;
fprintf(1,'%s ','    ------------------------------------');fprintf(1,'%s \n', '---------------------');
[x,y,kf,gr,gi]=cgama(x,y,kf,gr,gi);
fprintf(1,[repmat(' ',1,1),repmat('%10.2g',1,2),repmat('%20.10g',1,2) ' \n'],x,y,gr,gi);
%format(1x,2f10.2,2d20.10);
end
function [x,y,kf,gr,gi]=cgama(x,y,kf,gr,gi,varargin);
%     =========================================================
%     Purpose: Compute the gamma function Γ(z)or ln[Γ(z)]
%     for a complex argument
%     Input :  x  --- Real part of z
%     y  --- Imaginary part of z
%     KF --- Function code
%     KF=0 for ln[Γ(z)]
%     KF=1 for Γ(z)
%     Output:  GR --- Real part of ln[Γ(z)]or Γ(z)
%     GI --- Imaginary part of ln[Γ(z)]or Γ(z)
%     ========================================================
a=zeros(1,10);
x1=0.0;
pi=3.141592653589793d0;
a(:)=[8.333333333333333d-02,-2.777777777777778d-03,7.936507936507937d-04,-5.952380952380952d-04,8.417508417508418d-04,-1.917526917526918d-03,6.410256410256410d-03,-2.955065359477124d-02,1.796443723688307d-01,-1.39243221690590d+00];
if(y == 0.0d0&x == fix(x)&x <= 0.0d0);
  gr=1.0d+300;
  gi=0.0d0;
  return;
elseif(x < 0.0d0);
  x1=x;
  y1=y;
  x=-x;
  y=-y;
end;
x0=x;
if(x <= 7.0);
  na=fix(7-x);
  x0=x+na;
end;
z1=sqrt(x0.*x0+y.*y);
th=atan(y./x0);
gr=(x0-.5d0).*log(z1)-th.*y-x0+0.5d0.*log(2.0d0.*pi);
gi=th.*(x0-0.5d0)+y.*log(z1)-y;
for  k=1:10;
  t=z1.^(1-2.*k);
  gr=gr+a(k).*t.*cos((2.0d0.*k-1.0d0).*th);
  gi=gi-a(k).*t.*sin((2.0d0.*k-1.0d0).*th);
end;  k=10+1;
if(x <= 7.0);
  gr1=0.0d0;
  gi1=0.0d0;
  for  j=0:na-1;
    gr1=gr1+.5d0.*log((x+j).^2+y.*y);
    gi1=gi1+atan(y./(x+j));
  end;  j=na-1+1;
  gr=gr-gr1;
  gi=gi-gi1;
end;
if(x1 < 0.0d0);
  z1=sqrt(x.*x+y.*y);
  th1=atan(y./x);
  sr=-sin(pi.*x).*cosh(pi.*y);
  si=-cos(pi.*x).*sinh(pi.*y);
  z2=sqrt(sr.*sr+si.*si);
  th2=atan(si./sr);
  if(sr < 0.0d0);
    th2=pi+th2;
  end;
  gr=log(pi./(z1.*z2))-gr;
  gi=-th1-th2-gi;
  x=x1;
  y=y1;
end;
if(kf == 1);
  g0=exp(gr);
  gr=g0.*cos(gi);
  gi=g0.*sin(gi);
end;
return;
end
