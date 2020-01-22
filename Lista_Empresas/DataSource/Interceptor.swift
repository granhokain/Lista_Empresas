//
//  Interceptor.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 14/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import UIKit

// Responsável por interceptar as chamadas e adicionar na lista de espera
class Interceptor {
    
    private var customError: CompanyError?
    var service = AuthenticationService()
    
    init(response: Any?, error: API.RequestError?, request: APIRequest) {
        customError = CompanyError(response: response, error: error)
        /*
         Caso uma request dê erro e o status code seja 401, a request é adiciona para ser feita após
         o refresh token.
         */
        if customError?.code == 401 {
            APICalls.shared.add(request)
        }
        
        // Chamado em APIRequest no handle de error
        func execute() {
            if customError?.code == 401 {
                if !APICalls.shared.isRefreshing {
                    print("Refresh")
                    //refresh()
                }
                
            }
        }
    }
    
    //MARK: APICalls
    
    //Responsável pelo gerenciamento temporário das chamadas em espera do refresh token.
    class APICalls {
        
        static let shared = APICalls()
        private init(){}
        var requests = [APIRequest]()
        
        // Flag para controlar as requisições e não permitir que chamadas sejam realizada durante o refresh token
        var isRefreshing = false {
            didSet {
                debugPrint("Interceptor -> isRefresing = \(isRefreshing)")
                makeRequest()
            }
        }
        
        // Flag utilizada para esconder ou mostrar o HUD para as chamadas em espera
        var isMakeRequest = false {
            didSet {
                if !isMakeRequest {
                    // hiddenHUD(true)
                }
            }
        }
        
        /* As chamadas só serão adicionadas se forem diferentes de autenticação/refreshToken, assim envitamos fazer dois refreshs para
         duas ou mais chamadas concorrentes
         */
        func add(_ request: APIRequest) {
            if request.path != "auth/sign_in" && request.path != "token" {
                self.requests.append(request)
                debugPrint("Interceptor -> addRequest = \(request.path)")
            }
        }
        
        // Faz a requets das chamadas em espera, a função é chamada após a conclusão do refresh token
        private func makeRequest() {
            for request in requests {
                if !isRefreshing {
                    request.makeRequest()
                    debugPrint("Interceptor -> makeRequest = \(request.path)")
                    //hiddenHUD(false)
                }
            }
            if !isRefreshing {
                requests.removeAll()
                debugPrint("Interceptor -> remove requests")
            }
        }
    }
}
