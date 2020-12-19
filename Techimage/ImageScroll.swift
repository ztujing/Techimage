//
//  SwiftUIView.swift
//  Techimage
//
//  Created by tujing on 2020/11/21.
//  Copyright © 2020 tujing. All rights reserved.
//

import SwiftUI

struct KindStructImage {
static let regular: Int = 0     // 何もしない
static let grayscale: Int = 1   // グレースケール
static let colorInvert: Int = 2 // 色調反転
static let sepia: Int = 3       // セピア
}

struct ImageScroll: View {

    // 画像情報を使用します
    @EnvironmentObject private var userData: UserData
    
    // 編集モードの状態です(編集:active 完了:inactive) 初期値は完了状態です
    @State private var isEditMode: EditMode = .inactive
    
    // 画像処理の種別です
    @State private var kindImage: Int = KindStructImage.regular
    
    // お気に入りのみ表示するかの判定
    var onlyFavorite: Bool
    
    
    var body: some View {
        
        // 親ビューのサイズや位置、セーフエリア外マージンなどを取得
        GeometryReader { geometry in
                
            ZStack(alignment: .bottom) {
        
                // スクロール表示します
                ScrollView(.vertical, showsIndicators: true) {
                    
                    // 縦に表示します
                    VStack(alignment: .leading, spacing: 0) {
                      
                        // 画像情報から全ての画像を取得します
                        ForEach(self.userData.images) { item in
                            
                            // お気に入りのみ表示もしくは全ての項目を表示します
                            if  (self.onlyFavorite == true &&
                                item.isFavorite) ||
                                self.onlyFavorite == false {
                                
                                
                                    // グレースケール
                                    if self.kindImage == KindStructImage.grayscale {
                                        Image(uiImage: (UIImage.init(contentsOfFile: item.path)?.grayScale())!)
                                            .resizable()
                                    }
                                    // 色調反転
                                    else if self.kindImage == KindStructImage.colorInvert {
                                        Image(uiImage: UIImage.init(contentsOfFile: item.path)!)
                                            .resizable()
                                            .colorInvert()
                                        
                                    }
                                    // セピア
                                    else if self.kindImage == KindStructImage.sepia {
                                        Image(uiImage: UIImage.sepia(path: item.path))
                                            .resizable()
                                    }
                                    // 通常
                                    else {
                                        Image(uiImage: UIImage.init(contentsOfFile: item.path)!)
                                            .resizable()
                                    }
                                    

                                    
                                }
                            
                            }.aspectRatio(contentMode: .fit)
                        }
                    }
                
                   // 編集状態の場合、ツールバーを表示します
                    if self.isEditMode == .active {
                        
                        // ビューを横に並べて表示します (ツールバー)
                        HStack {
                            
                            // 写真アイコンを表示します (グレースケールボタン)
                            Image(systemName: "photo")
                                
                                // グレー表示
                                .foregroundColor(Color.gray)
                                
                                // グレースケール画像がタップされた場合、実行されます
                                .onTapGesture {
                                    
                                    // グレースケール状態に変更します
                                    self.kindImage = KindStructImage.grayscale
                            }
                            
                            // 余白を追加します
                            Spacer()
                            
                            // 色調反転ボタン
                            Button(action: {
                                
                                // 色調反転状態に変更します
                                self.kindImage = KindStructImage.colorInvert
                                
                            }) {
                                
                                // 写真アイコン(塗りつぶし)を表示します
                                Image(systemName: "photo.fill")
                                    
                                    // ブルー表示します
                                    .foregroundColor(Color.blue)
                                    
                            }
                            
                            Spacer()
                            
                            // セピアボタン
                            Button(action: {
                                
                                // セピア状態に変更します
                                self.kindImage = KindStructImage.sepia
                             
                            }) {
                                
                                // 写真アイコン(2枚)を表示します
                                Image(systemName: "photo.on.rectangle")
                                    
                                    // イエロー表示します
                                    .foregroundColor(Color.yellow)
                            }
                        }
                        // アイコンとツールバーの間に余白を追加します
                        .padding()
                            
                        // ツールバーの高さとアイコンの表示位置を設定します
                        .frame(height: 44+geometry.safeAreaInsets.bottom, alignment: .top)
                            
                        // ツールバーの背景色を白に設定します
                        .background(Color.white)
                    }
                }
                    
        // スクロールビューの高さを設定します
        .frame(maxHeight: .infinity)
        // タイトル
        .navigationBarTitle(Text("画像スクロール"))
            
        // 下側のセーフエリアを無視します
          .edgesIgnoringSafeArea(.bottom)
              
          // 編集ボタンを追加します
          .navigationBarItems(trailing: EditButton())
              
          // 編集モードを渡す
          .environment(\.editMode, self.$isEditMode)
        }
    }
}

struct ImageScroll_Previews: PreviewProvider {
    static var previews: some View {
        ImageScroll(onlyFavorite: false).environmentObject(UserData())
    }
}


