//
//  AuthorDisplayViewController.swift
//  CoreDataOneToManyRelationship
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AuthorDisplayViewController: UIViewController {
    
    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var aboutAuthorTextView: UITextView!
    @IBOutlet weak var nativeTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var authorNameTextField: UITextField!
    @IBOutlet weak var noAuthorFoundLbl: UILabel!
    
    var selectedBook : Books?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedBook?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.authorNameTextField.becomeFirstResponder()
        self.getAuthorDetails()
        self.navigationController?.navigationBar.isHidden = false
        let btn2 = UIBarButtonItem(image: UIImage(named: "BackArrow.pdf"), style: .plain, target: self, action: #selector(backBtnOnTap))
        self.navigationItem.leftBarButtonItem = btn2
    }
    
    func getAuthorDetails() {
        if let book = selectedBook?.author {
            self.noAuthorFoundLbl.isHidden = true
            let btn1 = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            self.navigationItem.rightBarButtonItem = btn1
            self.superView.isHidden = false
            self.authorNameTextField.text = book.name
            self.ageTextField.text = String(book.age)
            self.nativeTextField.text = book.native
            self.aboutAuthorTextView.text = book.aboutAuthor
        }
        else {
            self.noAuthorFoundLbl.isHidden = false
            self.setRightBarButtonItem()
            self.self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.superView.isHidden = true
        }
    }
    
    func setRightBarButtonItem() {
        let btn1 = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBtnOnTap))
        btn1.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = btn1
    }
    
    @objc func addBtnOnTap() {
        let createAuthorVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateAuthorViewController") as? CreateAuthorViewController
        createAuthorVC?.selectedBook = selectedBook
        self.navigationController?.pushViewController(createAuthorVC!, animated: true)
    }
    
    @objc func backBtnOnTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editBtnOnTap(_ sender: UIButton) {
        let createAuthorVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewAuthorViewController") as? CreateNewAuthorViewController
        createAuthorVC?.selectedBook = selectedBook
        if let authorObjId = self.selectedBook?.author {
            createAuthorVC?.objId = authorObjId.objectID
        }
        createAuthorVC?.type = .Update
        self.navigationController?.pushViewController(createAuthorVC!, animated: true)
    }
    
    @IBAction func deleteBtnOnTap(_ sender: UIButton) {
        let obj = Author.fetchBookCount(authorName: self.authorNameTextField.text!)
        var bookString = ""
        if obj! > 1 {
            bookString = "books"
        }
        else {
            bookString = "book"
        }
        self.showAlert(msg: "\(obj!) \(bookString)  are written by this author. Do you want to Delete?", title: "Confirmation", isFromDelete: true)
    }
    
    func showAlert(msg : String, title : String, isFromDelete: Bool)
    {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            action -> Void in
            if isFromDelete == true {
                let flag = Author.deleteOperation(bookObj: self.selectedBook!)
                    if flag == true {
                        self.showAlert(msg: "Deleted successfully!", title: "", isFromDelete: false)
                    }
            }
            else {
                self.navigationController?.popViewController(animated: true)
            }
        })
        self.present(alertController, animated: true)
        {}
    }
}
