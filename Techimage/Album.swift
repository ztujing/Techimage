//
//  Album.swift
//  Techimage
//
//  Created by tujing on 2020/11/04.
//  Copyright © 2020 tujing. All rights reserved.
//

import SwiftUI

struct Album: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
       @State private var selectedImage: UIImage?
       @State private var isImagePickerDisplay = false
    
    //宣言
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
                      
        ZStack {
            
            VStack{
                
                HStack{
   
                    HStack {

                        Spacer()
                        Button("Camera") {
                            self.sourceType = .camera
                            self.isImagePickerDisplay.toggle()
                        }.padding()
                        
                    }
    
                    .sheet(isPresented: self.$isImagePickerDisplay) {
                        ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                    }

             }
            
                NavigationView {
                    
                    VStack {
                        
                        NavigationLink(destination: ImageList(onlyFavorite:false)){
                            AlbumView(name: "すべての項目",
                                      path: self.userData.images.count > 0 ? self.userData.images[0].path : "",
                                      isFavorite: false)
                        }
                    
                        NavigationLink(destination: ImageList(onlyFavorite:true)){
                            AlbumView(name: "お気に入り",
                                      path: self.userData.images.count > 1 ? self.userData.images[1].path : "",
                                      isFavorite: true)
                            }
                        }
                        .navigationBarTitle(Text("アルバム"))
                    }//NavigationView

                   

                }//VStack
        }//ZStack
    }
        
}

    


struct Album_Previews: PreviewProvider {
    static var previews: some View {
         Album().environmentObject(UserData())
    }
}

