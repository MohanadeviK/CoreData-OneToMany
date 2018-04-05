//
//  AddBookViewController.swift
//  CoreDataOneToManyRelationship
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import CoreData

class AddBookViewController: UIViewController {
    
    @IBOutlet weak var aboutBookTextField: UITextField!
    @IBOutlet weak var publicatioTextField: UITextField!
    @IBOutlet weak var editionTextField: UITextField!
    @IBOutlet weak var bookNameTextField: UITextField!
    
    enum controlType {
        case Save
        case Update
    }
    var type : controlType = .Save
    
    var book = Books()
    var obId = NSManagedObjectID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bookNameTextField.becomeFirstResponder()
        var btn1 = UIBarButtonItem()
        if self.type == .Save {
            self.title = "Add a New Book"
            btn1 = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveBtnOnTap))
        }
        else {
            self.loadBookDetails()
            self.title = "Update a book"
            btn1 = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(updateBtnOnTap))
        }
        btn1.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = btn1
        let btn2 = UIBarButtonItem(image: UIImage(named: "BackArrow.pdf"), style: .plain, target: self, action: #selector(backBtnOnTap))
    }
    
    @objc func backBtnOnTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadBookDetails() {
        self.bookNameTextField.text = self.book.name
        self.publicatioTextField.text = self.book.pulication
        self.editionTextField.text = String(self.book.edition)
        self.aboutBookTextField.text = self.book.about
    }
    
    @objc func updateBtnOnTap() {
        let isUpdate = Books.updateContent(name: self.bookNameTextField.text!, edition: Int16(self.editionTextField.text!)!, publication: self.publicatioTextField.text!, aboutBook: self.aboutBookTextField.text!, updatedBookObj: self.obId)
        if isUpdate == true {
            self.showAlert(msg: "Updated Successfully", title: "Success")
        }
    }
    
    @objc func saveBtnOnTap() {
        if (!((self.bookNameTextField.text?.isEmpty)!) && !((self.editionTextField.text?.isEmpty)!) && !((self.publicatioTextField.text?.isEmpty)!) && !((self.aboutBookTextField.text?.isEmpty)!)) {
            let obj = Books.saveDetails(name: self.bookNameTextField.text!, edition: Int16( self.editionTextField.text!)!, publication: self.publicatioTextField.text!, aboutBook: self.aboutBookTextField.text!)
            if obj != nil {
                self.navigationController?.popViewController(animated: true)
            }
        }
        else {
            self.showAlert(msg: "Please enter all the fields", title: "Alert!")
        }
    }
    
    func showAlert(msg : String, title : String)
    {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            action -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        self.present(alertController, animated: true)
        {}
    }
}
