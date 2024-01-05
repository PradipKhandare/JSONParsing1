//
//  ApiManager.swift
//  JSONApiParsing1
//
//  Created by NTS on 05/01/24.


import Foundation

protocol DataManagerDelegate {
    func didDisplayData(_ apiManager: ApiManager, apiDataCondition: ApiDataConditions)
}

struct ApiManager
{
    
    var delegate: DataManagerDelegate?
    let apiUrl = "https://jsonplaceholder.typicode.com/todos/"
    
    func fetchData(id: Int){
        let url = "\(apiUrl)/\(id)"
        parseData(with: url)
    }
    
    func parseData(with url: String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safedata = data {
                    if let jsonData = self.performRequest(with: safedata){
                        self.delegate?.didDisplayData(self, apiDataCondition: jsonData)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func performRequest(with data: Data) -> ApiDataConditions?{
        let decoder = JSONDecoder()
        do{
            let jsonData = try decoder.decode(ApiDataModel.self, from: data)
            let userId = jsonData.userId
            let id = jsonData.id
            let title = jsonData.title
            let allData = ApiDataConditions(userId: userId, id: id, title: title)
            return allData
        }catch{
            print(error)
            return nil
        }
    }
}
