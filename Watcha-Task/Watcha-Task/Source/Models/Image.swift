//
//  Image.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation

// MARK: - Image
struct Image: Codable {
    let original: GIFMetaData
    let downsized, downsizedLarge, downsizedMedium: GIFURLData
    let downsizedSmall: GIFMP4Data
    let downsizedStill: GIFURLData
    let fixedHeight, fixedHeightDownsampled, fixedHeightSmall: GIFMetaData
    let fixedHeightSmallStill, fixedHeightStill: GIFURLData
    let fixedWidth, fixedWidthDownsampled, fixedWidthSmall: GIFMetaData
    let fixedWidthSmallStill, fixedWidthStill: GIFURLData
    let looping: Looping
    let originalStill: GIFURLData
    let originalMp4, preview: GIFMP4Data
    let previewGIF, previewWebp, the480WStill: GIFURLData

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
}
