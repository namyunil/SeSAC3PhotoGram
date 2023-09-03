//
//  AssignmentGalleryViewController.swift
//  SeSAC3PhotoGram
//
//  Created by NAM on 2023/09/04.
//

import UIKit

class AssignmentGalleryViewController: BaseViewController {
    
    let picker = UIImagePickerController()
    
    var delegate: PassImageDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("갤러리 사용 불가, 사용자에게 토스트/얼럿")
            return
        }
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker , animated: true)
    }
    
}

extension AssignmentGalleryViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            delegate?.receiveImage(image: image)
            dismiss(animated: true)
            navigationController?.popViewController(animated: true)
        }
    }
}
