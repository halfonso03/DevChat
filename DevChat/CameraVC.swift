//
//  CameraVC.swift
//  DevChat
//
//  Created by Alfonso, Hector I. on 12/29/16.
//  Copyright © 2016 Alfonso, Hector I. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CameraVC: CameraViewController, CameraViewControllerDelegate {

    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var livePhotoModeButton: UIButton!
    @IBOutlet weak var captureModeControl: UISegmentedControl!
    
    override func viewDidLoad() {
        
        self._previewView = previewView
        self._cameraButton = cameraButton
        self._photoButton = photoButton
        self._livePhotoModeButton = livePhotoModeButton
        self._captureModeControl = captureModeControl
        self._recordButton = recordButton
        
        super.viewDidLoad()
        
        
        self.cameraViewControllerDelegate = self

    }

    func videoRecordingFailed() {
        
    }
    
    func videoRecordingComplete(videoUrl: NSURL) {
        performSegue(withIdentifier: "UserVC", sender: ["videoUrl": videoUrl])
    }
    
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard FIRAuth.auth()?.currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//       
//        guard FIRAuth.auth()?.currentUser != nil else {
//            performSegue(withIdentifier: "LoginVC", sender: nil)
//            return
//        }
//    }
//   

    @IBAction func photoButtonPressed(_ sender: UIButton) {

     
    }
 
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        self.toggleMovieRecording()
    }
   
    
    @IBAction func changeCamera(_ sender: UIButton) {
        self.changeCamera()
    }
    
    
    @IBAction func chagneCaptureMode(_ sender: UISegmentedControl) {
        
        self.toggleCaptureMode(sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let usersVC = segue.destination as? UsersViewController {
            if let videoDict = sender as? [String: NSURL] {
                if let url = videoDict["videoUrl"] {
                    usersVC.videoUrl = url as URL
                }
            }
            else if let snapDict = sender as? [String: Data] {
                let snapData = snapDict["snapshotData"]
                //usersVC.snapData = snapData
            }
        }
    }
  

}
