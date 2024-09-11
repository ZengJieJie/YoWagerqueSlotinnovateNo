//
//  YoWagerqueNavigationController.swift
//  YoWagerqueSlotinnovateNo
//
//  Created by jin fu on 2024/9/11.
//

import UIKit
import KSCrash

class YoWagerqueNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let installation = CrashInstallationEmail.shared
        installation.recipients = ["ajhpoazrlb@outlook.com"] // Specify recipients for email reports
        installation.setReportStyle(.apple, useDefaultFilenameFormat: true)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var shouldAutorotate: Bool {
        return true
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
