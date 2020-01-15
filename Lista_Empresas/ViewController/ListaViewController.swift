//
//  ListaViewController.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 08/12/19.
//  Copyright © 2019 Rafael Martins. All rights reserved.
//

import UIKit

class ListaViewController: UIViewController {
    
    
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var cancelSearchButton: UIButton!
    @IBOutlet weak var searchCompanyButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initialView.isHidden = false
        searchView.isHidden = true

    }
    
    @IBAction func showSearchView(_ sender: UIButton) {
        initialView.isHidden = true
        searchView.isHidden = false
    }
    
    @IBAction func cancelSearch(_ sender: UIButton) {
        initialView.isHidden = false
        searchView.isHidden = true
    }

}
