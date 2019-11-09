%% 生成多个噪声图，供模型学习
img_path = './origin.bmp';
img = imread(img_path);

target_dir = 'D:\code\image-denoising\noise-est\origin-gen';
noise_sigmas = 5 : 1 : 55;
num_per_sigma = 100; % 每种噪声生成几张图
for j = 1 : num_per_sigma
    new_file_name = ['0' '-' num2str(j) '.bmp']; % 原图也生成num_per_sigma张
    new_file_path = fullfile(target_dir, new_file_name);
    imwrite(img_noisy, new_file_path);
end

for i = 1 : max(size(noise_sigmas))
    for j = 1 : num_per_sigma
        img_noisy = add_noise(img, noise_sigmas(i));
        new_file_name = [num2str(noise_sigmas(i)) '-' num2str(j) '.bmp'];
        new_file_path = fullfile(target_dir, new_file_name);
        imwrite(img_noisy, new_file_path);
    end

end



function img_noisy = add_noise(img, noise_sigma)
    if ~isa(img,'double')      % 加噪声要求double 0-1
        img = double(img);
    end
    img = img / 255;
    
    NorSigma = noise_sigma/255;         %归一化标准差
    NorVar = NorSigma^2;    %归一化方差
    img_noisy = imnoise(img,'speckle',NorVar);
    % figure,imshow(img);
        
    img_noisy = uint8(img_noisy * 255);   %保存为0-255的uint8
end

