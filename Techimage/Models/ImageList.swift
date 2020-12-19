//
//  ImageList.swift
//  Techimage
//
//  Created by tujing on 2020/11/10.
//  Copyright © 2020 tujing. All rights reserved.
//

import SwiftUI

struct ImageList: View {
    
    @EnvironmentObject private var userData: UserData
    
    // ここに追加します。お気に入り判定を追加します。
    var onlyFavorite: Bool
    
    var body: some View {
        
        List {
            
            ForEach (self.userData.images) { item in
                
                if  (self.onlyFavorite == true &&
                    item.isFavorite) ||
                    self.onlyFavorite == false {
                
                    NavigationLink(destination: ImageScroll(onlyFavorite: self.onlyFavorite)) {
                    ImageListView(id: item.id)
                    }
                }
            }
        }
        .navigationBarTitle(Text("画像リスト"))
        
        
    }
    
}

struct ImageList_Previews: PreviewProvider {
    static var previews: some View {
        // ここを編集します
        ImageList(onlyFavorite: false).environmentObject(UserData())
    }
}
