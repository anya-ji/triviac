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

    var link = CreateViewController.endpoint

//    static func getCourses(completion: @escaping (([Course])) -> Void) {
//        AF.request(endpoint, method: .get).validate().responseData{
//            response in switch response.result{
//            case .success(let data):
//                //decode data
//                let decoder = JSONDecoder()
//
//                if let coursesData = try? decoder.decode(Coursesresponse.self, from: data){
//                    print(coursesData)
//                    let classes = coursesData.data.classes
//                    completion(classes)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    static func login(email: String, password: String) {
//        let parameters: [String: Any] = [
//            "email": email,
//            "password": password
//        ]
//        AF.request(postEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData{ response in
//            switch response.result{
//            case .success(let data):
//                      //decode data
//                      let decoder = JSONDecoder()
//
//                      if let userData = try? decoder.decode(User.self, from: data){
//                        print (userData.token)
//                }
//                  case .failure(let error):
//                      print(error.localizedDescription)
//            }
//        }
//        //URLEncoding.default
//    }
//
//    static func getRandomDog(completion: @escaping (UIImage) -> Void) {
//        AF.request(dogEndpoint, method:  .get).validate().responseData{ response in
//            switch response.result{
//            case .success(let data):
//                      //decode data
//                      let decoder = JSONDecoder()
//
//                      if let dogData = try? decoder.decode(Dog.self, from: data){
//                        let url = dogData.url
//                        fetchDogImage(imageURL: url, completion: completion)
//                }
//                  case .failure(let error):
//                      print(error.localizedDescription)
//            }
//        }
//    }
//
//    static func fetchDogImage(imageURL: String, completion: @escaping ((UIImage)) -> Void) {
//        AF.request(imageURL, method:  .get).validate().responseData{ response in
//            switch response.result{
//            case .success(let data):
//                      //decode data
//                if let image = UIImage(data:data){
//                    completion(image)
//
//                } else {
//                    print("Invalid image data")
//                }
//
//
//                  case .failure(let error):
//                      print(error.localizedDescription)
//            }
//        }
//    }
}
