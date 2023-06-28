function F = getFeatureDWHT(im, para)
    % 參數
    im = double(im);
    Woffset = (1:para.L) - ceil(para.L/2);
    fBand = para.L/4;
    [x,y] = meshgrid(1:para.imCol, 1:para.imRow);
	P = [x(:), y(:)];
    Arot = getImgRotMarix(para.L);
    % 變數初始化
    F = zeros(size(P,1), 12);    % 特徵值的初始化
	H = fwht(eye(para.L)); % 取得Hadamard matrix
    for n = 1:size(P,1)
        % 取得window位置
        x = Woffset + P(n,1);
        y = Woffset + P(n,2);
        % window邊界檢查(邊界外採用鏡像)
        x(x<1) = -x(x<1) + 2;	x(x>para.imCol) = para.imCol-(x(x>para.imCol)-para.imCol);
        y(y<1) = -y(y<1) + 2;	y(y>para.imRow) = para.imRow-(y(y>para.imRow)-para.imRow);
        % 取出window後,並取得旋轉後的window
        W = im(y(:), x(:));
        Wrot = W(Arot);
        % 計算特徵向量
            % DWHT
        DWHT(:,:,1) = Wrot(:,:,1)*H;  % 0度
        DWHT(:,:,2) = Wrot(:,:,2)*H;  % 45度
        DWHT(:,:,3) = Wrot(:,:,3)*H;  % 90度
        DWHT(:,:,4) = Wrot(:,:,4)*H;  % 135度
            % 統計(M)
        reg = mean(abs(DWHT), 1);  % 全取
        reg = [mean(reg(:, 1:fBand, :), 2), mean(reg(:, (fBand+1):(2*fBand), :), 2), mean(reg(:, (2*fBand+1):end, :), 2)];  % 劃分3個sequency band
%         reg = [mean(reg(:, 1:fBand, :), 2), mean(reg(:, (fBand+1):(2*fBand), :), 2), mean(reg(:, (2*fBand+1):(3*fBand), :), 2), mean(reg(:, (3*fBand+1):end, :), 2)];   % 劃分4個sequency band
% 原始論文是說可以取3頻帶或4頻帶，但是經過實測後，這2者對於Fext振幅圖的有效分割結果的差異很小(大約只有萬分之5左右的影響，另外目前我測試的圖片來看3頻帶比4頻帶的結果好的數量比較多)
        F(n,:) = reshape(reg, 1, 12);
    end
end

function Arot = getImgRotMarix(L)
    % 設置偏移量矩陣
    reg = reshape(1:L*L, L, L);
    reg = repmat(reg, 1, 3);
    
    % 矩陣初始化及index設置
    Arot = zeros(L, L, 4);
    ind = reshape((L*L+1):(2*L*L), L, L);
    ind_offset = (0:L:(L*(L-1))).';
    % 生成
    Arot(:,:,1) = reg(ind);                 % 0度
    Arot(:,:,2) = reg(ind + ind_offset).';	% 45度
    Arot(:,:,3) = Arot(:,:,1).';            % 90度
    Arot(:,:,4) = reg(ind - ind_offset).';	% 135度
end