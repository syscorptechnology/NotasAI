import SwiftUI

struct TaskDetailView: View {
    @StateObject private var viewModel: TaskDetailViewModel
    let project: Project

    init(task: Task, project: Project, onUpdate: @escaping (Task) -> Void = { _ in }) {
        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task, onUpdate: onUpdate))
        self.project = project
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(viewModel.task.title)
                            .font(.title2)
                            .bold()
                        Spacer()
                        StatusChip(text: label(for: viewModel.task.status), color: color(for: viewModel.task.status))
                    }
                    Text(viewModel.task.description)
                        .foregroundStyle(.secondary)
                }

                GroupBox("Información") {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Responsable: \(viewModel.task.responsible.name)", systemImage: "person.fill")
                        Label("Inicio: \(viewModel.task.startDate.formatted(date: .abbreviated, time: .omitted))", systemImage: "calendar")
                        Label("Vence: \(viewModel.task.dueDate.formatted(date: .abbreviated, time: .omitted))", systemImage: "clock")
                        Label("Prioridad: \(viewModel.task.priority.rawValue.capitalized)", systemImage: "flag.fill")
                    }
                }

                GroupBox("Progreso") {
                    VStack(alignment: .leading, spacing: 12) {
                        Slider(value: Binding(
                            get: { viewModel.task.progress },
                            set: { viewModel.updateProgress($0) }
                        ), in: 0...1)
                        Text("Avance: \(Int(viewModel.task.progress * 100))%")
                        Picker("Estado", selection: Binding(
                            get: { viewModel.task.status },
                            set: { viewModel.updateStatus($0) }
                        )) {
                            ForEach(Task.Status.allCases, id: \.self) { status in
                                Text(label(for: status)).tag(status)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }

                GroupBox("Adjuntos fotográficos") {
                    VStack(alignment: .leading, spacing: 12) {
                        if viewModel.task.photos.isEmpty {
                            ContentUnavailableView("Sin fotos", systemImage: "photo", description: Text("Agrega evidencia desde obra"))
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(viewModel.task.photos) { photo in
                                        VStack(alignment: .leading, spacing: 6) {
                                            AsyncImage(url: photo.url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(.secondary.opacity(0.2))
                                                    .overlay(Image(systemName: "photo"))
                                            }
                                            .frame(width: 140, height: 90)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            Text(photo.uploadedBy.name)
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                            Text(photo.date, style: .date)
                                                .font(.caption2)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                        }

                        Button {
                            viewModel.addPhotoAttachment(by: project.responsible)
                        } label: {
                            Label("Adjuntar foto de referencia", systemImage: "paperclip")
                        }
                        .buttonStyle(.bordered)
                    }
                }

                GroupBox("Comentarios") {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.task.comments) { comment in
                            HStack {
                                if comment.author.id == project.responsible.id { Spacer() }
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(comment.author.name)
                                            .bold()
                                        Text(comment.date, style: .time)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    Text(comment.message)
                                        .padding(10)
                                        .background(comment.author.id == project.responsible.id ? Color.blue.opacity(0.15) : Color.gray.opacity(0.12))
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                if comment.author.id != project.responsible.id { Spacer() }
                            }
                        }
                        Divider()
                        HStack {
                            TextField("Añadir comentario", text: $viewModel.newComment)
                            Button(action: {
                                viewModel.addComment(author: project.responsible)
                            }) {
                                Image(systemName: "paperplane.fill")
                            }
                            .disabled(viewModel.newComment.isEmpty)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Detalle")
    }

    private func label(for status: Task.Status) -> String {
        switch status {
        case .pending: "Pendiente"
        case .inProgress: "En progreso"
        case .completed: "Finalizada"
        }
    }

    private func color(for status: Task.Status) -> Color {
        switch status {
        case .pending: .gray
        case .inProgress: .blue
        case .completed: .green
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskDetailView(task: MockDataService.shared.projects.first!.tasks.first!, project: MockDataService.shared.projects.first!)
        }
    }
}
