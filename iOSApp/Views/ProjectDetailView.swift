import SwiftUI

struct ProjectDetailView: View {
    let project: Project

    var body: some View {
        List {
            Section("Resumen") {
                VStack(alignment: .leading, spacing: 8) {
                    Text(project.name)
                        .font(.title3)
                        .bold()
                    Text("Cliente: \(project.client)")
                    Text("Ubicación: \(project.location)")
                    Text("Responsable: \(project.responsible.name)")
                    ProgressView("Progreso general", value: project.progress)
                        .tint(.blue)
                }
            }

            Section("Módulos") {
                NavigationLink(destination: TaskListView(project: project)) {
                    Label("Tareas", systemImage: "checklist")
                }
                NavigationLink(destination: DailyReportListView(project: project)) {
                    Label("Parte diario", systemImage: "calendar.badge.clock")
                }
                NavigationLink(destination: DocumentListView(viewModel: DocumentListViewModel(documents: project.documents))) {
                    Label("Documentos", systemImage: "doc.text")
                }
            }
        }
        .navigationTitle("Proyecto")
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProjectDetailView(project: MockDataService.shared.projects.first!)
        }
    }
}
