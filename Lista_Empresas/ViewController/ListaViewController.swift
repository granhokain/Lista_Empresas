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
    @IBOutlet weak var initialBodyView: UIView!
    @IBOutlet weak var companyListView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var companyPresenter = CompanyListPresenter()
    fileprivate var company = [Company]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialView.isHidden = false
        initialBodyView.isHidden = false
        searchView.isHidden = true
        companyListView.isHidden = true
        companyPresenter.attachView(self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.alwaysBounceVertical = false

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
            companyPresenter.getAllCompanyRequest()
        } else {
            companyPresenter.getCompanyRequest(with: companyName)
        }
        
    }
    

}

extension ListaViewController: CompanyListProtocol {
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
    
    func successfulRequestCompanyList(company: Enterprises) {
//        guard let enterprises = company.enterprises else {
//            return
//        }
        self.company = company.enterprises
        self.tableView.reloadData()
        self.initialBodyView.isHidden = true
        self.companyListView.isHidden = false
    }
    
    func successfulRequestAllCompanyList(company: Enterprises) {
//        guard let enterprises = company.enterprises else {
//            return
//        }
        self.company = company.enterprises
        self.tableView.reloadData()
        self.initialBodyView.isHidden = true
        self.companyListView.isHidden = false
    }
    
    func showAlert(with message: String) {
        self.initialBodyView.isHidden = false
        self.companyListView.isHidden = true
        let mensagem = "Não foi possível obter a empresa. Tente novamente mais tarde."
        let alerta = UIAlertController(title: "Algo deu errado…", message: mensagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alerta.addAction(ok)
        self.present(alerta, animated: true, completion: nil)
    }
}

extension ListaViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return company.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"rowEmpresas", for: indexPath) as? EmpresasCell else {
            return EmpresasCell()
        }
        let enterprise = company[indexPath.row]
//        switch cartao.modalidadeCartao.funcaoDebito.situacaoFuncao.status {
//        case .desbloqueado:
//            cell.bloquearViewClick = {
//                self.cartaoSelecionadoBloqueio = cartao
//                self.solicitarPositivacao()
//            }
//        case .bloqueado:
//            cell.desbloquearViewClick = {
//                self.cartaoSelecionadoBloqueio = cartao
//                self.solicitarPositivacao()
//            }
//        }
//        cell.ajustarViews()
        cell.set(company: enterprise)
        
        return cell
    }
    
    
}

