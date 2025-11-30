import SwiftUI

struct TaskListView: View {
    let project: Project

    var body: some View {
        List(project.tasks) { task in
            NavigationLink(destination: TaskDetailView(task: task, project: project)) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(task.title)
                            .font(.headline)
                        Spacer()
                        StatusChip(text: label(for: task.status), color: color(for: task.status))
                    }
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    HStack {
                        Label(task.responsible.name, systemImage: "person.fill")
                        Spacer()
                        Label(task.dueDate, style: .date)
                    }
                    .font(.caption)
                    ProgressView(value: task.progress)
                        .tint(.blue)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Tareas")
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

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskListView(project: MockDataService.shared.projects.first!)
        }
    }
}
