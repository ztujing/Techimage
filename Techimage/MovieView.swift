//
//  MovieView.swift
//  Techimage
//
//  Created by tujing on 2021/06/12.
//  Copyright © 2021 tujing. All rights reserved.
//

import SwiftUI
import AVKit

struct ContentView: View {
    // play river.mp4
    private let player = AVPlayer(url: Bundle.main.url(forResource: "river", withExtension: "mp4")!)

    var body: some View {
        HStack{
            if #available(iOS 14.0, *) {
                VideoPlayer(player: player)
                    .onAppear() {
                        self.player.play()
                        　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　}.onDisappear() {
                            self.player.pause()
                        }.edgesIgnoringSafeArea(.all)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(id: 0).environmentObject(UserData())
    }
}
