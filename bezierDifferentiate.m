% Differentiates an interpolated set of points for a bezier curve fitted by
% Dr. Murtaza Khan's code, email drkhanmurtaza@gmail.com

% Written by David Yang, contact at dayy@linux.ucla.edu
function mat = bezierDifferentiate(matIn)
    [height,~] = size(matIn);
    mat = zeros(height-1,2);
    
    for i = 2:height
        mat(i, 1) = height * (matIn(i,1)-matIn(i-1,1));
        mat(i, 2) = height * (matIn(i,2)-matIn(i-1,2));
    end
end