function Fimg = getFimg(im, sigma)
    [dx, dy] = gradient(double(imgaussfilt(im, sigma)));
    [Fimg.x, Fimg.y] = gradient(dx.^2 + dy.^2);
%     [Fimg.x, Fimg.y] = gradient(hypot(dx, dy));
end