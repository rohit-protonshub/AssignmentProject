//
//  WebServices.swift
//  SDLabsTest
//
//  Created by Lokesh Dudhat on 09/02/20.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation
import Alamofire

typealias completion = (RootModel?, AFError?) -> ()
class WebServices {
    

    static let shared = WebServices()
    var request: DataRequest? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    
    func getURL(offset: Int = 0, limit: Int = 10) -> String {
        return "http://sd2-hiring.herokuapp.com/api/users?offset=\(offset)&limit=\(limit)"
    }
    
    
    func fetchUserInfo(offset: Int = 0, limit: Int = 10, completion: completion?) {
        if request != nil {
            return
        }
        let url = getURL(offset: offset, limit: limit)
        request = AF.request(url)
        request?.responseData(completionHandler: { [weak self](response) in
            switch response.result {
            case .success(let value):
                let rootObj = try! JSONDecoder().decode(RootModel.self, from: value)
                completion?(rootObj,nil)
                break
            case .failure(let error):
                completion?(nil, error)
                break
            }
            self?.request = nil
        })
    }
}
