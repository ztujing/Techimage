//
//  ImageListView.swift
//  Techimage
//
//  Created by tujing on 2020/11/10.
//  Copyright © 2020 tujing. All rights reserved.
//


    import SwiftUI

    // 画像リストの行
    struct ImageListView: View {
        
        // 画像情報を使用します
        @EnvironmentObject private var userData: UserData

        // self.userData.images配列の番号
        let id: Int
            
        var body: some View {
            
            // ビューを横に並べて表示
            HStack {
                
                // 画像情報が１つでも存在する場合
                if self.userData.images.count > 0 {
                    
                    // 画像
                    Image(uiImage: UIImage.init(contentsOfFile: self.userData.images[self.id].path)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    // ファイル名称
                    Text(self.userData.images[self.id].name)
                    
                    // 画面一杯まで余白を追加
                    Spacer()
                    
                    Group {
                    // お気に入りの場合
                        if self.userData.images[self.id].isFavorite {
                            
                            // 色付きのハート
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.pink)
                        } else {
                            
                            // 色なしハート
                            Image(systemName: "heart")
                                .foregroundColor(Color.gray)
                        }
                    }
                    //タップ
                    .onTapGesture {
                        
                        self.userData.images[self.id].isFavorite.toggle()
                        
                        saveFavorite(name:self.userData.images[self.id].name,
                                     isFavorite:self.userData.images[self.id].isFavorite)
                    }
                    
//                else {
//                    
//                    // 画像情報がない場合、Noneを表示
//                    Text("None")
//                }
            }
        }
    }

    struct ImageListView_Previews: PreviewProvider {
        static var previews: some View {
            ImageListView(id: 0).environmentObject(UserData())
        }
    }
}
