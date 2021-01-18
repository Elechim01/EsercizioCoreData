//
//  ImagePicker.swift
//  EsercizioCoreData
//
//  Created by Michele on 17/01/21.
//

import Foundation
import UIKit
import SwiftUI
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var mostra : Bool
    @Binding var image : Data
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(image: $image, mostra: $mostra)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        @Binding var image : Data
        @Binding var mostra : Bool
        init(image:Binding<Data>, mostra: Binding<Bool>) {
            self._image = image
            self._mostra = mostra
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.mostra.toggle()
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image  = info[.originalImage] as! UIImage
            let data = image.jpegData(compressionQuality: 1)
            self.image = data!
            self.mostra.toggle()
            
        }
    }
}
