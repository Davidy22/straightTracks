% Returns an array of the straight worm tracks in input track 'trackIn'.
% Supports 2D and 3D tracks, returns tracks in the same dimension.
% Uses differentited bezier approximations. Cubic approximation code credit
% to Dr. Murtaza Khan, drkhanmurtaza@gmail.com.

%%%%%%%%%%%%%%
% Parameters %
%%%%%%%%%%%%%%
% tolerance - defines how far fitted curve can deviate from track
% data. Lower number means closer fit.
% threshold - defines what range of angles is treated as a turn. Lower
% number means more angles are treated as turning points.

% Written by David Yang, contact at dayy@linux.ucla.edu
function tracks = straightTracks(trackIn, tolerance, threshold, turn)
    [height,~] = size(trackIn);
    ibi = [1;height];
    
    % Bezier approximation
    [p0mat,p1mat,p2mat,p3mat,fbi]=bzapproxu(trackIn,tolerance,ibi);
    
    % Double differentiation
    [p0matd,p1matd] = bezierDifferentiate(p0mat,p1mat,p2mat,p3mat);
    [MatI]=BezierInterpCPMatSegVec(p0matd,p1matd,[],[],fbi);
    figure;
    plot(MatI(:,2),MatI(:,1));
    
    % Gradient finding
    grad = MatI(:,1)/MatI(:,2);
    temp = all(grad==0);
    grad = grad(:,~temp);
    figure;
    plot(grad);
    
    
    grad(abs(grad)>threshold) = NaN;
    grad(abs(grad)<threshold) = 1;
    
    % Splitting straight tracks
    tracks = {};
    start = 1;
    curve = 0;
    tracksize = 1;
    for i = 1:height
        if curve == 0
            if isnan(grad(i))
                tracks = [tracks trackIn(start:i-1,:)];
                curve = 1;
                tracksize = tracksize + 1;
            end
        else
            if ~isnan(grad(i))
                curve = 0;
                start = i;
            end
        end
    end
    
    if curve ~= 0
        tracks = [tracks trackIn(start:i,:)];
    end
end