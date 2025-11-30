import SwiftUI

struct DocumentListView: View {
    @StateObject var viewModel: DocumentListViewModel

    var body: some View {
        List {
            Section("Filtros") {
                Picker("Tipo", selection: $viewModel.selectedType) {
                    Text("Todos").tag(Document.DocumentType?.none)
                    ForEach(Document.DocumentType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized).tag(Document.DocumentType?.some(type))
                    }
                }
                TextField("Buscar", text: $viewModel.searchText)
            }

            Section("Documentos") {
                ForEach(viewModel.filteredDocuments) { document in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(document.name)
                                .bold()
                            Spacer()
                            Text(document.type.rawValue.capitalized)
                                .font(.caption)
                                .padding(6)
                                .background(Capsule().fill(Color.gray.opacity(0.2)))
                        }
                        Text("Subido el \(document.uploadDate.formatted(date: .abbreviated, time: .omitted)) por \(document.uploadedBy.name)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        if let host = document.url.host {
                            Label(host, systemImage: "link")
                                .font(.caption)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Documentos")
    }
}

struct DocumentListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DocumentListView(viewModel: DocumentListViewModel(documents: MockDataService.shared.projects.first!.documents))
        }
    }
}
