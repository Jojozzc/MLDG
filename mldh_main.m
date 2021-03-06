% examples:
img1 = imread('./images/mldg1.jpg');
test_img = [1, 12, 5, 42; 2, 78, 47, 8; 23, 12, 2, 5]; % 4 x 3
% test matrix:
images_after_mask1 = mask_image(uint8(test_img), 10);
% or uint8 image:
images_after_mask2 = mask_image(img1, 10);
test_for_imshow();

function test_for_imshow()
    img1 = imread('./images/mldg1.jpg');
    images_after_mask2 = mask_image(img1, 10);
    num = size(images_after_mask2, 1);
    for i = 1 : num
        imshow(images_after_mask2{i});
    end
end


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
    
    % This function has been speeded up.
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
        % so we mask pixel in 3rd result.
        mask_imgs{i, 1} = xor(mask_imgs{i, 1}, zero_matrix);
    end
    disp('mask images ok');
end

function [mask_imgs] = create_mask_imgs_uniform(img, result_size, prob_mask)
% img: original image
% result_size: number of template
% prob_mask: probability of uniform distribution
    height = size(img, 1);
    width = size(img, 2);
    mask_imgs = cell(result_size, 1);
    one_m =  ones(height, width);
    for i = 1 : result_size
        rand_matrix = rand(height, width) + 0.00001 * one_m; % in case of sign(0)
        mask_matrix = -sign(rand_matrix - prob_mask * one_m);
        mask_matrix = sign(mask_matrix + one_m);
        mask_imgs{i, 1} = int8(mask_matrix);
        % eg
        % prob_mask = 0.6
        % rand_matrix(1, 3) = 0.3
        % 0.3 - 0.6 = -0.3
        % so sign(-0.3) = -1 -> 1->(add 1) 2 ->sign->1
        % and 0.8 -> -1->(add 1) 0 ->sign -> 0
        % After processing, all number less than 0.6 become 1, others
        % become 0
    end
end