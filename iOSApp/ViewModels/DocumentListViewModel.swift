import Foundation

@MainActor
final class DocumentListViewModel: ObservableObject {
    @Published private(set) var documents: [Document]
    @Published var searchText: String = ""
    @Published var selectedType: Document.DocumentType? = nil

    init(documents: [Document]) {
        self.documents = documents
    }

    var filteredDocuments: [Document] {
        documents.filter { document in
            let matchesType = selectedType == nil || document.type == selectedType
            let matchesSearch = searchText.isEmpty || document.name.lowercased().contains(searchText.lowercased())
            return matchesType && matchesSearch
        }
    }
}
