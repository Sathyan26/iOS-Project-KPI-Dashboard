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

//Shows whether the date is idle, loading, loaded, or errored
enum DataState {
    case idle
    
    case loading
    
    case loaded([Transaction])
    
    case error(String)
}
