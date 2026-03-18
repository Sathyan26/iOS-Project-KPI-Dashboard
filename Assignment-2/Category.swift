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

//Shows if transaction is a sale or an expense
enum TransactionType {
    case sale
    case expense
}

//Shows the category with which the transaction came to be about
enum CategoryType: String, CaseIterable {
    case food
    case retail
    case marketing
    case utilities
    case services
}

//Shows whether or no a transaction occured online or in store
enum SalesChannel: String {
    case online
    case inStore
}
