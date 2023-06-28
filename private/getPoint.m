% 最原始的取點函式(物件點/背景點/輪廓點,每個點都是手動選取)
function P = getPoint(im, para)
	P = struct;
    % 物件點
    fp = figure();  imshow(uint8(im), []);
	title('請使用滑鼠決定物件點,按Enter結束');
    [x,y] = getpts;
	P.Object = [x(:) y(:)];
    figure(fp); hold on; plot(P.Object(:,1),P.Object(:,2),'r.', 'MarkerSize', 20);
    pause(1);   close(fp);
    % 背景點
    fp = figure();  imshow(uint8(im), []);
	title('請使用滑鼠決定背景點,按Enter結束');
    [x,y] = getpts;
	P.BG = [x(:) y(:)];
    figure(fp); hold on; plot(P.BG(:,1),P.BG(:,2),'b.', 'MarkerSize', 20);
    hold on; plot(P.BG(:,1),P.BG(:,2),'b.', 'MarkerSize', 20);
    pause(1);   close(fp);
    % 輪廓點
	fp = figure();  imshow(uint8(im), []);
	title('請使用滑鼠決定輪廓點,按Enter結束');
    [x,y] = getpts;
	P.Contour = [x(:) y(:)];
    % 儲存本次設定的影像點資訊(儲存放這裡是因為我希望儲存的輪廓點是初始設定的輪廓,而非輪廓插點後的輪廓,因為輪廓插點的數量可能會有變動,因此才紀錄最原始的設定的輪廓點)
    save(para.pathContour, 'P');

    % 輪廓點插點
	P.Contour = MakeContourClockwise2D(P.Contour);          % 確保輪廓點是順時針
	P.Contour = InterpolateContourPoints(P.Contour, para.Nc);  % 輪廓點插值
    figure(fp); hold on; plot(P.Contour(:,1),P.Contour(:,2),'g.', 'MarkerSize', 20);
    pause(1);   close(fp);
end