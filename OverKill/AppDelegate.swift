//
//  AppDelegate.swift
//  OverKill
//
//  Created by BinaryBoy on 12/25/16.
//  Copyright © 2016 BinaryBoy. All rights reserved.
//


import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!
  
  let statusItem = NSStatusBar.system().statusItem(withLength: -2)
  let popover = NSPopover()

  func applicationDidFinishLaunching(_ notification: Notification) {
    if let button = statusItem.button {
      button.image = NSImage(named: "StatusBarButtonImage")
      button.action = #selector(AppDelegate.togglePopover(_:))
    }

    popover.contentViewController = AppsViewController(nibName: "AppsViewController", bundle: nil)


  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  func togglePopover(_ sender: AnyObject?) {
    if popover.isShown {
      closePopover(sender)
    } else {
      showPopover(sender)
    }
  }

  func showPopover(_ sender: AnyObject?) {
    if let button = statusItem.button {
      popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
    }
  }

  func closePopover(_ sender: AnyObject?) {
    popover.performClose(sender)
  }
}

