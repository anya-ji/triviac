//
//  NetworkManager.swift
//  Triviac
//
//  Created by Anya Ji on 5/5/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation
import Alamofire


class NetworkManager {

    static func getTrivia(completion: @escaping (([Trivia])) -> Void) {
        AF.request(CreateViewController.endpoint, method: .get).validate().responseData{
            response in switch response.result{
            case .success(let data):
                //decode data
                let decoder = JSONDecoder()
               
                if let triviaData = try? decoder.decode(TriviaResponse.self, from: data){
                    //print(triviaData)
                    let triviaset = triviaData.results
                    completion(triviaset)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
