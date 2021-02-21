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
            /// 行削除
//            .onDelete { offsets in
//                            self.userData.images.remove(atOffsets: offsets)
//            }
            /// 行削除操作時に呼び出す処理の指定
                        .onDelete(perform: rowRemove)
             
        .navigationBarTitle(Text("画像リスト"))
        }
   
    }
    /// 行削除処理
     func rowRemove(offsets: IndexSet) {
        self.userData.images.remove(atOffsets: offsets)
     }
     
    
}

struct ImageList_Previews: PreviewProvider {
    static var previews: some View {
        // ここを編集します
        ImageList(onlyFavorite: false).environmentObject(UserData())
    }
}
