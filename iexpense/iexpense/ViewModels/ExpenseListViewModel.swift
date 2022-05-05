//
//  ExpenseListViewModel.swift
//  iexpense
//
//  Created by Tan Tan on 5/4/22.
//

import Foundation
import Combine
import RealmSwift

struct GroupExpense: Identifiable {
    var id: UUID = UUID.init()
    
    var date: Date
    var items: [ExpenseModel]
}

class ExpenseListViewModel: ObservableObject {
    @ObservedResults(ExpenseModel.self, sortDescriptor: SortDescriptor.init(keyPath: "date", ascending: false)) private var expenseModels
    @Published var groupItems: [GroupExpense] = []
    
    private var cancellabels = Set<AnyCancellable>()
    
    init() {
        expenseModels.objectWillChange.sink { _ in
            self.groupItems.removeAll()
            for item in self.expenseModels {
                if let index = self.groupItems.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: item.date) }) {
                    self.groupItems[index].items.append(item)
                } else {
                    let newGroup = GroupExpense(date: item.date, items: [item])
                    self.groupItems.append(newGroup)
                }
            }
            
        }
        .store(in: &cancellabels)
    }
}
