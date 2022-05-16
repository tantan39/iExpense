//
//  ExpenseListViewModel.swift
//  iexpense
//
//  Created by Tan Tan on 5/4/22.
//

import Foundation
import Combine
import RealmSwift
import Firebase
import Resolver

struct GroupExpense: Identifiable {
    var id: UUID = UUID.init()
    
    var date: Date
    var items: [ExpenseModel]
    
    var expenseTotal: Double {
        let total = items.reduce(0) { partialResult, item in
            partialResult + item.value
        }
        return total
    }
}

enum TimeRange: Int {
    case thisMonth
    case lastMonth
    case thisYear
    case lastYear
    
    var title: String {
        switch self {
        case .thisMonth:
            return "This month"
        case .lastMonth:
            return "Last month"
        case .thisYear:
            return "This year"
        case .lastYear:
            return "Last year"
        }
    }
}

@MainActor class ExpenseListViewModel: ObservableObject {
//    @ObservedResults(ExpenseModel.self, sortDescriptor: SortDescriptor.init(keyPath: "date", ascending: false)) private var expenseModels
    @Injected var service: ExpenseLoader
    @Published private var expenseModels = []
    @Published var groupItems: [GroupExpense] = []
    @Published var filteringGroupItems: [GroupExpense] = []
    @Published var editItem: ExpenseModel?
    @Published var timeRange: TimeRange = .thisMonth
    
    private var cancellabels = Set<AnyCancellable>()
    
    var total: Double {
        let total = filteringGroupItems.reduce(0) { partialResult, group in
            partialResult + group.expenseTotal
        }
        return total
    }
    
    init() {
//        expenseModels.objectWillChange.sink { _ in
//            self.groupItems.removeAll()
//            for item in self.expenseModels {
//                if let index = self.groupItems.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: item.date) }) {
//                    self.groupItems[index].items.append(item)
//                } else {
//                    let newGroup = GroupExpense(date: item.date, items: [item])
//                    self.groupItems.append(newGroup)
//                }
//            }
//            self.timeRange = .thisMonth
//        }
//        .store(in: &cancellabels)
        Task {
            do {
                let items = try await service.fetchExpenses()
                self.groupItems.removeAll()
                for item in items {
                    if let index = self.groupItems.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: item.date) }) {
                        self.groupItems[index].items.append(item)
                    } else {
                        let newGroup = GroupExpense(date: item.date, items: [item])
                        self.groupItems.append(newGroup)
                    }
                }
                self.timeRange = .thisMonth
            } catch {
                
            }
        }
        
        $timeRange
            .dropFirst()
            .sink { range in
                print("timerange set")
            switch range {
            case .thisMonth:
                self.filteringGroupItems = self.groupItems.filter({ $0.date.isInSameMonth(as: Date()) })
            case .lastMonth:
                self.filteringGroupItems = self.groupItems.filter({ $0.date.getTime().month == Date().getTime().month - 1 })
            case .thisYear:
                self.filteringGroupItems = self.groupItems.filter({ $0.date.isInSameYear(as: Date()) })
            case .lastYear:
                self.filteringGroupItems = self.groupItems.filter({ $0.date.getTime().month == Date().getTime().year - 1 })
            }
        }
        .store(in: &cancellabels)
    }
    
    func totalExpense(by group: GroupExpense) -> String {
        let total = group.items.reduce(0) { partialResult, item in
            partialResult + item.value
        }
        
        return String(format: "$%.2f", total)
    }
}
