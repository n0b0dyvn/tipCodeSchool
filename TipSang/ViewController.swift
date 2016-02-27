//
//  ViewController.swift
//  TipSang
//
//  Created by Sang Vo Hoang on 2/27/16.
//  Copyright © 2016 Sang Vo Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercent: UISegmentedControl!
    @IBOutlet weak var sliderUI: UISlider!
    
    @IBOutlet weak var perCentSlide: UILabel!
    var LoadSetting = Setting().Load()
    
    func reloadSetting(){
        LoadSetting = Setting().Load()
        for i in 0...2 {
            let tipPer=Int(LoadSetting.tipArray[i]*100.0)
            tipPercent.setTitle(String(format: "%d%%",  tipPer), forSegmentAtIndex: i)
        }
        tipPercent.hidden = LoadSetting.slide
        sliderUI.hidden = !LoadSetting.slide
        sliderUI.minimumValue = Float(LoadSetting.tipArray[3])
        sliderUI.maximumValue = Float(LoadSetting.tipArray[4])
        perCentSlide.text = LoadSetting.slide ? String(format: "%d%%", Int(sliderUI.value * 100.0)): ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        reloadSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        if billField.text?.characters.count > 8 {
            billField.deleteBackward()
        }
        let billText = billField.text!
        let tipArray : [Double] = LoadSetting.tipArray
        let tipP = LoadSetting.slide ? Double(sliderUI.value) : tipArray[tipPercent.selectedSegmentIndex]
        let billAmount = billText.isEmpty ? 0.0: Double(billText)
        let tipAmount = billAmount!*tipP
        let totalAmount = billAmount! + tipAmount
        tipLabel.text = String(format:"$%.2f", tipAmount)
        totalLabel.text = String(format:"$%.2f", totalAmount)
    }
    
    @IBAction func valueChangeSlide(sender: AnyObject) {
        perCentSlide.text = LoadSetting.slide ? String(format: "%d%%", Int(sliderUI.value * 100.0)): ""
        let billText = billField.text!
        let billAmount = billText.isEmpty ? 0.0: Double(billText)
        let tip = Double(sliderUI.value)
        let tipAmount = billAmount!*tip
        let totalAmount = billAmount! + tipAmount
        tipLabel.text = String(format:"$%.2f", tipAmount)
        totalLabel.text = String(format:"$%.2f", totalAmount)
        
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadSetting()
        print("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }

}

