function [C, flagIt] = updateContour(C, B, Fext, para)
	% 更新輪廓
    Cnew = B*(C + para.gamma.*Fext);
	
	% 輪廓點的邊界判斷
    Cnew(Cnew(:,1)<1, 1) = 1; Cnew(Cnew(:,1) > para.imCol, 1) = para.imCol;
    Cnew(Cnew(:,2)<1, 2) = 1; Cnew(Cnew(:,2) > para.imRow, 2) = para.imRow;
	
    % 檢查迭代停止(由於後面輪廓點的間距調整會使調整前後的輪廓點相應位置有點不同,因此檢查輪廓的移動間距需要在內插前)
    if  mean(vecnorm((Cnew-C),2,2)) < para.SC
        flagIt = true;
    else
        flagIt = false;
    end
	
    % 輪廓點間距調整(以保持Fint計算不失真,因為Fint的計算上是以輪廓點等距為前提)
    try
        % 輪廓點插值
        C = InterpolateContourPoints(Cnew, size(C,1));
        % 輪廓點邊界判斷(雖然輪廓點插值不會跑出邊界,但是經過實測後發現原本邊界的點經過內插,由於Matlab的計算精度誤差,導致本來內插後,依然在邊界的點,出現邊界外的數值)
        C(C(:,1)<1, 1) = 1; C(C(:,1) > para.imCol, 1) = para.imCol;
        C(C(:,2)<1, 2) = 1; C(C(:,2) > para.imRow, 2) = para.imRow;
    catch
        warning('輪廓無法內插,中止輪廓的迭代');
        flagIt = true;
    end
end