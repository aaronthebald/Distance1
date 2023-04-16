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
        let item13 = SpanModel(name: "The Lake Murray Dam", length: 3.4)
        let item14 = SpanModel(name: "The Las Vegas Strip", length: 4.2)
        let item15 = SpanModel(name: "The length of the Grand Canyon", length: 277.0)
        let item16 = SpanModel(name: "The width of the Grand Canyon", length: 18.0)
        let item17 = SpanModel(name: "A 5K", length: 3.10)
        let item18 = SpanModel(name: "5 miles", length: 5.0)
        let item19 = SpanModel(name: "5.5 Miles", length: 5.5)
        let item20 = SpanModel(name: "6 Miles", length: 6.0)
        let item21 = SpanModel(name: "6.5 Miles", length: 6.5)
        let item22 = SpanModel(name: "7 Miles", length: 7.0)
        let item23 = SpanModel(name: "7.5 Miles", length: 7.5)
        let item24 = SpanModel(name: "8 Miles", length: 8.0)
        let item25 = SpanModel(name: "8.5 Miles", length: 8.5)
        let item26 = SpanModel(name: "9 Miles", length: 9.0)
        let item27 = SpanModel(name: "9.5 Miles", length: 9.5)
        let item28 = SpanModel(name: "10 Miles", length: 10.0)
        
        
        
        let itemsArray = [ item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14, item15, item16, item17, item18, item19, item20, item21, item22, item23, item24, item25, item26, item27, item28]
        return itemsArray
    }
}
