//
//  ViewController.swift
//  SDLabsTest
//
//  Created by Lokesh Dudhat on 09/02/20.
//  Copyright © 2020 example. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UITableViewController {
    var arrUsers = [UserModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var limit = 20
    var offset = 0
    var hasMore = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl?.addTarget(self, action: #selector(ViewController.refreshList), for: .valueChanged)
        // Do any additional setup after loading the view.
        refreshList()
        title = "Event"
    }
    
    @objc func refreshList() {
        offset = 0
        hasMore = true
        arrUsers.removeAll()
        loadAPI()
    }
    
    func loadAPI() {
        refreshControl?.beginRefreshing()
        WebServices.shared.fetchUserInfo(offset: offset, limit: limit) { [weak self] (obj, error) in
            guard let strongSelf = self else {return}
            strongSelf.refreshControl?.endRefreshing()
            if let error = error {
                strongSelf.alertViewDisplay(title: error.localizedDescription)
            }
            else if let obj = obj {
                if obj.status {
                    strongSelf.hasMore = obj.data.has_more
                    strongSelf.arrUsers.append(contentsOf: obj.data.users)
                    strongSelf.offset += strongSelf.limit
                }
            }
            else {
                strongSelf.alertViewDisplay(title: "Something went wrong.")
            }
        }
    }
    
    func alertViewDisplay(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel) { (alert) in
            
        }
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
}


//MARK: - UITableViewDelegate, UITableViewDatasource
extension ViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if hasMore, indexPath.row == arrUsers.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell") as! LoadMoreCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = arrUsers[indexPath.row]
        cell.user = user
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrUsers.count == 0 {
            return 0
        }
        return arrUsers.count + (hasMore ? 1 : 0)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? LoadMoreCell {
            cell.indicator.startAnimating()
            loadAPI()
        }
    }
}
