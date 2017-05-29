//
//  AppDelegate.swift
//  mitotte-client
//
//  Created by 上野 涼 on 2017/05/29.
//  Copyright © 2017年 上野 涼. All rights reserved.
//

import Cocoa
import Alamofire

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let ACTIVITY_TOLERANCE = 1
    let ACTIVITY_INTERVAL = 2
    let ACTIVITY_WAITTIME = 5

    let SCREENSHOT_FILENAME = "screenshot.png"
    let SCREENSHOT_UPLOAD_URL = "http://localhost/api/v1/screenshots"

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Get uuid from user defaults or create.
        let userDefaults = UserDefaults.standard
        var uuid = ""
        if let saved_uuid = userDefaults.string(forKey: "uuid") {
            uuid = saved_uuid
        } else {
            uuid = NSUUID().uuidString
            userDefaults.set(uuid, forKey: "uuid")
        }
        let parameters = ["uuid": uuid]

        let activity = NSBackgroundActivityScheduler(identifier: Bundle.main.bundleIdentifier!)
        activity.repeats = true
        activity.tolerance = TimeInterval(ACTIVITY_TOLERANCE)
        activity.interval = TimeInterval(ACTIVITY_WAITTIME)

        activity.schedule() { (completion: NSBackgroundActivityCompletionHandler) in
            sleep(UInt32(self.ACTIVITY_WAITTIME))

            let imageRep: CGImage = CGDisplayCreateImage(CGMainDisplayID())!
            let bitmap = NSBitmapImageRep(cgImage: imageRep)
            let properties = NSDictionary() as! [String : AnyObject]
            let data = bitmap.representation(using: NSPNGFileType, properties: properties)
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(data!, withName: "screenshot", fileName: self.SCREENSHOT_FILENAME, mimeType: "image/png")
                    for (key, val) in parameters {
                        multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                    }
                },
                to: self.SCREENSHOT_UPLOAD_URL,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            if let jsonResponse = response.result.value as? [String: Any] {
                                print(jsonResponse)
                            }
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                }
            )
            completion(NSBackgroundActivityScheduler.Result.finished)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

