//
//  CreateAuthorViewController.swift
//  CoreDataOneToManyRelationship
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class CreateAuthorViewController: UIViewController {
    
    var selectedBook : Books?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Author"
        self.navigationController?.navigationBar.isHidden = false
        let btn2 = UIBarButtonItem(image: UIImage(named: "BackArrow.pdf"), style: .plain, target: self, action: #selector(backBtnOnTap))
        self.navigationItem.leftBarButtonItem = btn2
    }
    
    @objc func backBtnOnTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createNewAuthorOnTap(_ sender: UIButton) {
        self.loadAuthorVC(flag: false)
    }
    
    @IBAction func existingAuthorOnTap(_ sender: UIButton) {
        self.loadAuthorVC(flag: true)
    }
    
    func loadAuthorVC(flag : Bool) {
        let createAuthorVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewAuthorViewController") as? CreateNewAuthorViewController
        createAuthorVC?.selectedBook = selectedBook
        createAuthorVC?.isFromExistingAuthor = flag
        createAuthorVC?.type = .Save
        self.navigationController?.pushViewController(createAuthorVC!, animated: true)
    }
}
