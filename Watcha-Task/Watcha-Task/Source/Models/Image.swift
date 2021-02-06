//
//  Image.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation

// MARK: - Image
struct Image: Codable {
    let original: GIFGenericData?
    let downsized, downsizedLarge, downsizedMedium: GIFGenericData?
    let downsizedSmall: GIFGenericData?
    let downsizedStill: GIFGenericData?
    let fixedHeight, fixedHeightDownsampled, fixedHeightSmall: GIFGenericData?
    let fixedHeightSmallStill, fixedHeightStill: GIFGenericData?
    let fixedWidth, fixedWidthDownsampled, fixedWidthSmall: GIFGenericData?
    let fixedWidthSmallStill, fixedWidthStill: GIFGenericData?
    let looping: GIFGenericData?
    let originalStill: GIFGenericData?
    let originalMp4, preview: GIFGenericData?
    let previewGIF, previewWebp, the480WStill: GIFGenericData?

    enum CodingKeys: String, CodingKey {
        case original, downsized
        case downsizedLarge = "downsized_large"
        case downsizedMedium = "downsized_medium"
        case downsizedSmall = "downsized_small"
        case downsizedStill = "downsized_still"
        case fixedHeight = "fixed_height"
        case fixedHeightDownsampled = "fixed_height_downsampled"
        case fixedHeightSmall = "fixed_height_small"
        case fixedHeightSmallStill = "fixed_height_small_still"
        case fixedHeightStill = "fixed_height_still"
        case fixedWidth = "fixed_width"
        case fixedWidthDownsampled = "fixed_width_downsampled"
        case fixedWidthSmall = "fixed_width_small"
        case fixedWidthSmallStill = "fixed_width_small_still"
        case fixedWidthStill = "fixed_width_still"
        case looping
        case originalStill = "original_still"
        case originalMp4 = "original_mp4"
        case preview
        case previewGIF = "preview_gif"
        case previewWebp = "preview_webp"
        case the480WStill = "480w_still"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        original = (try? values.decode(GIFGenericData.self, forKey: .original)) ?? nil
        downsized = (try? values.decode(GIFGenericData.self, forKey: .downsized)) ?? nil
        downsizedLarge = (try? values.decode(GIFGenericData.self, forKey: .downsizedLarge)) ?? nil
        downsizedMedium = (try? values.decode(GIFGenericData.self, forKey: .downsizedMedium)) ?? nil
        downsizedSmall = (try? values.decode(GIFGenericData.self, forKey: .downsizedSmall)) ?? nil
        downsizedStill = (try? values.decode(GIFGenericData.self, forKey: .downsizedStill)) ?? nil
        fixedHeight = (try? values.decode(GIFGenericData.self, forKey: .fixedHeight)) ?? nil
        fixedHeightDownsampled = (try? values.decode(GIFGenericData.self, forKey: .fixedHeightDownsampled)) ?? nil
        fixedHeightSmall = (try? values.decode(GIFGenericData.self, forKey: .fixedHeightSmall)) ?? nil
        fixedHeightSmallStill = (try? values.decode(GIFGenericData.self, forKey: .fixedHeightSmallStill)) ?? nil
        fixedHeightStill = (try? values.decode(GIFGenericData.self, forKey: .fixedHeightStill)) ?? nil
        fixedWidth = (try? values.decode(GIFGenericData.self, forKey: .fixedWidth)) ?? nil
        fixedWidthDownsampled = (try? values.decode(GIFGenericData.self, forKey: .fixedWidthDownsampled)) ?? nil
        fixedWidthSmall = (try? values.decode(GIFGenericData.self, forKey: .fixedWidthSmall)) ?? nil
        fixedWidthSmallStill = (try? values.decode(GIFGenericData.self, forKey: .fixedWidthSmallStill)) ?? nil
        fixedWidthStill = (try? values.decode(GIFGenericData.self, forKey: .fixedWidthStill)) ?? nil
        looping = (try? values.decode(GIFGenericData.self, forKey: .looping)) ?? nil
        originalStill = (try? values.decode(GIFGenericData.self, forKey: .originalStill)) ?? nil
        originalMp4 = (try? values.decode(GIFGenericData.self, forKey: .originalMp4)) ?? nil
        preview = (try? values.decode(GIFGenericData.self, forKey: .preview)) ?? nil
        previewGIF = (try? values.decode(GIFGenericData.self, forKey: .previewGIF)) ?? nil
        previewWebp = (try? values.decode(GIFGenericData.self, forKey: .previewWebp)) ?? nil
        the480WStill = (try? values.decode(GIFGenericData.self, forKey: .the480WStill)) ?? nil
        
    }
}
