
//
//  ContactPage.swift
//  Socket
//
//  Created by Bodour Alrashidi on 25/11/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ContactPage: UIViewController {
    var firstContact : Contact  = Contact(name: "", image: "", number: "", emergency: false)
    private  let storage  = Storage.storage().reference()
    var currenturl =  ""
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var ContactLable: UILabel!
    
    @IBOutlet weak var ContactImage: UIImageView!

    let database = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
     
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

        // Do any additional setup after loading the view.
    }
    
    func writeData(contact:Contact){
        print("/////////firstcontact",firstContact)
        let contactdataRef = database.collection("ContactData")
        contactdataRef.document(contact.name).setData([
            "name": contact.name,
            "image": contact.image
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
      
      
    }
    func uploadProfileImage(_ image:UIImage, _ contact:Contact) {
       
//           guard let uid = Auth.auth().currentUser?.uid else { return }
//           let storageRef = Storage.storage().reference().child("user/\(uid)")
        let storageRef = Storage.storage().reference().child("\(contact.name).png")
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
           
           
           
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
        
           storageRef.putData(imageData, metadata: metaData) { metaData, error in
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
        //self.firstContact.image = metaData.downloadURL()
        print ("url ///////", self.firstContact.image)
    }
    
    @IBAction func writeContact(_ sender: Any) {
        firstContact.name = NameTextField.text!
        guard let imagecontsct = ContactImage.image else { return }
        self.uploadProfileImage(imagecontsct, firstContact)
        
    
        
      //  writeData(contact: self.firstContact)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
