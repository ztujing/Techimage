//
//  ImageData.swift
//  Techimage
//
//  Created by tujing on 2020/11/09.
//  Copyright © 2020 tujing. All rights reserved.
//

import Foundation

// 画像情報の構造体
struct ImageInfo: Identifiable {

    let id: Int             // Identifiableに必要
    let name: String        // ファイル名称
    var path: String        // ファイルパス
    var isFavorite: Bool    // お気に入り
}

// 画像情報を配列で保持
let imageInfos: [ImageInfo] = loadImageInfos()

// ~/Documentsフォルダ内の画像ファイルを全て取得する
func loadImageInfos() -> Array<ImageInfo> {
    
    // ~/Documentsフォルダ内のファイル名称を全て取得する
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                            .userDomainMask,
                                                            true)[0]
    guard var fileNames = try? FileManager.default.contentsOfDirectory(atPath: documentsPath) else {
        return []
    }
    
    let favoriteArray:Array<String>=loadFavorite()
    
    var imageInfos:Array<ImageInfo>=[]
    
    // ファイル名称を昇順で並べ替え
    fileNames.sort { $0 < $1 }
  
  
    
    // 全てのファイル情報を配列に設定する
    var idNum = 0
    for name: String in fileNames {
        
        // お気に入りか判定
        var isFavorite = false
        if favoriteArray.contains(name) == true {
            isFavorite = true
        }
        
        // Documentsフォルダパスにファイル名称を追加してファイルパスを作成
        let path = documentsPath + "/" + name

        // 構造体を作成
        let imageInfo = ImageInfo(id: idNum,
                                  name: name,
                                  path: path,
                                  isFavorite: isFavorite)
        // 配列に追加
        imageInfos.append(imageInfo)
        
        // ファイル毎に異なるid番号を割り振るために１ずつ増やす
        idNum += 1
    }
  
    return imageInfos
}
