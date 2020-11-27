//
//  AlbumView_.swift
//  Techimage
//
//  Created by tujing on 2020/11/05.
//  Copyright © 2020 tujing. All rights reserved.
//

import SwiftUI

struct AlbumView: View {
    
    @EnvironmentObject  private var userData: UserData
    
    let name: String
    let path: String
    let isFavorite: Bool
    
    init(name:String,path:String,isFavorite:Bool){
        self.name = name
        self.path = path
        self.isFavorite = isFavorite
    }
    
    
    
    var body: some View {
       

        VStack(alignment: .leading) {
            
            // ビューを重ねて表示
            ZStack {

                // ビューをグループ化
                Group {

                    // 画像のファイルパスが設定されている場合
                    if self.path.count > 0 {

                        // プロパティ値であるself.pathで画像のファイルパスを設定
                        Image(uiImage: UIImage.init(contentsOfFile: self.path)!)
                            // オリジナル画像を表示
                            .renderingMode(.original)
                            // 横幅、高さ、表示位置
                            .frame(width: 100, height: 100, alignment: .center)
                    }
                    else {

                        // iOSで使用できるシステムアイコン(四角)を表示
                        Image(systemName: "square.on.square")
                            .renderingMode(.original)
                            .frame(width: 100, height: 100, alignment: .center)
                    }

                    // お気に入りの場合
                    if self.isFavorite == true {

                          Text(String(countFavorite(images: self.userData.images)))
                       }
                       else {
                           Text(String(self.userData.images.count))
                       }
                   }
                // グループ内の要素(ビュー)にパディング(余白)を追加
                .padding()
                .border(Color.gray, width: 1)        // 枠線をグレーに設定
            }
            // ZStack内のビューを角丸
            .cornerRadius(10)

        
            // 名称
            Text(self.name)
                .foregroundColor(.primary)

        
            Group {
                if self.isFavorite == true {
                       Text(String(countFavorite(images: self.userData.images)))

                }
                else {
                    Text(String(self.userData.images.count))
                }
            }
            .foregroundColor(.primary)
        }
        
    }
    
    
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(name:"お気に入り",
                   path:"",
            isFavorite: true).environmentObject(UserData())
    }
}
