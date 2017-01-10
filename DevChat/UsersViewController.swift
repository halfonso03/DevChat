//
//  UsersViewController.swift
//  DevChat
//
//  Created by Alfonso, Hector I. on 12/30/16.
//  Copyright © 2016 Alfonso, Hector I. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var usersTableview: UITableView!
    private var users = [User]()
    private var selectedUsers = [String: User]()
    private var _snapData: Data?
    private var _videoUrl: URL?
    private var _currentUserId: String = (FIRAuth.auth()?.currentUser!.uid)!
    
    var snapData: Data? {
        set {
            _snapData = newValue
        }
        get {
            return _snapData
        }
    }
    
    var videoUrl: URL? {
        set {
            _videoUrl = newValue
        }
        get {
            return _videoUrl
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem?.isEnabled = false
        
        usersTableview.delegate = self
        usersTableview.dataSource = self
        usersTableview.allowsMultipleSelection = true
        
        DataService.instance.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let users = snapshot.value as? [String: Any] {
                for (key, value) in users {
                    if key != self._currentUserId, let dict = value as? [String: Any] {
                        if let profile = dict["profile"] as? [String: Any] {
                            
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                self.users.append(User(uid: uid, firstName: firstName))
                            }
                        }
                    }
                    
                }
            }
            
            self.usersTableview.reloadData()
        })
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = usersTableview.cellForRow(at: indexPath) as! UserCell
        cell.setCheckMark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = usersTableview.cellForRow(at: indexPath) as! UserCell
        cell.setCheckMark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count == 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableview.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    
    @IBAction func sendPRButtonPressed(sender: Any) {
        
        if self._videoUrl != nil {
            
            let videoName = "\(NSUUID().uuidString)\(_videoUrl)"
            let ref = DataService.instance.videoStorageRef.child(videoName)
            
            _ = ref.putFile(_videoUrl!, metadata: nil, completion: { (meta, error) in
                if error !=  nil {
                    print ("error uplaoding video \(error?.localizedDescription)")
                }
                else {
                    let downloadUrl = meta?.downloadURL()
                   
                    DataService.instance.sendMediaPullRequests(senderUID: (FIRAuth.auth()?.currentUser?.uid)!, sendToUser: self.selectedUsers, mediaUrl: downloadUrl!, textSnippet: "coding today was legit")
                    
                }
                
            })
            self.dismiss(animated: true, completion: nil)
        }
        else if self._snapData != nil {
            let ref = DataService.instance.imageStorageRef.child("\(NSUUID().uuidString).jpg")
            _ = ref.put(_snapData!, metadata: nil, completion: { (meta, error) in
                if error != nil {
                    print ("Error uploading snapshot \(error?.localizedDescription)")
                }
                else {
                    let downloadUrl = meta?.downloadURL()
                    
                    
                    // save url
                }
            })
            self.dismiss(animated: true, completion: nil)   
        }
        
        
    }

    
  

}
