//
//  ParticipantsTableViewController.swift
//
//
//  Created by Xiaobo Zhang on 11/19/17.
//

import UIKit
import Alamofire

class ParticipantsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myIndex = 0
    @IBOutlet weak var participantsTableView: UITableView!
    
    var participants = [User]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (participants.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "participantCell", for: indexPath) as! ParticipantTableViewCell
        cell.participantNameLabel.text = self.participants[indexPath.row].userName
        
        cell.participantImageLabel.image =  UIImage(named: "cat.png")
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.myIndex = indexPath.row
    }
}


