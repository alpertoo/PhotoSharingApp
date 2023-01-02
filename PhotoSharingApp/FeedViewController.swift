//
//  FeedViewController.swift
//  PhotoSharingApp
//
//  Created by Alper Koçer on 30.12.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()
    var commentArray = [String]()
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getFirebaseData()
    }
    
    func getFirebaseData() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Post").order(by: "data", descending: true)
            .addSnapshotListener { snapshot, error in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.emailArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        // let documentId = document.documentID
                        
                        if let imageURL = document.get("imageURL") as? String {
                            self.imageArray.append(imageURL)
                        }
                        
                        if let comment = document.get("comment") as? String {
                            self.commentArray.append(comment)
                        }
                        
                        if let email = document.get("email") as? String {
                            self.emailArray.append(email)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailText.text = emailArray[indexPath.row]
        cell.commentText.text = commentArray[indexPath.row]
        cell.postImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
   
}
