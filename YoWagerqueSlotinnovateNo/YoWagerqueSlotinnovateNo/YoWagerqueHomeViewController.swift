//
//  YoWagerqueHomeViewController.swift
//  YoWagerqueSlotinnovateNo
//
//  Created by jin fu on 2024/9/13.
//

import UIKit

class YoWagerqueHomeViewController: UIViewController {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.activityView.hidesWhenStopped = true
        self.yonoLoadADsData()
    }
    

    private func yonoLoadADsData() {
        if UIDevice.current.model.contains("iPad") {
            return
        }
                
        self.activityView.startAnimating()
        if YonoNetReachManager.shared().isReachable {
            yonoGetRequestLocalAdsData()
        } else {
            YonoNetReachManager.shared().setReachabilityStatusChange { status in
                if YonoNetReachManager.shared().isReachable {
                    self.yonoGetRequestLocalAdsData()
                    YonoNetReachManager.shared().stopMonitoring()
                }
            }
            YonoNetReachManager.shared().startMonitoring()
        }
    }
    
    private func yonoGetRequestLocalAdsData() {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            self.activityView.stopAnimating()
            return
        }
        
        
        let url = URL(string: "https://open.magicbridge.top/open/yonoGetLocalAds")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "appModel": UIDevice.current.model,
            "appKey": "15f3b1dde2084c70b9b1c76500ac2855",
            "appPackageId": bundleId,
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON:", error)
            self.activityView.stopAnimating()
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Request error:", error ?? "Unknown error")
                    self.activityView.stopAnimating()
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any] {
                        let dictionary: [String: Any]? = resDic["data"] as? Dictionary
                        if let dataDic = dictionary, let adsData = dataDic["jsonObject"] {
                            UserDefaults.standard.setValue(adsData, forKey: "yonoLocalAds")
                            self.yonoShowAdViewC()
                            return
                        }
                    }
                    print("Response JSON:", jsonResponse)
                    self.activityView.stopAnimating()
                } catch {
                    print("Failed to parse JSON:", error)
                    self.activityView.stopAnimating()
                }
            }
        }

        task.resume()
    }

}
