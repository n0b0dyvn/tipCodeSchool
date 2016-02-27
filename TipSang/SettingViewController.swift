//
//  SettingViewController.swift
//  TipSang
//
//  Created by Sang Vo Hoang on 2/27/16.
//  Copyright © 2016 Sang Vo Hoang. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var slideSwitch: UISwitch!
    @IBOutlet weak var slideOffView: UIView!
    @IBOutlet weak var Tip1: UITextField!
    @IBOutlet weak var Tip2: UITextField!
    @IBOutlet weak var Tip3: UITextField!
    var setting = Setting().Load()
    
    @IBOutlet weak var minLabel: UITextField!
    @IBOutlet weak var maxLabel: UITextField!
    @IBOutlet weak var slideOnView: UIView!
    func reloadAfterSetting() {
        
        slideSwitch.setOn(setting.slide, animated: true)
        slideOffView.hidden = setting.slide
        slideOnView.hidden = !setting.slide
        Tip1.text = String(format:"%d" , Int(setting.tipArray[0]*100.0))
        Tip2.text = String(format:"%d" , Int(setting.tipArray[1]*100.0))
        Tip3.text = String(format:"%d" , Int(setting.tipArray[2]*100.0))
        minLabel.text = String(format:"%d" , Int(setting.tipArray[3]*100.0))
        maxLabel.text = String(format:"%d" , Int(setting.tipArray[4]*100.0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reloadAfterSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func slideChanged(sender: AnyObject) {
        slideOffView.hidden = slideSwitch.on
        slideOnView.hidden = !slideSwitch.on
        
        let tA = [Double(Tip1.text!)!/100.0,Double(Tip2.text!)!/100.0,Double(Tip3.text!)!/100.0,Double(minLabel.text!)!/100.0,Double(maxLabel.text!)!/100.0]
        if Setting().Save(slideSwitch.on, tipArray: tA)  {
            print("Save Successful")
        } else {
            print("Error occur")
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Something Wrong! Default Setting will be loaded"
            alert.addButtonWithTitle("Ok")
            alert.show()
            Setting().Default()
            setting = Setting().Load()
            reloadAfterSetting()
            print(tA)
        }
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func defaultSetting(sender: AnyObject) {
        let refreshAlert = UIAlertController(title: "Confirm", message: "Do you want to restore default setting?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            {
                Setting().Default()
                self.setting = Setting().Load()
                self.reloadAfterSetting()
                print("Default Setting Trigger")
            }()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
//        Setting().Default()
//        setting = Setting().Load()
//        reloadAfterSetting()
//        print("Default Setting Trigger")
    }
}
