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
    
    /*
    var emailArray = [String]()
    var commentArray = [String]()
    var imageArray = [String]()
    */
    
    var postArray = [Post]()
    
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
                    
                    //self.imageArray.removeAll(keepingCapacity: false)
                    //self.emailArray.removeAll(keepingCapacity: false)
                    //self.commentArray.removeAll(keepingCapacity: false)
                    
                    self.postArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        // let documentId = document.documentID
                        
                        if let imageURL = document.get("imageURL") as? String {
                            if let comment = document.get("comment") as? String {
                                if let email = document.get("email") as? String {
                                    let post = Post(email: email, comment: comment, imageURL: imageURL)
                                    self.postArray.append(post)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailText.text = postArray[indexPath.row].email
        cell.commentText.text = postArray[indexPath.row].comment
        cell.postImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].imageURL), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
   
}
