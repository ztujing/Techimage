//
//  ItemDetailView.swift
//  Techimage
//
//  Created by tujing on 2021/05/30.
//  Copyright © 2021 tujing. All rights reserved.
//

import SwiftUI

struct ItemDetailView: View {
    
    // 画像情報を使用します
    @EnvironmentObject private var userData: UserData
    // self.userData.images配列の番号
    let id: Int
    
    var body: some View {
        Text(self.userData.images[self.id].path)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(id: 0).environmentObject(UserData())
    }
}
