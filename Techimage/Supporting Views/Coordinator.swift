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
        //UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
        do {
            let fileManager = FileManager.default
            let docs = try fileManager.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil, create: false)
            
            //UUIDを生成して、それを16進数表記文字列にする
            //UUID型オブジェクトのuuidStringプロパティとして取得
            let uuid = UUID()
            let uniqueIdString = uuid.uuidString
            let path = docs.appendingPathComponent(uniqueIdString + ".png")
            
            let data = selectedImage.pngData()
            
            
            //let data = "Hello, world!".data(using: .utf8)!

            fileManager.createFile(atPath: path.path,
                                   contents: data, attributes: nil)
        } catch {
            print(error)
        }
    }
    
}
