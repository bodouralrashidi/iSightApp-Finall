//
//  NetworkingFirebase.swift
//  Socket
//
//  Created by Bodour Alrashidi on 07/01/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

let database = Firestore.firestore()
let contactdataRef = database.collection("ContactData")
func loadfirebase()
{
    contactList = []
   contactdataRef.getDocuments() { (querySnapshot, err) in
     
       if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
             //   var currentDoc = document.data()
                
                print("///////////////")
                // print("current doc = " , currentDoc)
                print("current name = " , document.get("name")!)
                print("current image = " , document.get("image")!)
                
                contactList.append(Contact(name: document.get("name") as! String, image: document.get("image") as! String, number: document.get("phone") as! String, emergency: document.get("emergency") as! Bool))
                var currentemergancy = document.get("emergency")!
                
                if currentemergancy as! Bool == true
                {
                    emergencyList.append(Contact(name: document.get("name") as! String, image: document.get("image") as! String, number: document.get("phone") as! String, emergency: document.get("emergency") as! Bool))
                    print(emergencyList, "&&&&&&&&&&&& emergency", document.get("name") as! String )
                    
                }
                print("\(document.documentID) => \(document.data())")
            }
            
        }
       print(contactList,"/////// 0000000")
    }


    
}
