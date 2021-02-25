//
//  FilteredList.swift
//  Project12
//
//  Created by Paul Hudson on 17/02/2020.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//
import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, comparisonOperator: NSComparisonPredicate.Operator = .beginsWith, sortDescriptors: [NSSortDescriptor] = [], @ViewBuilder content: @escaping (T) -> Content) {
        
        let comparisonString = NSComparisonPredicate.stringValue(for: comparisonOperator)
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(comparisonString) %@", filterKey, filterValue))
        
        self.content = content
    }
}

extension NSComparisonPredicate {
    public static func keyword( for predicateOperator: Operator) -> String {
        switch predicateOperator {
        case .lessThan:
            return "<"
        case .lessThanOrEqualTo:
            return "<="
        case .greaterThan:
            return ">"
        case .greaterThanOrEqualTo:
            return ">="
        case .equalTo:
            return "="
        case .notEqualTo:
            return "!="
        case .matches:
            return "MATCHES"
        case .like:
            return "LIKE"
        case .beginsWith:
            return "BEGINSWITH"
        case .endsWith:
            return "ENDSWITH"
        case .in:
            return "IN"
        case .customSelector:
            return "CUSTOMSELECTOR"
        case .contains:
            return "CONTAINS"
        case .between:
            return "BETWEEN"
        @unknown default:
            return ""
        }
    }
    
    public static func stringValue(for predicateOperator: Operator) -> String{
        return "\(self.keyword(for: predicateOperator))"
    }
}
