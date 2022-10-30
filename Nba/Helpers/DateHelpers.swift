//
//  DateHelpers.swift
//  Nba
//
//  Created by Samy Boussair on 01/06/2022.
//

import Foundation
// swiftlint:disable:all line_length

// Énumération personnalisée pour les trois dates différentes avec lesquelles nous pouvons travailler (Hier, aujourd'hui, demain)

enum DateCategory {
    case today
    case yesterday
    case tomorrow
}

// Extension de la date pour ajouter la fonctionnalité du jour précédent et du jour suivant
extension Date {
    var dayBefor: Date {
        return Calendar.current.date(byAdding: .day, value: -275, to: self)! // (changer -93 en -1)
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)! // (changer -90 en 1)
    }
}

// class d'assistance de date
class DateHelpers {
    // Tableau des mois utilisé dans getDateString
    static var months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    // Convertit un jour (aujourd'hui, hier ou demain) au format AAAA-MMM-JJ
    static func getDateString (day: DateCategory) -> String {
        let date: Date
        if day == DateCategory.today {
            date = Date()
        } else if day == DateCategory.tomorrow {
            date = Date().dayAfter
        } else if day == DateCategory.yesterday {
            date = Date().dayBefor
        } else {
            return ""
        }
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = months[calendar.component(.month, from: date) - 1]
        let day = calendar.component(.day, from: date)
        return "\(year)-\(month)-\(day)"
    }
}
