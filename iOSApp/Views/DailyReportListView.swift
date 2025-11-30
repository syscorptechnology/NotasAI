import SwiftUI

struct DailyReportListView: View {
    let project: Project
    @StateObject private var viewModel: DailyReportViewModel

    init(project: Project) {
        self.project = project
        _viewModel = StateObject(wrappedValue: DailyReportViewModel(project: project, author: project.responsible))
    }

    var body: some View {
        List {
            Section("Registrar día") {
                TextField("Resumen", text: $viewModel.summary)
                TextField("Mano de obra", text: $viewModel.workforce)
                TextField("Incidencias", text: $viewModel.issues)
                Button("Guardar parte") {
                    viewModel.saveReport()
                }
                .disabled(viewModel.summary.isEmpty)
            }

            Section("Histórico") {
                ForEach(viewModel.reports) { report in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(report.date, style: .date)
                                .bold()
                            Spacer()
                            Text(report.createdBy.name)
                                .font(.caption)
                        }
                        Text(report.summary)
                        if !report.issues.isEmpty {
                            Label(report.issues, systemImage: "exclamationmark.triangle")
                                .foregroundStyle(.orange)
                        }
                        Label(report.workforce, systemImage: "person.3.fill")
                            .font(.caption)
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .navigationTitle("Parte diario")
    }
}

struct DailyReportListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DailyReportListView(project: MockDataService.shared.projects.first!)
        }
    }
}
