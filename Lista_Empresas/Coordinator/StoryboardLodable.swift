//
//  StoryboardLodable.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardLodable: AnyObject {
    @nonobjc static var storyboardName: String { get }
}

protocol SplashStoryboardLodable: StoryboardLodable {}
protocol LoginStoryboardLodable: StoryboardLodable {}
protocol HomeStoryboardLodable: StoryboardLodable {}
protocol CompanyDetailsStoryboardLodable: StoryboardLodable {}


extension LoginStoryboardLodable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return StoryboardName.authentication.rawValue
    }
}

extension HomeStoryboardLodable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return StoryboardName.home.rawValue
    }
}

extension CompanyDetailsStoryboardLodable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return StoryboardName.companyDatails.rawValue
    }
}

extension SplashStoryboardLodable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return StoryboardName.splash.rawValue
    }
}
