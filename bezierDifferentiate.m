% Differentiates an interpolated set of points for a bezier curve fitted by
% Dr. Murtaza Khan's code, email drkhanmurtaza@gmail.com

% Written by David Yang, contact at dayy@linux.ucla.edu
function [p0matd,p1matd] = bezierDifferentiate(p0mat,p1mat,p2mat,p3mat)
    [height,~] = size(p0mat);
    p0matd = zeros(height,2);
    p1matd = zeros(height,2);
    
    for i = 1:height
        p0matd(i,:) = p2mat(i,:)-2*p1mat(i,:)+p0mat(i,:);
        p1matd(i,:) = p3mat(i,:)-2*p2mat(i,:)+p1mat(i,:);
    end
end