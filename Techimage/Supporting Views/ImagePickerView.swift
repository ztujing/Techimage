//
//
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
    
    @Binding var selectedMovie: NSURL?//
    
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        //動画を扱えるようにする
        imagePicker.mediaTypes = ["public.image", "public.movie"]
        imagePicker.delegate = context.coordinator // confirming the delegate

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self,userData: self.userData)//自分自身を渡している　
    }
    
    
   
    
  
    
    
    
    
}


  
