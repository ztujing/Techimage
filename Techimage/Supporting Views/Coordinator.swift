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
    
    private var userData: UserData//追加
    
    init(picker: ImagePickerView,userData: UserData) {//イニシャライザを作成
        
        self.picker = picker
        self.userData = userData//追加
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        //ImagePickerViewオブジェクトの「selectedImage」変数に割り当て
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
        // 写真ライブラリに画像を保存
        //UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
        //ドキュメントディレクトリに保存
        do {
            let fileManager = FileManager.default
            let docs = try fileManager.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil, create: false)
            
            //UUIDを生成して、それを16進数表記文字列にする
            //UUID型オブジェクトのuuidStringプロパティとして取得
            let uuid = UUID()
            let uniqueIdString = uuid.uuidString
            let name = uniqueIdString + ".png"//name
            let path = docs.appendingPathComponent(name)
            
            let data = selectedImage.pngData()
            
            fileManager.createFile(atPath: path.path,
                                   contents: data, attributes: nil)
            
            //の後にImageInfo構造体を作って、UserDataのimagesにappendする。
            
         

        
            
            // 構造体を作成
            let imageInfo = ImageInfo(id: self.userData.images.count,
                                      name: name,
                                      path: path.path,
                                      isFavorite: false)
            
            
            // 配列に追加
            
            self.userData.images.append(imageInfo)
            
                
  
            

            
        } catch {
            print(error)
        }
   
       
        
    }
    
    
    
}
