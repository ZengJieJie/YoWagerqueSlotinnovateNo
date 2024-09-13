//
//  HomeVC.swift
//  Nova Rush Slot Fever
//
//  Created by SSS CosmicSlot Royale on 10/09/24.
//

import UIKit
import StoreKit

class YoNoCosmicHomeVC: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var bv: UIVisualEffectView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    var timer: Timer?
    
    let arrbanners: [String] = [
        "B 1",
        "B 2",
        "B 3",
        "B 1",
        "B 2",
        "B 3",
        "B 1",
    ]
    
    var id = 0{
        
        didSet{
            
            if id >= arrbanners.count{
                id = 0
            }
            
            picker.selectRow(id, inComponent: 0, animated: true)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            
            UIView.animate(withDuration: 1) {
                
                self.btn1.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/15)
                self.btn2.transform = CGAffineTransform(rotationAngle: CGFloat.pi/15)
                self.btn3.transform = CGAffineTransform(rotationAngle: CGFloat.pi/7)
                
                self.bv.layer.cornerRadius = self.picker.bounds.width/2
                self.btn.layer.cornerRadius = 10
                self.btn1.layer.cornerRadius = 10
                self.btn2.layer.cornerRadius = 10
                self.btn3.layer.cornerRadius = 10
                
                self.bv.layer.borderWidth = 2
                self.btn.layer.borderWidth = 2
                self.btn1.layer.borderWidth = 2
                self.btn2.layer.borderWidth = 2
                self.btn3.layer.borderWidth = 2
                
            } completion: { _ in
                print("DONE...")
            }
        }
        
    }
    
     override func viewWillAppear(_ animated: Bool) {
         
         timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
             self.id += 1
         })
         
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         
         timer?.invalidate()
         timer?.fire()
         timer = nil
         
     }
     
    
    @IBAction func btnRate(_ sender: Any) {
        
        SKStoreReviewController.requestReview()
        
    }
    
    
}

//MARK: Extension

extension YoNoCosmicHomeVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        arrbanners.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let viewImg = UIImageView()
        
        viewImg.image = UIImage(named: arrbanners[row])
        
        viewImg.contentMode = .scaleAspectFill
        viewImg.frame.size = CGSize(width: pickerView.bounds.width*0.7, height: pickerView.bounds.width*0.7)
        viewImg.clipsToBounds = true
        viewImg.layer.cornerRadius = viewImg.bounds.width/2
        
        return viewImg
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return pickerView.bounds.width * 0.7
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        id = row
    }
}
   

