//
//  AppsViewController.swift
//  OverKill
//
//  Created by BinaryBoy on 12/25/16.
//  Copyright © 2016 BinaryBoy. All rights reserved.
//


import Cocoa
import ITSwitch
class AppsViewController: NSViewController {

    let app = App();

    var activeAppsNames:[String]  = [String]( repeating: "", count: 2 )

  override func viewWillAppear() {
    super.viewWillAppear()

    }
    @IBAction func photosActivce(_ sender: ITSwitch) {
    
        if sender.checked == true{
            activeAppsNames[0] = "Photos"
            
        }else{
            activeAppsNames[0] = ""
            
        }

        app.activeAppsNames = activeAppsNames;
    }
    @IBAction func itunesActive(_ sender: ITSwitch) {
        if sender.checked == true{
            activeAppsNames[1] = "iTunes"
  
        }else{
            activeAppsNames[1] = ""
        }
        app.activeAppsNames = activeAppsNames;
    
    }
}
class App: NSObject {
    let center: NotificationCenter = NSWorkspace.shared().notificationCenter
    var activeAppsNames:[String]  = [String]()

    override init(){
        super.init()
        center.addObserver(self, selector: #selector(newKeyApp), name: NSNotification.Name.NSWorkspaceDidActivateApplication, object: nil)
        center.addObserver(self, selector: #selector(newKeyApp), name: NSNotification.Name.NSWorkspaceWillLaunchApplication, object: nil)
    }
    
    func newKeyApp(notification: NSNotification){
        let runningApp : NSRunningApplication = (notification.userInfo! as Dictionary)["NSWorkspaceApplicationKey"]! as! NSRunningApplication
        
        
        for appName:String in activeAppsNames {
            
            if (runningApp.localizedName?.range(of:appName)) != nil{
                if !runningApp.isTerminated {
                    
                    print("\(runningApp.localizedName!) launched itself, killing the process now...💥")
                    runningApp.terminate()
                    runningApp.forceTerminate()
                    kill( runningApp.processIdentifier, SIGKILL );
                }
            }
            
        }
        
        

        
    }
}

