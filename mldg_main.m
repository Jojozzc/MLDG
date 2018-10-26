% examples:
img1 = imread('./images/mldg1.jpg');
test_img = [1, 12, 5, 42; 2, 78, 47, 8; 23, 12, 2, 5]; % 4 x 3
% test matrix:
images_after_mask1 = mask_image(uint8(test_img), 10);
% or uint8 image:
images_after_mask2 = mask_image(img1, 10);



function [images_after_mask] = mask_image(original_img, result_size)
    % original_img: 
    % result_size: number of model you wish to create
    % return: images_after_mask, images after dot multi with mask model.
    images_after_mask = cell(result_size, 1);
    mask_imgs = create_mask_imgs_rand_uqe(original_img, result_size);
    for i = 1 : result_size
        images_after_mask{i} = original_img .* uint8(mask_imgs{i, 1});
    end
end
function [mask_imgs] = create_mask_imgs_rand_uqe(img, result_size)
    % Create mask model matrix
    % Each pixel will be mask
    height = size(img, 1);
    width = size(img, 2);
    rand_marix = randi([1, result_size], height, width);
    mask_imgs = cell(result_size, 1);
    zero_matrix = zeros(height, width);
    for i = 1 : result_size
        mask_imgs{i, 1} = i * ones(height, width);
        % like this when i = 3:
        %[
        % [3, 3, 3,3]
        % [3, 3, 3,3]
        % [3, 3, 3,3]
        %                 ]
        % make 3 -> 0
        % not 3 -> n(not 0)
        mask_imgs{i, 1} = mask_imgs{i, 1} - rand_marix;
        % 0 xor 0 = 0
        % n xor 0 = 1
        % so we mast pixel in 3rd result.
        mask_imgs{i, 1} = xor(mask_imgs{i, 1}, zero_matrix);
    end
    disp('mask images ok');
end