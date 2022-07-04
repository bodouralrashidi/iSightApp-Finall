

import UIKit
import MessageUI

class SendSMSViewController: UIViewController,MFMessageComposeViewControllerDelegate {
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let msgVC = MFMessageComposeViewController()
            msgVC.body = "testttt"
            msgVC.recipients = ["55715988"] //if i have more i just add coma and add next numbers
            msgVC.messageComposeDelegate = self
            self.present(msgVC, animated: true, completion : nil)
    }
    

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
    }
        
}
