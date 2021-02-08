//
// c
//  Techimage
//
//  Created by tujing on 2020/12/13.
//  Copyright © 2020 tujing. All rights reserved.
//

import UIKit
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    //追加　UserDataを使えるようにする
    @EnvironmentObject private var userData: UserData
    
   
    @Binding var selectedImage: UIImage?//
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self,userData: self.userData)//自分自身を渡している　
    }
    
    //データの更新 一覧データ
   
    
  
    
    
    
    
}


  
