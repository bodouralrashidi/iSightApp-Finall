//
//  TabBarVC.swift
//  Socket
//
//  Created by dalal aljassem on 1/6/22.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        // Do any additional setup after loading the view.
        
        loadfirebase()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            print("**************",contactList)
           
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.selectedIndex = 1
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
