//
//  SpansServices.swift
//  Distance
//
//  Created by Aaron Wilson on 4/10/23.
//

import Foundation

class SpansServices {
    func getSpans() -> [SpanModel] {
        let item1 = SpanModel(name: "The Great Wall of China", length: 13171.00)
        let item2 = SpanModel(name: "Manhattan", length: 13.11)
        let item3 = SpanModel(name: "The English Channel", length: 21.00)
        let item4 = SpanModel(name: "The Hoover Dam", length: 0.2356061)
        let item5 = SpanModel(name: "The Golden Gate Bridge", length: 1.7)
        let item6 = SpanModel(name: "The Brooklyn Bridge", length: 1.139394)
        let item7 = SpanModel(name: "The London Bridge", length: 0.151515)
        let item8 = SpanModel(name: "Mt. Everest", length: 80.0)
        let item9 = SpanModel(name: "A Half Marathon", length: 13.1)
        let item10 = SpanModel(name: "A Full Marathon", length: 26.2188)
        let item11 = SpanModel(name: "The Great Pyramid of Giza", length: 0.5727273)
        let item12 = SpanModel(name: "The Burj Khakifa", length: 0.5155303)
        
        let itemsArray = [ item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12]
        return itemsArray
    }
}
