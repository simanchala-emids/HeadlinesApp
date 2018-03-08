//
//  Webservice.swift
//  HeadlinesApp
//
//  Created by Simanchal Pradhan on 3/5/18.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import Foundation

class Webservice {
    
    func loadHeadLinesForSource(source :Source, completion :@escaping ([Headline]) -> ()) {
        var headlines = [Headline]()
        
        // get the headlines by source
        let url = URL(string :"https://newsapi.org/v2/top-headlines?sources=\(source.id)&apiKey=0cf790498275413a9247f8b94b3843fd")!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dictionary = json as! [String:Any]
                let headlineDictionaries = dictionary["articles"] as! [[String:Any]]
                
                headlines = headlineDictionaries.flatMap(Headline.init)
                DispatchQueue.main.async {
                    completion(headlines)
                }
            }
        }.resume()
    }
    
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
