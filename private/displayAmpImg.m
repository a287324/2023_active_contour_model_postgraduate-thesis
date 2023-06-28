function [hf_color] = displayAmpImg(im)
    % 強度轉換(因為我介意的是正負值,而不是數值的大小,因此使用sigmoid function來調整數值,讓0值附近的數值變化更明顯,並讓離0值愈遠的數值越不明顯)
    im_scale = tanh(im);
    % 數值調變
    imNormal = colormapNormalize(im_scale);
    % 顯示振幅圖
    hf_color = figure();
    imshow(imNormal, []);
    % 上偽色
    colormap jet	
    colorbar
end