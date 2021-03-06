//
//  CompanyListViewController.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 08/12/19.
//  Copyright © 2019 Rafael Martins. All rights reserved.
//

import UIKit

protocol CompanyListDelegate: class {
    func showCompanyDetail(from viewController: CompanyListViewController, detail: String)
}

class CompanyListViewController: UIViewController, HomeStoryboardLodable {
    
    
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var cancelSearchButton: UIButton!
    @IBOutlet weak var searchCompanyButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var initialBodyView: UIView!
    @IBOutlet weak var companyListView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var homePresenter: HomePresentable!
    fileprivate var companies = [Company]()
    weak var delegate: CompanyListDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initialView.isHidden = false
        initialBodyView.isHidden = false
        searchView.isHidden = true
        companyListView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = Colors.tableViewColor
    }
    
    @IBAction func showSearchView(_ sender: UIButton) {
        initialView.isHidden = true
        searchView.isHidden = false
    }
    
    @IBAction func cancelSearch(_ sender: UIButton) {
        initialView.isHidden = false
        searchView.isHidden = true
    }
    
    @IBAction func searchCompany(_ sender: UIButton) {
        guard let companyName = searchTextField.text else {
            return
        }
        
        if companyName == "" {
            homePresenter.getAllCompanyRequest()
        } else {
            homePresenter.getCompanyRequest(with: companyName)
        }
        
    }
}

extension CompanyListViewController: HomeViewable {
    
    func startLoading() {}
    
    func stopLoading() {}
    
    func successfulRequestCompanyList(company: Enterprises) {
        self.companies = company.enterprises
        self.tableView.reloadData()
        self.initialBodyView.isHidden = true
        self.companyListView.isHidden = false
    }
    
    func successfulRequestAllCompanyList(company: Enterprises) {
        self.companies = company.enterprises
        self.tableView.reloadData()
        self.initialBodyView.isHidden = true
        self.companyListView.isHidden = false
    }
    
    func showAlert(_ message: String) {
        self.initialBodyView.isHidden = false
        self.companyListView.isHidden = true
        let message = "Não foi possível obter a empresa. Tente novamente mais tarde."
        let alert = UIAlertController(title: "Algo deu errado…", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showConnectionError(_ message: String) {}
}

extension CompanyListViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"rowEmpresas", for: indexPath) as? CompanyCell else {
            return CompanyCell()
        }
        let enterprise = companies[indexPath.row]
        cell.set(company: enterprise)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comp = companies[indexPath.row]
        print(comp.enterpriseName!)
        guard let detailCompany = comp.description else {
            return
        }
        delegate?.showCompanyDetail(from: self, detail: detailCompany)
    }
}

