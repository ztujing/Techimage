//
//  Coordinator.swift
//  Techimage
//
//  Created by tujing on 2020/12/13.
//  Copyright © 2020 tujing. All rights reserved.
//

import SwiftUI
import UIKit
import AVKit
import MobileCoreServices



class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var picker: ImagePickerView
    
    private var userData: UserData//追加　変数
    
    init(picker: ImagePickerView,userData: UserData) {//イニシャライザ（コンストラクタ）を作成
        
        self.picker = picker
        self.userData = userData//追加
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            //ImagePickerViewオブジェクトの「selectedImage」変数に割り当て
            self.picker.selectedImage = selectedImage
            self.picker.isPresented.wrappedValue.dismiss()

            //ドキュメントディレクトリに保存
            do {
                let fileManager = FileManager.default
                //画像データをDocuments下のフォルダに保存
                let docs = try fileManager.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil, create: false)
                
                //UUIDを生成して、それを16進数表記文字列にする
                //UUID型オブジェクトのuuidStringプロパティとして取得
                let uuid = UUID()
                let uniqueIdString = uuid.uuidString
                let name = uniqueIdString + ".png"//name
                //String型をURL型に変更
                let path = docs.appendingPathComponent(name)
                //UIImage型→Data型に変換
                let data = selectedImage.pngData()
                //ファイルを作成
                fileManager.createFile(atPath: path.path,
                                       contents: data, attributes: nil)
                
                //の後にImageInfo構造体を作って、UserDataのimagesにappendする。
                
                // 構造体を作成
                let imageInfo = ImageInfo(id: self.userData.images.count,//リストの後ろに追加
                                          name: name,
                                          path: path.path,
                                          isFavorite: false)
 
                // 配列に追加
                 
                self.userData.images.append(imageInfo)
                
                //
           } catch {
                print(error)
           }
           
        } else if let selectedMovie = info[.mediaURL] as? NSURL {

            //ImagePickerViewオブジェクトの「selectedMovie」変数に割り当て
            self.picker.selectedMovie = selectedMovie
            self.picker.isPresented.wrappedValue.dismiss()

            //ドキュメントディレクトリに保存
            do {
                let fileManager = FileManager.default
                let docs = try fileManager.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor:  nil, create: false)
                //サムネ
                func thumnailImageForFileUrl(fileUrl: URL) -> UIImage? {
                        let asset = AVAsset(url: fileUrl)

                        let imageGenerator = AVAssetImageGenerator(asset: asset)

                        do {
                            let thumnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1,timescale: 60), actualTime: nil)
                            print("サムネイルの切り取り成功！")
                            return UIImage(cgImage: thumnailCGImage, scale: 0, orientation: .right)
                        }catch let err{
                            print("エラー\(err)")
                        }
                        return nil
                    }
                
                let thumnailImage = thumnailImageForFileUrl(fileUrl: selectedMovie as URL)
                
                 //UUIDを生成して、それを16進数表記文字列にする
                //UUID型オブジェクトのuuidStringプロパティとして取得
                let uuid = UUID()
                let uniqueIdString = uuid.uuidString
                let name = uniqueIdString + ".png"//name
                let path = docs.appendingPathComponent(name)

                //let data = selectedMovie.dataRepresentation//Data
                let data = thumnailImage?.pngData()

                //ファイルを作成
                fileManager.createFile(atPath: path.path,
                                       contents: data, attributes: nil)
                
               

                //の後にImageInfo構造体を作って、UserDataのimagesにappendする。

            // 構造体を作成
                let imageInfo = ImageInfo(id: self.userData.images.count,//リストの後ろに追加
                                          name: name,
                                          path: path.path,
                                          isFavorite: false)


                // 配列に追加

                self.userData.images.append(imageInfo)

                //




            } catch {
                print(error)
            }

            
            
        } else {
            return
        }
     
    }
}
