//
//  HeadListViewModel.swift
//  HeadlinesApp
//
//  Created by Simanchal Pradhan on 3/6/18.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import Foundation

class HeadlineListViewModel {
    
    private (set) var headlineViewModels :[HeadLineViewModel] = [HeadLineViewModel]()
    
    init(sourceViewModel :SourceViewModel, completion :@escaping () -> ()) {
        let source = Source(sourceViewModel :sourceViewModel)
        
        Webservice().loadHeadLinesForSource(source: source) { headlines in
            self.headlineViewModels = headlines.map(HeadLineViewModel.init)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    internal func headlineAt(index :Int) -> HeadLineViewModel {
        return self.headlineViewModels[index]
    }
}

class HeadLineViewModel {
   
    var title :String
    var description :String
    
    init(headline :Headline) {
        self.title = headline.title
        self.description = headline.description
    }
}
