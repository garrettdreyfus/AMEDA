function Dx = get_Dx_from_ll(x,y)
% compute the distance matrice from lon and lat matrice
%
% June 2016 B. LE VU
%
disty = sw_dist( y(1:2,1), x(1:2,1), 'km');
ycoords =  y(2:size(x,1)-1,1:size(x,2)-2);
ycoords0 =y(2:size(x,1)-1,3:size(x,2));
xcoords = x(2:size(x,1)-1,1:size(x,2)-2);
xcoords0 = x(2:size(x,1)-1,3:size(x,2));
SPHEROID = referenceEllipsoid('wgs84', 'km'); % // Reference ellipsoid. You can enter 'km' or 'm'    
[N, E]   = geodetic2ned(ycoords, xcoords, 0, ycoords0, xcoords0, 0, SPHEROID);
distx = sqrt(N.^2 + E.^2); 
Dx = nan*x;
Dx(2:size(x,1)-1,2:size(x,2)-1)=(distx+disty)/2;
%for i=2:size(x,1)-1
    %for j=2:size(x,2)-1
        %distx(i,j) = sw_dist( y(i,[j-1 j+1]), x(i,[j-1 j+1]), 'km')/2;
    %end
%end
%Dx = ( distx + disty )/2;
Dx(1,:)  = Dx(2,:)-diff(Dx(2:3,:));
Dx(end,:)= Dx(end-1,:)+diff(Dx(end-2:end-1,:));
Dx(:,1)  = Dx(:,2);
Dx(:,end)= Dx(:,end-1);
