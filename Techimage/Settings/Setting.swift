//
//  Setting.swift
//  Techimage
//
//  Created by tujing on 2020/11/10.
//  Copyright © 2020 tujing. All rights reserved.
//

import Foundation

//MARK:- Favorite

struct UserDefaultsKey { //UserDefaultsはキーを指定して値を保存できる
    static let arrayFavorite: String = "arrayFavorite"
    static let isAppInit: String = "isAppInit"
    static let appVersion: String = "appVersion"
}

func saveFavorite(name: String, isFavorite: Bool) {
    
    // お気に入り情報の取得
    let isFavoriteArrayWrap = UserDefaults.standard.stringArray(forKey: UserDefaultsKey.arrayFavorite)
    
    // お気に入り情報がない場合
    guard var isFavoriteArray = isFavoriteArrayWrap else {
        // 何もしない-オプショナルバインディング
        return
    }
    
    // お気に入り
    if isFavorite {
        
        // 追加
        isFavoriteArray.append(name)
    }
    else {
        
        // 削除
        if let index = isFavoriteArray.firstIndex(of: name) {
            isFavoriteArray.remove(at: index)
        }
    }
    
    // お気に入りを保存
    UserDefaults.standard.set(isFavoriteArray,
                              forKey: UserDefaultsKey.arrayFavorite)
    
    return
}

// お気に入り情報の取得
func loadFavorite() -> Array<String> {
    
    // お気に入り情報の取得
    let isFavoriteArrayWrap = UserDefaults.standard.stringArray(forKey: UserDefaultsKey.arrayFavorite)
    
    // お気に入り情報がない場合
    guard let isFavoriteArray = isFavoriteArrayWrap else {
        return []
    }
    
    return isFavoriteArray
}

// お気に入りの数を取得
func countFavorite(images: Array<ImageInfo>) -> Int {
    
    var count = 0
    
    for item in images {
        
        if item.isFavorite {
            count += 1 // count++は使用できない
        }
    }
    
    return count
}
