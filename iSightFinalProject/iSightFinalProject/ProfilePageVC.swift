//
//  ProfilePageVC.swift
//  Socket
//
//  Created by Bodour Alrashidi on 22/12/2021.
//

import UIKit

class ProfilePageVC: UIViewController {
    var currentContact : Contact = Contact(name: "test", image: "test", number: "test", emergency: false)
    var textt = String()
    var image = UIImage()


    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var Namelabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.image = image
        Namelabel.text! = currentContact.name
        PhoneLabel.text! = currentContact.number
        profileImage.load(urlString:currentContact.image)
        // Do any additional setup after loading the view.
    }

}
