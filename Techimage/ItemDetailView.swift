//
//  ItemDetailView.swift
//  Techimage
//
//  Created by tujing on 2021/05/30.
//  Copyright © 2021 tujing. All rights reserved.
//

import SwiftUI
import AVKit

struct ItemDetailView: View {
    
    // 画像情報を使用します
    @EnvironmentObject private var userData: UserData
    // self.userData.images配列の番号
    let id: Int
    let player = AVPlayer(url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!)

    var body: some View {
        
        
//        Text(self.userData.images[self.id].path)
        Image(uiImage: UIImage(contentsOfFile: self.userData.images[self.id].path)!)
           .resizable()
        
        VideoPlayer(player: player)
                    .onAppear() {
                        // Start the player going, otherwise controls don't appear
                        player.play()
                    }
                    .onDisappear() {
                        // Stop the player when the view disappears
                        player.pause()
                    }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(id: 0).environmentObject(UserData())
    }
}
