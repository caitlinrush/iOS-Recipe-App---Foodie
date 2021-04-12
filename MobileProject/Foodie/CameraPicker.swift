//
//  CameraPicker.swift
//  Foodie
//
//  Created by Pallavi Singla on 2020-12-09.
//

import Foundation
import SwiftUI
import PhotosUI


//@available(iOS 14, *)
struct CameraPicker: UIViewControllerRepresentable{
        
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraPicker>) {}
    
    func makeCoordinator() -> CameraPicker.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        var parent: CameraPicker
        
        init(parent: CameraPicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                self.parent.image = image
                self.parent.isPresented.toggle()
                picker.dismiss(animated: true)
                
                //save image to photo library
                PHPhotoLibrary.shared().performChanges({
                    let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                    PHAssetCollectionChangeRequest(for: PHAssetCollection())?.addAssets([creationRequest.placeholderForCreatedAsset!] as NSArray)
                },
                                                       completionHandler: {success, error in
                                                        if !success{
                                                            print(#function, "Error saving image in Photo Library \(error?.localizedDescription)")
                                                        }
                                                       })
            }
            
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.isPresented.toggle()
        }
        
    }
}
