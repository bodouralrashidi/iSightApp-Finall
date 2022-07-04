//
//  Contacts.swift
//  Socket
//
//  Created by Bodour Alrashidi on 26/11/2021.
//

import Foundation

class Contact{
   var name = ""
   var image =  ""
    var  number  = ""
    var emergency = false
    
//    init(){
//    
//    self.image = ""
//    self.name = ""
//        self.number = ""
//}
    init(name : String , image : String , number:String , emergency : Bool)
    {
        self.number = number
        self.image = image
        self.name = name
        self.emergency = emergency

    }
}
var contactList : [Contact] = []
var emergencyList : [Contact] = []


