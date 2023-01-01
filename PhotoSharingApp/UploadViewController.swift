//
//  UploadViewController.swift
//  PhotoSharingApp
//
//  Created by Alper Koçer on 30.12.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @objc func selectImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    

    @IBAction func uploadTapped(_ sender: Any) {
        let storage = Storage.storage()
        
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) {
                (storagemetadata, error) in
                if error != nil {
                    self.showErrorMessage(title: "Error", message: error?.localizedDescription ?? "Try Again")
                }else{
                    imageReference.downloadURL { [self] url, error in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            
                            if let imageURL = imageURL {
                                
                                let firestoreDatabase = Firestore.firestore()
                                let firestorePost = ["imageURL": imageURL, "comment": self.commentsTextField.text!, "email": Auth.auth().currentUser!.email, "data": FieldValue.serverTimestamp()] as [String: Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { error in
                                    if error != nil {
                                        self.showErrorMessage(title: "Error!", message: error?.localizedDescription ?? "Error while uploading.")
                                    }else{
                                        
                                    }
                                }
                                
                            }
                            
                            

                        }
                    }
                }
            }
        }
    }
    
    func showErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }

}
