//
//  ViewController.swift
//  CoreDataOneToManyRelationship
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bookListTableView: UITableView!
    
    var book: [Books] = []
    
    //    var book = ["ponniyin selvan", "horry potter", "rajeshkumar's crime"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookListTableView.register(UINib(nibName: "BookListTableViewCell", bundle: nil), forCellReuseIdentifier: "BookListTableViewCell")
        self.bookListTableView.tableFooterView = UIView()
        let btn1 = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBtnOnTap))
        btn1.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = btn1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchBookDetails()
        self.bookListTableView.reloadData()
    }
    
    @objc func  addBtnOnTap() {
        let addBookVC = self.storyboard?.instantiateViewController(withIdentifier: "AddBookViewController") as? AddBookViewController
        addBookVC?.type = .Save
        self.navigationController?.pushViewController(addBookVC!, animated: true)
    }
    
    func fetchBookDetails() {
        book = Books.fetchDetails() as! [Books]
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.book.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookListTableViewCell", for: indexPath) as! BookListTableViewCell
        cell.delegate = self
        let btn1 = MGSwipeButton(title: "", icon: UIImage(named:"Editicon.pdf"), backgroundColor: .clear)
        let btn2 = MGSwipeButton(title: "", icon: UIImage(named:"deleteimage.pdf"), backgroundColor: .clear)
        cell.rightButtons = [btn2!, btn1!]
        cell.rightSwipeSettings.transition = MGSwipeTransition.rotate3D
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.bookNameLbl.text = self.book[indexPath.row].name
        return cell
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        let selectedIndexPath = self.bookListTableView.indexPath(for: cell)!
        let selectedBook = self.book[selectedIndexPath.row]
        if index == 0 {
            self.showActionSheetWithTitle(title: "Are you sure?", message: nil, actionTitle: ["Delete", "Cancel"], actionStyle: [.destructive, .default], sourceView: self.view) { (tappedButton) in
                if tappedButton == "Delete" {
                    let flag = Books.deleteOperation(individualBook: selectedBook)
                    if flag == true {
                        self.book.remove(at: selectedIndexPath.row)
                        self.bookListTableView.deleteRows(at: [selectedIndexPath], with: .fade)
                    }
                }
            }
            return true
        }
        else {
            let addBookVC = self.storyboard?.instantiateViewController(withIdentifier: "AddBookViewController") as? AddBookViewController
            addBookVC?.book = selectedBook
            addBookVC?.obId = selectedBook.objectID
            addBookVC?.type = .Update
            self.navigationController?.pushViewController(addBookVC!, animated: true)
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = self.book[indexPath.row]
        let authorVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthorDisplayViewController") as? AuthorDisplayViewController
        authorVC?.selectedBook = selectedBook
        self.navigationController?.pushViewController(authorVC!, animated: true)
    }
}


