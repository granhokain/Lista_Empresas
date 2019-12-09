//
//  Repository.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 08/12/19.
//  Copyright © 2019 Rafael Martins. All rights reserved.
//

import Foundation

final class Repository {
    
    let coordinator = Coordinator()
    
    func postRequest(url: String, params: [String: String],
                     completion: @escaping ([String: Any]?, Error?) -> Void){
        //URL válida
        guard let URL = URL(string: url) else {
            completion(nil, nil)
            return
        }
            
        //Cria a representacão da requisição
        let request = NSMutableURLRequest(url: URL)

        //Converte as chaves em valores pares para os parametros em formato de String
        let postString = params.map { "\($0.0)=\($0.1)" }.joined(separator: "&")

        //Atribui à requisiçāo o método POST
        request.httpMethod = "POST"

        //Codifica o corpo da mensagem em "data" usando utf8
        request.httpBody = postString.data(using: String.Encoding.utf8)


        //Cria a tarefa de requisição
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            do {

                if let data = data {
                    //A resposta chegou
                    let response = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(response as? [String : Any], nil)
                }
                else {
                    //Não houve resposta
                    completion(nil, nil)
                }
            } catch let error as NSError {
                //Houve um erro na comunicao com o servidor
                completion(nil, error)
            }
        }
        //Aciona a tarefa
        task.resume()
    }
    
    func requestLogin(email: String, senha: String) {
        //Coloque a URL da sua API aqui
        let url = "https://empresas.ioasys.com.br/api/v1/users/auth/sign_in"

        //Aqui vão os parâmetros da sua requisição
        let params = [
                    "email":email,
                    "password":senha,
        ]
        
        //Chamando a funcão POST
        postRequest(url: url, params: params){
            (result, err)  in
            if let res:Bool = (result?.values.first as? Bool) {
                if(res) {
                    print("sua requisicao foi realizada com sucesso")
                    DispatchQueue.main.async {
                        self.coordinator.showListScreen()
                    }
                } else {
                    print("a requisicao nao funcionou")
                }
            }
        }
    }

}
