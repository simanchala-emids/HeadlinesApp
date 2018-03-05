//
//  Webservice.swift
//  HeadlinesApp
//
//  Created by Simanchal Pradhan on 3/5/18.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import Foundation

class Webservice {
    
    func loadSources(completion: @escaping ([Source]) -> ()) {
        let sourceURL = URL(string :"https://newsapi.org/v2/sources?apiKey=0cf790498275413a9247f8b94b3843fd")!
        
        URLSession.shared.dataTask(with: sourceURL) { data, _, _ in
            var sources = [Source]()
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dictionary = json as! [String:Any]
                let sourcesDictionary = dictionary["sources"] as! [[String:Any]]

                sources = sourcesDictionary.flatMap(Source.init)
                DispatchQueue.main.async {
                    completion(sources)
                }
            }
        }.resume()
    }
}
