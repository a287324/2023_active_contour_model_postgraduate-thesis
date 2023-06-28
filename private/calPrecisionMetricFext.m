function precision = calPrecisionMetricFext(Fext, para)
    % 讀取理想影像
    Fideal = imread([para.idealImg]);
    if size(Fideal, 3) == 3
	    Fideal = rgb2gray(Fideal);
    end
    % 二值化
    Fext = Fext > 0;
    Fideal = Fideal >= 128;
    
    % 計算精確度
    precisionImg = xor(Fext, Fideal);
    precision = 1 - sum(precisionImg(:)) / length(precisionImg(:));
end