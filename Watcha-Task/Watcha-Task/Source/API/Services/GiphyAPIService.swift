//
//  GiphyAPIService.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation

import Alamofire
import SwiftyJSON

struct GiphyAPIService {
    static let shared = GiphyAPIService()
    
    public func search(for keyword: String,
                       limit: Int = 10,
                       offset: Int = 0,
                       state: ImageState,
                       completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = state == .gif ? APIConstants.gifSearchURL : APIConstants.stickerSearchURL
        
        let parameter: Parameters = [
            "api_key" : APIConstants.key,
            "q" : keyword,
            "limit" : limit,
            "offset" : offset
        ]

        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: parameter,
                                     encoding: URLEncoding.default)
        
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                
                completion(judgeData(statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    public func fetchLikeGIFData(ids: String,
                                 limit: Int = 10,
                                 completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.gifURL
        
        let parameter: Parameters = [
            "api_key" : APIConstants.key,
            "ids" : ids
        ]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: parameter,
                                     encoding: URLEncoding.default)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                
                completion(judgeData(statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
        
    }
    
    private func judgeData(_ statusCode: Int, data: Data) -> NetworkResult<Any> {
    
        guard let decodedData = try? JSON(data: data) else {
            return .pathErr
        }
        switch statusCode {
        case 200:
            return .success(makeGIFObject(to: decodedData))
        case 400..<500:
            return .requestErr(decodedData["meta"]["msg"])
        default:
            return .pathErr
        }
    }
    
    
    private func makeGIFObject(to json: JSON) -> (Int, [GIFObject]) {
        
        let result: [GIFObject] = json["data"].arrayValue.compactMap {
            let user = $0["user"]
            let images = $0["images"]
            let sampleImage = images["fixed_width_downsampled"]
            let originalImage = images["original"]
            
            return GIFObject(id: $0["id"].stringValue,
                             title: $0["title"].stringValue,
                             userDisPlayName: user["display_name"].stringValue,
                             userName: user["username"].stringValue,
                             source: $0["source"].stringValue,
                             fixedWidthDownsampledURL: sampleImage["url"].stringValue,
                             fixedWidthDownsampledHeight: sampleImage["height"].floatValue.toCGFloat(),
                             originalURL: originalImage["url"].stringValue,
                             originalHeight: originalImage["height"].floatValue.toCGFloat())
        }
        let totalCount = json["pagination"]["total_count"].intValue
        
        return (totalCount ,result)
    }
}
