//
//  detailsController.swift
//  Socket
//
//  Created by dalal aljassem on 1/7/22.
//

import UIKit

class detailsController: UIViewController {
    var currentContact : Contact = Contact(name: "test", image: "test", number: "test", emergency: false)
    
    @IBOutlet weak var contactPic: UIImageView!
    @IBOutlet weak var contactPhone: UILabel!
    @IBOutlet weak var contactName: UILabel!
    
    var img = UIImage()
    var contactsName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactName.text! = currentContact.name
        contactPic.load(urlString:currentContact.image)
        contactPhone.text! = currentContact.number

    }
}
