//
//  Statics.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 21/01/20.
//  Copyright © 2020 Rafael Martins. All rights reserved.
//

import Foundation
struct Statics {
  
  struct APIKeys {
//    static let API_HOST_URL = APIRequest.APIConstants.mediaBaseURL.absoluteString //Production
    static let API_HOST_URL = APIRequest.APIConstants.baseURL.absoluteString // Homologation
    static let API_PATH_URL = "api/v1/"
    static let authenticationHeaders = ["access-token", "client", "uid", "token-fdc"]
    static let authenticationHeadersDefaultsKey = "authenticationHeaders"
  }
    
    struct UserDefaultsKeys {
        static let kIsAlredyUsed = "isAlredyUsed"
        static let kUserIsLogeddIn = "userIsLogeddIn"
        static let kIsRegistred = "isRegistred"
        static let kUserId = "userId"
        static let kBirthDate = "userBirthDate"
        static let kIsAlredySeen = "isAlredySeen"
        static let kDeviceToken = "deviceToken"
        static let kNewsLastSearch = "newsLastSearch"
        static let kInfoHiden = "infoHiden"
        static let kchatbotDone = "chatbotDone"
        static let kUser = "userDetail"
    }
    
    struct Strings {
        
        struct Urls {
            static let kLogin = "auth/sign_in"
            static let kRegister = "users"
            static let kHome = "home"
            static let kPublications = "publications"
            static let kProfile = "home/profile"
            static let kCheckUser = "users/check_uid"
            static let kFavorit = "favorites/"
            static let kChangePassword = "password/change_password"
            static let kCoursesActual = "courses"
            static let kUpdateNotificationToken = "notifications/update_device"
            static let kNotifications = "notifications"
            static let kCommentPublication = "comment_publications"
            static let kCommentPlaylist = "comment_playlists"
            static let kCommentContentPlaylist = "comment_file_upload_playlists"
            static let kConnection = "friends"
            static let kUsers = "users"
            static let kEvents = "events"
            static let kInterests = "interests"
            static let kFavoriteEvent = "favorite_events"
            static let kFavoritePublications = "favorite_publications"
            static let kSuggestionContacts = "friends/suggestion_friendship"
            static let kInterestUsers = "interest_users"
            static let kLogout = "auth/sign_out"
        }
        
    }

}
