//
//  LoginService.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 13/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
import SwiftyJSON
class LoginService: ApiResponseFormattable {
    private let url = "https://empresas.ioasys.com.br/api/v1/users/auth/sign_in"
    
    let repository = ApiRequest()
    
    func requestLogin(email: String, senha: String, sucesso: @escaping((InvestorLogin) -> Void), falha: @escaping((String) -> Void)) {
        let consulta = url
        let params = [
                    "email":email,
                    "password":senha,
        ]
        repository.postRequest(url: consulta, params: params){
            (result, err)  in
            
            let resultado = self.getTratada(resposta: result)
            
            if resultado.status {
                if let user = self.userDecodification(jsonResult: resultado.json){
                    sucesso(user)
                }
            }else{
                falha(resultado.mensagemErro)
            }
        }
    }
    
    fileprivate func userDecodification(jsonResult: JSON) -> InvestorLogin? {
        do {
            let decoder = JSONDecoder()
            let data = try jsonResult.rawData()
            let elegibilidade = try decoder.decode(InvestorLogin.self, from: data)
            return elegibilidade
        } catch {
            return nil
        }
    }
    
}
