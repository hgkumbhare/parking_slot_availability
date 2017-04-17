% function to check how many of the connected components using coordinates of circles of parking slots are ellipse.
function outputs = myEllipse(I,inputs)
    
    % To get connected components
    cc=bwlabel(I,4);
    % axes of x and y are exchanged in matrix and in figure
    cc=cc.';
    outputs=[];
    
    for i = 1:size(inputs,1)
        x=inputs(i,1);
        y=inputs(i,2);
        labelId=cc(x,y);
        [r, c] = find(cc==labelId);
        maxx=max(r);
        minx=min(r);
        maxy=max(c);
        miny=min(c);
        J = I.';
        a2=maxx-minx;
        b2=maxy-miny;
        for j = 1:size(r)
            J(r(j),c(j))=0;
        end
        center=[minx+b2/2 miny+a2/2 ];
        % test is this slot empty
        % check using hough transform
%       minMajorAxis: Minimal length of major axis accepted.
%       maxMajorAxis: Maximal length of major axis accepted.
%       rotation, rotationSpan: Specification of restriction on the angle of the major axis in degrees.
%                                If rotationSpan is in (0,90), only angles within [rotation-rotationSpan,
%                               rotation+rotationSpan] are accepted.
%       minAspectRatio: Minimal aspect ratio of an ellipse (in (0,1))
%       randomize: Subsampling of all possible point pairs. Instead of examining all N*N pairs, runs
%                  only on N*randomize pairs. If 0, randomization is turned off.
%       numBest: Top numBest to return
        params.numBest=5;
        params.rotation=0;
        params.minMajorAxis=int32(b2/2)-20;
        params.maxMajorAxis=int32(a2/2)+20;
 
        temp=I(max(miny-20,0):maxy+20,max(minx-20,0):maxx+20);
        %figure
        %imshow(temp);
        BW = edge(temp,'Sobel');
        %figure;
        %imshow(BW);
        bestFits = ellipseDetection(BW, params);
        for j=1:size(bestFits,1)
            if bestFits(j,3)<(int32(a2/2)+50)  & bestFits(j,4)>(int32(b2/2)-50)
                outputs=[outputs; [max(minx-20,0)+bestFits(j,1) max(miny-20,0)+bestFits(j,2)]];
                break;
            end
        end
        %figure;
        K=J.';
        %imshow(K)
    end
end
