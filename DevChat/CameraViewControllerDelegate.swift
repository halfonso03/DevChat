//
//  CameraViewControllerDelegate.swift
//  DevChat
//
//  Created by Alfonso, Hector I. on 12/31/16.
//  Copyright © 2016 Alfonso, Hector I. All rights reserved.
//

import Foundation


protocol CameraViewControllerDelegate {
    
    func videoRecordingComplete(videoUrl: NSURL)
    func videoRecordingFailed()
   // func snapShotTaken(data: NSData)
    
}
