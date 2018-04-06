//
//  CreateNewAuthorViewController.swift
//  CoreDataOneToManyRelationship
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import CoreData

class CreateNewAuthorViewController: UIViewController {
    
    @IBOutlet weak var authorPicker: UIPickerView!
    @IBOutlet weak var authorAboutTextView: UITextView!
    @IBOutlet weak var authorNativeTextField: UITextField!
    @IBOutlet weak var authorAgeTextField: UITextField!
    @IBOutlet weak var authorNameTextField: UITextField!
    
    var selectedBook : Books?
    var objId = NSManagedObjectID()
    var isFromExistingAuthor = Bool()
    var selectedAuthorIndex : Int?
    var authors = [Author]()
    
    enum controlType {
        case Save
        case Update
    }
    var type : controlType = .Save
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.isFromExistingAuthor == true {
            self.fetchAuthors()
            self.authorPicker.isHidden = false
            self.authorNameTextField.isUserInteractionEnabled = false
            self.authorNameTextField.isHidden = true
        }
        else {
            self.authorPicker.isHidden = true
            self.authorNameTextField.becomeFirstResponder()
            self.authorNameTextField.isUserInteractionEnabled = true
            self.authorNameTextField.isHidden = false
        }
        self.navigationController?.navigationBar.isHidden = false
        var btn1 = UIBarButtonItem()
        if self.type == .Save {
            self.title = "New Author"
            btn1 = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveBtnOnTap))
            
        }
        else {
            self.loadAuthorDetails()
            self.title = "Update Author"
            btn1 = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(saveBtnOnTap))
            
        }
        btn1.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = btn1
        let btn2 = UIBarButtonItem(image: UIImage(named: "BackArrow.pdf"), style: .plain, target: self, action: #selector(backBtnOnTap))
        self.navigationItem.leftBarButtonItem = btn2
    }
    
    func fetchAuthors() {
        authors = Author.fetchDetails()
    }
    
    @objc func saveBtnOnTap() {
        if self.type == .Save {
            if self.isFromExistingAuthor == false {
                let obj = Author.saveDetails(name: self.authorNameTextField.text!, age: Int16(self.authorAgeTextField.text!)!, native: self.authorNativeTextField.text!, about: self.authorAboutTextView.text, bookObj: self.selectedBook!)
                if obj != nil {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            else {
                if let selectedIndex = self.selectedAuthorIndex {
                    Author.linkExistingAuthorWithBook(book: self.selectedBook!, autherId: self.authors[selectedIndex].objectID)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        else {
            if let selectedIndex = self.selectedAuthorIndex {
                let isUpdate = Author.updateContent(name: self.authorNameTextField.text!, age: Int16(self.authorAgeTextField.text!)!, aboutAuthor: self.authorAboutTextView.text!, native: self.authorNativeTextField.text!, updatedAuthorObj: self.authors[selectedIndex].objectID)
                if isUpdate == true {
                    self.showAlert(msg: "Updated Successfully", title: "Success")
                }
            }
        }
    }
    
    func loadAuthorDetails() {
        if let authorDetails = self.selectedBook?.author {
            self.authorNameTextField.text = authorDetails.name
            self.authorAgeTextField.text = String(authorDetails.age)
            self.authorNativeTextField.text = authorDetails.native
            self.authorAboutTextView.text = authorDetails.aboutAuthor
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
    
    @objc func backBtnOnTap() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        for aViewController in viewControllers {
            if(aViewController is AuthorDisplayViewController){
                self.navigationController?.popToViewController(aViewController, animated: true);
            }
        }
    }
}


extension CreateNewAuthorViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return authors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return authors[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.authorPicker.isHidden = true
        self.authorNameTextField.isHidden = false
        self.authorNameTextField.text = self.authors[row].name
        self.authorAgeTextField.text = String(self.authors[row].age)
        self.authorNativeTextField.text = self.authors[row].native
        self.authorAboutTextView.text = self.authors[row].aboutAuthor
        self.selectedAuthorIndex = row // change
        self.authorNameTextField.isUserInteractionEnabled = false
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}
