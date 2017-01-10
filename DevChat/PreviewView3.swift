//
//  PreviewView3.swift
//  DevChat
//
//  Created by Alfonso, Hector I. on 12/28/16.
//  Copyright © 2016 Alfonso, Hector I. All rights reserved.
//

import Foundation


import UIKit
import AVFoundation

class PreviewView: UIView {
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    var session: AVCaptureSession? {
        get {
            return videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.session = newValue
        }
    }
    
    // MARK: UIView
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
