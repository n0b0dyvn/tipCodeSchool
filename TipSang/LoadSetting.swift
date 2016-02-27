//
//  LoadSetting.swift
//  TipSang
//
//  Created by Sang Vo Hoang on 2/27/16.
//  Copyright © 2016 Sang Vo Hoang. All rights reserved.
//

import Foundation
//Setting Class is Class for load , save setting or restore default setting
// Setting have some properites
// SlideSwitch : Save State of SlideSwitch - Default: false
// Tip1Percent : Current Percent of 1st Segment Tip - Default: 10
// Tip2Percent : Current Percent of 2nd Segment Tip - Default: 20
// Tip3Percent : Current Percent of 3rd Segment Tip - Default: 25
class Setting {
    
    
    func Default(){
        let currentSetting = NSUserDefaults.standardUserDefaults()
        
        currentSetting.setBool(false, forKey: "SlideSwitch")
        currentSetting.setDouble(0.1, forKey:"Tip1Percent")
        currentSetting.setDouble(0.2, forKey:"Tip2Percent")
        currentSetting.setDouble(0.25, forKey:"Tip3Percent")
        currentSetting.setDouble(0.1, forKey:"TipSlideMin")
        currentSetting.setDouble(0.4, forKey:"TipSlideMax")
        currentSetting.synchronize()
    }
    func Save(slide:Bool,tipArray:[Double])-> Bool{
        let currentSetting = NSUserDefaults.standardUserDefaults()
//        Validate
        var validated=true
        if tipArray.count == 5{
            for tip in tipArray{
                if tip < 0 || tip > 1 {
                    validated = false
                    break
                }
            }
            if tipArray[3]>=tipArray[4] {
                validated = false
            }
        } else {
                validated = false
        }
        if !validated {
            return false
        }
//        End Validate
        currentSetting.setBool(slide, forKey: "SlideSwitch")
        currentSetting.setDouble(tipArray[0], forKey:"Tip1Percent")
        currentSetting.setDouble(tipArray[1], forKey:"Tip2Percent")
        currentSetting.setDouble(tipArray[2], forKey:"Tip3Percent")
        currentSetting.setDouble(tipArray[3], forKey:"TipSlideMin")
        currentSetting.setDouble(tipArray[4], forKey:"TipSlideMax")
        currentSetting.synchronize()
        return true
    }
    
    func Load() -> (slide:Bool,tipArray:[Double]){
        let currentSetting = NSUserDefaults.standardUserDefaults()
        if currentSetting.objectForKey("SlideSwitch") == nil {
            Default()
        }
        let tA = [currentSetting.doubleForKey("Tip1Percent"),currentSetting.doubleForKey("Tip2Percent"),currentSetting.doubleForKey("Tip3Percent"),currentSetting.doubleForKey("TipSlideMin"),currentSetting.doubleForKey("TipSlideMax")]
        print(tA)
        return (currentSetting.boolForKey("SlideSwitch"),tA)
    }
    
}