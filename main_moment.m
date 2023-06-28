clearvars; clc; close all;
%% 程式執行選項
    % 讀取以前的選項及參數
para.imgName = '8068';
load(['result\proposed\', para.imgName,'\', para.imgName,'.mat']);
%     % 手動調整參數
% %% 設置執行選項
% para.getNewContour = false;
% 	% ACM
% para.runACM = true;
% para.displayProcessACM = true;
% para.displayResultImgACM = true;
% para.saveDataACM = false;
% 	% Eext
% para.displayEext = true;
% para.saveDataEext = false;
% 
% %% 設置執行路徑
% para.imgName = '8068';
% para.imgType = "nature";
% % imgName = '55_104_2';
% % imgType = "synthesis";
% if isequal(para.imgType, "nature")
%     para.testimg = ['testdata\img\', para.imgName,'.jpg'];
% elseif isequal(para.imgType, "synthesis")
%     para.testimg = ['testdata\img\', para.imgName,'.gif'];
% else
%     error("Error: para.testimg");
% end
% para.idealEdge = ['testdata\idealEdge\', para.imgName,'.mat'];
% para.idealImg = ['testdata\idealImg\', para.imgName,'.gif'];
% para.pathContour = ['testdata\imgPoints\', para.imgName,'.mat'];
% para.pathResult = ['result\moment\', para.imgName,'\'];
% 
% %% ACM參數
% para.it = 200;
% para.Nc = 100;  % 輪廓點數量
% para.SC = 0.2;  % Stop Condition
% % Fint
% para.alpha = 0;
% para.beta = 0.00;
% para.gamma = 1;
% % Eext
% para.L = 4;
% para.epsilon = 4/(255*(2*para.L+1)^2);
% para.Nneighbor = 10;
% % Fext
% para.delta = 1;

%% ACM主程式

% 讀取影像
im = imread([para.testimg]);
if size(im, 3) == 3
    im = rgb2gray(im);
end
[para.imRow, para.imCol] = size(im);

% 設置輪廓、物件、背景點
if para.getNewContour
    P = getPoint(im, para);
else
    load(para.pathContour); 
    if size(P.Contour, 2) == 2
        P.Contour = MakeContourClockwise2D(P.Contour);               % 確保輪廓點是順時針
        P.Contour = InterpolateContourPoints(P.Contour, para.Nc);  % 輪廓點內插到指定數量
    elseif size(P.Contour, 2) == 4	% 這個是用於輪廓為方形
        P.Contour = InterpolateRectPoints(P.Contour, para.Nc);
    else
        error("輪廓點資料錯誤\n");
    end
end


%% 取得影像特徵
F = getFeatureMoment(im, para);

% 取得物件點和背景點的特徵
Ovec = getFeatureImgPoint(F, P.Object, para);
Bvec = getFeatureImgPoint(F, P.BG, para);

% 計算k值: 最近鄰點(每個影像點與最近鄰的背景點和物件點各自建模)
% 影像各點近鄰的物件點和背景點
[x,y] = meshgrid(1:para.imCol, 1:para.imRow);
P.ImgPoint = [x(:), y(:)];
[~, Odistarg] = mink(vecnorm(P.ImgPoint - permute(P.Object, [3 2 1]), 2, 2), para.Nneighbor, 3);
[~, Bdistarg] = mink(vecnorm(P.ImgPoint - permute(P.BG, [3 2 1]), 2, 2), para.Nneighbor, 3);
% 取出各個輪廓點近鄰的物件和背景特徵
CnearObjfeature = permute(reshape(permute(Ovec(Odistarg, :), [2, 1]), size(Ovec,2), size(P.ImgPoint, 1), para.Nneighbor), [2, 1, 3]);
CnearBGfeature = permute(reshape(permute(Bvec(Bdistarg, :), [2, 1]), size(Bvec,2), size(P.ImgPoint, 1), para.Nneighbor), [2, 1, 3]);
% 計算k值
Omean = mean(CnearObjfeature, 3);
Osigma = std(CnearObjfeature, 0, 3);
Bmean = mean(CnearBGfeature, 3);
Bsigma = std(CnearBGfeature, 0, 3);
k = getIdealK(Bmean, Bsigma, Omean, Osigma);

% 計算Eext
Eext = 1 - vecnorm((F-Omean)./(Osigma+eps), 2, 2)./(k + eps);
%% Eext 
if or(para.displayEext, para.saveDataEext)
    % 將Eext轉成imEext
    imEext = zeros(para.imRow, para.imCol);
    imEext(:) = Eext(:);
    imEextPrecision = calPrecisionMetricFext(imEext, para);
    fprintf("Eext準確率 = %.4f\n", imEextPrecision);
    % 顯示imEext
    if para.displayEext
        hf_color = displayAmpImg(imEext);
    end
    % 儲存imEext
    if para.saveDataEext
        % 儲存振幅圖
        imColor = colormapAmpImg(imEext);
        imwrite(imColor, [para.pathResult, 'Eext.jpg']);
    end
end

%% ACM執行
if para.runACM 
    % 設置內部能量的矩陣
    B = getInternalForceMatrix(para.Nc, para.alpha, para.beta, para.gamma);
    % 顯示底圖
    if para.displayProcessACM
        hf1 = figure(); imshow(im, []); hold on;
        hcon = [];
    end
    % 輪廓迭代
    for n = 1:para.it
        % 計算Fext
        Fext = getFextMoment(P.Contour, Eext, para);
        % 更新輪廓
	    [P.Contour, flagIt] = updateContour(P.Contour, B, Fext, para);
	    % 顯示輪廓
        if para.displayProcessACM
            if(ishandle(hcon)) % 刪除上一個輪廓
                delete(hcon);
            end
            % 顯示當前輪廓點
            figure(hf1);  hcon = plot(P.Contour(:,1),P.Contour(:,2),'r.');
            % 顯示當前輪廓線
            c=n/para.it;
            figure(hf1);  plot([P.Contour(:,1);P.Contour(1,1)],[P.Contour(:,2);P.Contour(1,2)],'-','Color',[c 1-c 0]);  drawnow;
            title("Iteration: " + string(n));
        end
        if flagIt == true
            break;
        end
    end
    % 紀錄迭代次數
    ItUpdate = n;
    % 當前輪廓的客觀指標
    [MDAD, Escb, Ecbs] = calPrecisionMetric(P.Contour, para);
    
    % 顯示結果圖
    if para.displayResultImgACM
        hf2 = figure();
        imshow(im, []); 
        hold on; 
%         plot(P.Contour(:,1),P.Contour(:,2),'r.', 'MarkerSize', 10);
        plot([P.Contour(:,1);P.Contour(1,1)],[P.Contour(:,2);P.Contour(1,2)],'r-', 'LineWidth', 3);
    else
        hf2 = 0;     % 初始化
    end
    
    % 儲存結果
    % fprintf("it = %d\t MDAD = %f\t Escb = %f\n", n, MDAD, Escb);
    if para.saveDataACM
        % 結果圖
        if para.displayResultImgACM
            exportgraphics(hf2, [para.pathResult, para.imgName, '_result.jpg']);
        else    % 如果沒有顯示結果圖的話,重新顯示,並儲存結果影像後,關閉
            hf2 = figure();
            imshow(im, []); 
            hold on; 
%             plot(P.Contour(:,1),P.Contour(:,2),'r.', 'MarkerSize', 10);
            plot([P.Contour(:,1);P.Contour(1,1)],[P.Contour(:,2);P.Contour(1,2)],'r-', 'LineWidth', 3);
            exportgraphics(hf2, [para.pathResult, para.imgName, '_result.jpg']);
            close(hf2);
        end
        % 儲存實驗數據(初始輪廓.系統參數.系統結果)
        load(para.pathContour); % 重新讀取初始輪廓,把初始輪廓的數據也保留到一個檔案,避免初始輪廓消失
        save([para.pathResult, para.imgName, '.mat'], 'P');
        save([para.pathResult, para.imgName, '.mat'], 'para', '-append');
        save([para.pathResult, para.imgName, '.mat'], 'MDAD', '-append');
        save([para.pathResult, para.imgName, '.mat'], 'Escb', '-append');
        save([para.pathResult, para.imgName, '.mat'], 'Ecbs', '-append');
	    save([para.pathResult, para.imgName, '.mat'], 'ItUpdate', '-append');
    end
%     tt = [MDAD; Escb; Ecbs; ItUpdate]
    fprintf("MDAD = %.4f\n", MDAD);
    fprintf("Escb = %.4f\n", Escb);
    fprintf("Ecbs = %.4f\n", Ecbs);
    fprintf("ItUpdate = %d\n", ItUpdate);
end