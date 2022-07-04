//
//  ContactList.swift
//  Socket
//
//  Created by dalal aljassem on 12/16/21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

let navigationBar = UINavigationBar()
class ContactList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private  let storage  = Storage.storage().reference()
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for:indexPath) as! TableViewCell
        var currentname = contactList[indexPath.row]
        cell.nameCelLabel.text! = currentname.name
        cell.ProfileCellImage.load(urlString:currentname.image)
        cell.phoneCellLabel.text! = currentname.number
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    

    @IBOutlet var tableView: UITableView!
    let voiceFeedback = VoiceFeedback()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationBar.barTintColor = .blue
        tableView.addSubview(navigationBar)
     
        voiceFeedback.say(_phrase: "Contact list")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //            print("**************",contactList)
        self.tableView.reloadData()
        }}
        
    override func viewDidAppear(_ animated: Bool) {
        loadfirebase()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.reloadData()
        }
    }
        
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        var currentname = contactList[indexPath.row]
//        performSegue(withIdentifier: "GotoProfilePage", sender: currentname)
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var currentname = contactList[indexPath.row]
        performSegue(withIdentifier: "detailsController", sender: currentname)
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//       if  let vc = storyboard?.instantiateViewController(identifier: "detailsController") as?
//            detailsController{
//        vc.contactPic = UIImage(named: contactList[indexPath.row])!
//            vc.contactName = contactList[indexPath.row]
////            var contactName = contactList[indexPath.row]
////            var img = contactList[indexPath.row]
//
//            self.navigationController?.pushViewController(vc, animated: true)
//    }
        
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "detailsController"
        {
            let vc = segue.destination as! detailsController
           var currentcontact = sender as! Contact
            print("current contact ", currentcontact)
            
            vc.currentContact = currentcontact
        }
    }
   
}


        extension UIImageView {
            func load(urlString : String) {
                    guard let url = URL(string: urlString)else {
                        return
                    }
                    DispatchQueue.global().async { [weak self] in
                        if let data = try? Data(contentsOf: url) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self?.image = image
                                }
                            }
                        }
                    }
                }
            }
        
