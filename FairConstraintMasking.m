%%%%%%%%%%%%%%%%%%%%%%%%%
% function：   生成公平约束掩模FCM，每个像素点只能被遮挡一次
% @ParameterS：   m      图像行
%                n      图像列
%                A      每张模板上0的比例,0< A < 1
% @Return:       公平约束掩模FCM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FCM = FairConstraintMasking(img_size, A)
    if A <= 0 || A > 1
        FCM = cell(0);
        return;
    end
    m = img_size(1);
    n = img_size(2);
    Nmax = round(1 / A);     % 模板数目最大值Nmax = 1/A，round向下取整
    FCM = cell(Nmax, 1);
    mask_num = round (m * n * A );  % 模板数量
    pixel_num = m * n;            % 像素数
    rand_index = randperm(pixel_num);    
    for i = 1 : Nmax
        indies = rand_index(i : i + mask_num - 1);
        temp = ones(m, n);
        for j = 1 : mask_num
            x = round(indies(j) / n) + 1;
            y = mod(m,indies(j) ) + 1;
            temp(x, y) = 0;
        end
        FCM{i, 1} = temp;
    end
end
