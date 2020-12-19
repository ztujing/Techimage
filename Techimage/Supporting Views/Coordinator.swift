//
//  Coordinator.swift
//  Techimage
//
//  Created by tujing on 2020/12/13.
//  Copyright © 2020 tujing. All rights reserved.
//

import SwiftUI


class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {//イニシャライザを作成
        
        self.picker = picker
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        //ImagePickerViewオブジェクトの「selectedImage」変数に割り当て
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
        // 写真ライブラリに画像を保存
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
    }
    
}
