function rotationInvariantUniformPattern=RIULBP(grayImage)
[rows,columns] = size(grayImage);
pixel = zeros(1,8);
rotationInvariantUniformPattern = zeros([rows,columns]);
vec = zeros(1,256);

for p=0:255
    binary_p = de2bi(p,8);
    transition = sum(diff(binary_p)~=0);
    if transition <= 2
        vec(p+1)=p;
    else
        vec(p+1)=256;
    end
end
temp_vec = vec;

for p = 0:255
    pixel = de2bi(p,8);
    minimum = 256;
    for j=0:7
        pixel = circshift(pixel,[1,1]);
        value = bi2de(pixel);
        if value<minimum
            minimum=value;
        end
    end
    vec(p+1)=minimum;
end

for i=1:256
    if(temp_vec(i)~=256)
        temp_vec(i) = vec(temp_vec(i)+1);
    end
end

vec = temp_vec;

for row = 2 : rows - 1   
    for col = 2 : columns - 1    
        centerPixel = grayImage(row, col);
        pixel(1)=grayImage(row-1, col-1) >= centerPixel;  
        pixel(2)=grayImage(row-1, col) >= centerPixel;   
        pixel(3)=grayImage(row-1, col+1) >= centerPixel;  
        pixel(4)=grayImage(row, col+1) >= centerPixel;     
        pixel(5)=grayImage(row+1, col+1) >= centerPixel;    
        pixel(6)=grayImage(row+1, col) >= centerPixel;      
        pixel(7)=grayImage(row+1, col-1) >= centerPixel;     
        pixel(8)=grayImage(row, col-1) >= centerPixel;
        value=(pixel(1)*2^7+pixel(2)*2^6+pixel(3)*2^5+pixel(4)*2^4+pixel(5)*2^3+pixel(6)*2^2+pixel(7)*2+pixel(8));
        rotationInvariantUniformPattern(row,col) = vec(value+1);
    end  
end

end