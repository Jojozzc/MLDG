%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function：     生成公平约束掩模FCM，每个像素点只能被遮挡一次,M1+M2+……Mn = (N-1)O
% @Parameters：  img_size    图像大小 如[255, 255]
%                A           每张模板上0的比例,0 < A < 1，写成分数，类似1/5
% @Return:       公平约束掩模FCM 是一个cell，FCM{i}代表第i个模板
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FCM = FairConstraintMask(img_size, A)
    if A <= 0 || A > 1
        FCM = cell(0);
        return;
    end
    m = img_size(1);   % 图像高
    n = img_size(2);    %图像宽
    Nmax = fix(1 / A);     % 模板最大数目
    FCM = cell(Nmax, 1);     % 结果是一个cell，FCM(i)代表第i个模板
    pixel_num = m * n;              % 总像素数
    dark_num = fix (m * n * A );      % 每个模板上被遮挡的像素个数，即0的个数
%     fprintf('每张上0的个数为：%d\n',dark_num);
    rand_index = randperm(pixel_num);    % 将1~pixel_num数组打乱，例如有10个像素的时候，可能打乱成：4,1,9,2,5,6,10,7,3,8
    
    for i = 1 : Nmax     % 每次生成一个模板FCM{i}
        temp = ones(m, n); % 生成全为1的m x n矩阵
        
        idx_start = (i - 1) * dark_num + 1;   % 计算应该从哪开始截取rand_index
        idx_end = idx_start + dark_num - 1;   % 计算应该截取到哪，因为每次要遮挡dark_num个像素，所以从打乱的像素中截取dark_num个
        indies = rand_index(idx_start : idx_end); % 截取下来
        
        for j = 1 : dark_num  % 每次遮挡1个 一共遮挡adrk_num个
            x = fix((indies(j) - 1) / n) + 1;  % 根据编号计算行
            y = mod((indies(j) - 1) , n) + 1;  % 根据编号计算列
            temp(x, y) = 0; % 将(x,y)处置为0
        end
        FCM{i, 1} = temp; % 生成好了第i个模板
    end
end
