//
//  File.swift
//  Techimage
//
//  Created by tujing on 2021/04/30.
//  Copyright © 2021 tujing. All rights reserved.
//

import Foundation


var thumnail = thumnailImageForFileUrl()

func thumnailImageForFileUrl(fileUrl: URL) -> UIImage? {
        let asset = AVAsset(url: fileUrl)

        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1,timescale: 60), actualTime: nil)
            print("サムネイルの切り取り成功！")
            return UIImage(cgImage: thumnailCGImage, scale: 0, orientation: .right)
        }catch let err{
            print("エラー\(err)")
        }
        return nil
    }
