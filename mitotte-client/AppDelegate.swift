//
//  AppDelegate.swift
//  mitotte-client
//
//  Created by 上野 涼 on 2017/05/29.
//  Copyright © 2017年 上野 涼. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let ACTIVITY_TOLERANCE = 1
    let ACTIVITY_INTERVAL = 2
    let ACTIVITY_WAITTIME = 5

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let activity = NSBackgroundActivityScheduler(identifier: Bundle.main.bundleIdentifier!)
        activity.repeats = true
        activity.tolerance = TimeInterval(ACTIVITY_TOLERANCE)
        activity.interval = TimeInterval(ACTIVITY_WAITTIME)

        activity.schedule() { (completion: NSBackgroundActivityCompletionHandler) in
            sleep(UInt32(self.ACTIVITY_WAITTIME))
            print("execute")
            completion(NSBackgroundActivityScheduler.Result.finished)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

