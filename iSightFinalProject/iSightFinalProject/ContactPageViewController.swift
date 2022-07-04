//
//  ViewController.swift
//  Socket
//
//  Created by dalal aljassem on 10/19/21.
//


import UIKit
import Starscream
import FirebaseFirestore
import FirebaseStorage

class ContactPageViewController: UIViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {
    var selectEmergenancy = false
    var picker:UIImagePickerController?=UIImagePickerController()
    var firstContact : Contact  = Contact(name: "", image: "", number: "", emergency: false)
     private  let storage  = Storage.storage().reference()
     var currenturl =  ""
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func chooseImage(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose source", preferredStyle: .actionSheet)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler:
        {(action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))

        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:
        {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))

        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))

        self.present(actionSheet, animated: true, completion: nil)
    }
    
 
 internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
     imageView.image = image

 }

 func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     picker.dismiss(animated: true, completion: nil)
 }
    let database = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        contactName.delegate = self
        contactNumber.delegate = self
        let contactdataRef = database.collection("ContactData")
        contactdataRef.getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
 
 @IBOutlet weak var contactName: UITextField!
 
 
 @IBOutlet weak var contactNumber: UITextField!
 
 @IBAction func sendData(_ sender: Any) {
     firstContact.name = contactName.text!
     firstContact.number = contactNumber.text!
     firstContact.emergency = selectEmergenancy
     
     guard let imagecontsct = imageView.image else { return }
     var reducedimage  = resizeImage(image: imagecontsct, targetSize: CGSize(width: 800,height: 800))
     self.uploadProfileImage(reducedimage!, firstContact)
     
     DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
         self.navigationController?.popViewController(animated: true)

         self.dismiss(animated: true, completion: nil)
         
     }
     
 }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func uploadProfileImage(_ image:UIImage, _ contact:Contact) {
       
//           guard let uid = Auth.auth().currentUser?.uid else { return }
//           let storageRef = Storage.storage().reference().child("user/\(uid)")
        let storageRef = Storage.storage().reference().child("\(contact.name).jpeg")
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
           
           
           
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
        storageRef.putData(imageData, metadata: metaData)
        
           storageRef.putData(imageData, metadata: metaData) { metaData, error in
               metaData!.contentType = "image/png"
               let uploadTask = storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                 guard let metadata = metadata else {
                   // Uh-oh, an error occurred!
                   return
                 }
                 // Metadata contains file metadata such as size, content-type.
                 let size = metadata.size
                
                 // You can also access to download URL after upload.
                 storageRef.downloadURL { (url, error) in
                   guard let downloadURL = url else {
                     // Uh-oh, an error occurred!
                     return
                   }
                     //contact.image = url!.absoluteString
                    //register to firebase
                     print("/////////firstcontact",contact)
                     let contactdataRef = self.database.collection("ContactData")
                     contactdataRef.document(contact.name).setData([
                         "name": contact.name,
                         "emergency": contact.emergency,
                         "phone": contact.number,
                         "image": url!.absoluteString
                     ]) { err in
                         if let err = err {
                             print("Error writing document: \(err)")
                         } else {
                             print("Document successfully written!")
                        
                         }
                     }
                     
                   
                     
                 }
                   
                   
               }
              
           }
        // Update metadata properties
        metaData.contentType = "image/jpeg"
        storageRef.updateMetadata(metaData) { metadata, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // Updated metadata for 'images/forest.jpg' is returned
          }
        }
        //self.firstContact.image = metaData.downloadURL()
        print ("url ///////", self.firstContact.image)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    @IBAction func emergencyButton(_ sender: UIButton) {
        
        if sender.isSelected {
            
           sender.isSelected = false
        } else {
            selectEmergenancy = true
            
            sender.isSelected  = true
        }
        
    }
}
