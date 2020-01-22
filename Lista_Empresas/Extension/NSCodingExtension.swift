//
//  NSCodingExtension.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation

public extension NSCoding {
    func encode() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
    static func decode(data: Data?) -> Self? {
        guard let data = data else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? Self
    }
}
