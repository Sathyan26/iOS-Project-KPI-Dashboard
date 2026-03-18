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

//Primary model used to represent single transactins
struct Transaction: Identifiable {
    let id: UUID
    
    let type: TransactionType
    
    let amount: Double
    
    let date: Date
    
    let category: CategoryType
    
    let channel: SalesChannel
    
    var note: String? = nil
    
    var isRevenue: Bool {
        return type == .sale
    }
}
