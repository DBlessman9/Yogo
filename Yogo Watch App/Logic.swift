//
//  Logic.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/25/25.
//

import Foundation

struct currentYoga {
    var flow: String
    var time: String
    var flowCount: Int
    var heart: Double
    var calories: Double
}

//let starImage = getStarImage(starStatus: 4)
//print(starImage)

func getStarImage(starStatus: Int) -> String {
    switch starStatus {
    case 1:
        return "Star1"
    case 2:
        return "Star2"
    case 3:
        return "Star3"
    case 4:
        return "Star4"
    case 5:
        return "Star5"
    case 6:
        return "Star6"
    case 7:
        return "Star7"
    default:
        return "Star3" // Fallback in case of an unexpected value
    }
}

