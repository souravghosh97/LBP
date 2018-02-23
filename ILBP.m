function [improvedBinaryPattern]=mLBP(grayImage)

[rows,columns] = size(grayImage);
grayImage = im2double(grayImage);
improvedBinaryPattern = zeros(size(grayImage));
pixel = zeros(1,9);

for row = 2 : rows - 1   
    for col = 2 : columns - 1    
        centerPixel = (sum(sum(grayImage(row-1:row+1,col-1:col+1))))/9;
        pixel(1)=grayImage(row-1, col-1) >= centerPixel;  
        pixel(2)=grayImage(row-1, col) >= centerPixel;   
        pixel(3)=grayImage(row-1, col+1) >= centerPixel;  
        pixel(4)=grayImage(row, col+1) >= centerPixel;     
        pixel(5)=grayImage(row+1, col+1) >= centerPixel;    
        pixel(6)=grayImage(row+1, col) >= centerPixel;      
        pixel(7)=grayImage(row+1, col-1) >= centerPixel;     
        pixel(8)=grayImage(row, col-1) >= centerPixel;
        pixel(9)=grayImage(row, col) >= centerPixel;
        improvedBinaryPattern(row, col) = pixel(9)*2^8+pixel(1)*2^7+pixel(2)*2^6+pixel(3)*2^5+pixel(4)*2^4+pixel(5)*2^3+pixel(6)*2^2+pixel(7)*2+pixel(8);
    end  
end

end