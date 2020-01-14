//
//  ApiResponse.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 13/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
import SwiftyJSON

public typealias RawApiResponse = [String : Any]

public protocol ApiResponseFormattable: class {
    var mensagemErroPadrao: String { get }
    func getTratada(resposta: Any?) -> (status: Bool, mensagemErro: String, json: JSON)

}

extension ApiResponseFormattable {

    var mensagemErroPadrao: String {
        return "Ops! Algo de errado aconteceu. Por favor, tente novamente mais tarde."
    }

    func getTratada(resposta: Any?) -> (status: Bool, mensagemErro: String, json: JSON) {
        guard let dicionario = resposta as? RawApiResponse else {
            return (false, "Não foi possível recuperar os dados.", .null)
        }
        let json = JSON(dicionario)
        if json["Fault"] != JSON.null {
            let faultstring = json["Fault"]["faultstring"].string ?? "Não foi possível recuperar os dados."
            return (false, faultstring, .null)
        } else if json["return"] != JSON.null {
            return (true, "", json["return"])
        }
        return (false, "Não foi possível recuperar os dados.", .null)
    }
}

