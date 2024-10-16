package org.example.fashion_api.Services;


import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class CloudinaryService {

    private final Cloudinary cloudinary;

    public void deleteImageByUrl(String imageUrl) throws IOException {
        String public_id = extractPublicId(imageUrl);

        if (public_id != null && !public_id.isEmpty()) {
            // Xóa hình ảnh từ Cloudinary bằng URL
            if (imageUrl.endsWith(".mp4")) {
                cloudinary.uploader().destroy(public_id, ObjectUtils.asMap("resource_type", "video"));
            } else {
                cloudinary.uploader().destroy(public_id, ObjectUtils.emptyMap());
            }
        }
    }

    private String extractPublicId(String imageUrl) {
        if (imageUrl == null || imageUrl.isEmpty()) {
            return null;
        }

        int begin = imageUrl.lastIndexOf("/") + 1;
        int end = imageUrl.lastIndexOf(".");

        if (begin >= 0 && end >= begin && end <= imageUrl.length()) {
            return imageUrl.substring(begin, end);
        } else {
            // Xử lý trường hợp không hợp lệ nếu cần
            return null;
        }
    }

    public Map<String, Object> upload(MultipartFile file) throws IOException {
        if (file.getOriginalFilename().endsWith(".mp4")) {
            return cloudinary.uploader().uploadLarge(file.getBytes(),
                    ObjectUtils.asMap("resource_type", "video"));
        } else {
            return cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());
        }
    }
}
