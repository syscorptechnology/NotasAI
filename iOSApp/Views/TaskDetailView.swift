import SwiftUI

struct TaskDetailView: View {
    @StateObject private var viewModel: TaskDetailViewModel
    let project: Project

    init(task: Task, project: Project) {
        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(task: task))
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
                        HStack {
                            Button("Pendiente") { viewModel.updateStatus(.pending) }
                            Button("En progreso") { viewModel.updateStatus(.inProgress) }
                            Button("Finalizar") { viewModel.updateStatus(.completed) }
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.small)
                    }
                }

                GroupBox("Comentarios") {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.task.comments) { comment in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(comment.author.name)
                                        .bold()
                                    Spacer()
                                    Text(comment.date, style: .time)
                                        .foregroundStyle(.secondary)
                                }
                                Text(comment.message)
                            }
                            .padding(.vertical, 4)
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
