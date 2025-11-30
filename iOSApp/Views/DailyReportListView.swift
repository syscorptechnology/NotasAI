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
                HStack {
                    Label {
                        Text(Date(), style: .date)
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.caption)
                    Spacer()
                    Label("Se notificará a \(project.responsible.name)", systemImage: "bell")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.attachedPhotos) { photo in
                            AsyncImage(url: photo.url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(alignment: .bottomLeading) {
                                Label(photo.uploadedBy.name, systemImage: "person.fill")
                                    .font(.caption2)
                                    .padding(6)
                                    .background(.ultraThinMaterial, in: Capsule())
                                    .padding(4)
                            }
                        }
                        Button {
                            viewModel.addPhotoAttachment()
                        } label: {
                            Label("Añadir foto", systemImage: "camera.fill")
                                .frame(width: 110, height: 80)
                                .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(.vertical, 4)
                }
                Button("Guardar parte") {
                    viewModel.saveReport()
                }
                .disabled(viewModel.summary.isEmpty)
            }
            if let notification = viewModel.lastNotification {
                Section {
                    Label(notification, systemImage: "bell.badge")
                        .foregroundStyle(.green)
                }
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
                        if !report.photos.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(report.photos) { photo in
                                        AsyncImage(url: photo.url) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 80, height: 80)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .overlay(alignment: .bottomTrailing) {
                                            Label(photo.uploadedBy.name, systemImage: "person.fill")
                                                .font(.caption2)
                                                .padding(4)
                                                .background(.ultraThinMaterial, in: Capsule())
                                                .padding(4)
                                        }
                                    }
                                }
                            }
                        }
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
