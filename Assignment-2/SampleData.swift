/*
 Names {
    Alexander Cumbo: z1946909,
    Sathyan Asokan Geethpriya: z1976271
}
 
 File Descriptions {
    Transaction.swift: "Primary model used to represent single transactions",
    Category.swift: "Enums to define types that represent categories or transaction types for a transaction",
    DataState.swift: "Enum to represent the state of the data when being loaded",
    SampleData.swift: "Contains 5 sets of sample transactional data"
 }
 
*/

import Foundation

//Sample transaction data for testing
extension Transaction {
    static let sampleData: [Transaction] = [
        Transaction(
            id: UUID(),
            type: .sale,
            amount: 143.21,
            date: Date(),
            category: .retail,
            channel: .online,
            note: "Order #42069"
        ),
        Transaction(
            id: UUID(),
            type: .sale,
            amount: 789.00,
            date: Date(),
            category: .food,
            channel: .inStore,
            note: "Gold Steak"
        ),
        Transaction(
            id: UUID(),
            type: .sale,
            amount: 77777.77,
            date: Date(),
            category: .services,
            channel: .inStore,
            note: "Lucky Foot Massage"
        ),
        Transaction(
            id: UUID(),
            type: .expense,
            amount: 3139.12,
            date: Date(),
            category: .utilities,
            channel: .online,
            note: "Electricity"
        ),
        Transaction(
            id: UUID(),
            type: .expense,
            amount: 44444.44,
            date: Date(),
            category: .marketing,
            channel: .online,
            note: "Online Ad"
        )
    ]
}


