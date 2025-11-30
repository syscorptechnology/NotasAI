import SwiftUI

struct TaskListView: View {
    let project: Project
    @StateObject private var viewModel: TaskListViewModel

    init(project: Project) {
        self.project = project
        _viewModel = StateObject(wrappedValue: TaskListViewModel(project: project))
    }

    var body: some View {
        List {
            if viewModel.filteredTasks.isEmpty {
                ContentUnavailableView("Sin tareas", systemImage: "checklist.unchecked", description: Text("Crea la primera tarea para este proyecto"))
            } else {
                ForEach(viewModel.filteredTasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task, project: project) { updated in
                        viewModel.updateTask(updated)
                    }) {
                        taskRow(task)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Tareas")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    viewModel.resetDraft(for: project)
                    viewModel.isPresentingNewTask = true
                } label: {
                    Label("Nueva tarea", systemImage: "plus")
                }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Picker("Estado", selection: Binding<Task.Status?>(
                    get: { viewModel.statusFilter },
                    set: { newValue in viewModel.statusFilter = newValue }
                )) {
                    Text("Todos").tag(Task.Status?.none)
                    ForEach(Task.Status.allCases, id: \.self) { status in
                        Text(label(for: status)).tag(Optional(status))
                    }
                }
                .pickerStyle(.segmented)

                Menu {
                    Picker("Orden", selection: $viewModel.sortOption) {
                        ForEach(TaskListViewModel.SortOption.allCases, id: \.self) { option in
                            Label(title(for: option), systemImage: icon(for: option)).tag(option)
                        }
                    }
                } label: {
                    Label("Ordenar", systemImage: "arrow.up.arrow.down")
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Buscar por título, descripción o responsable")
        .sheet(isPresented: $viewModel.isPresentingNewTask) {
            NavigationStack {
                TaskCreationView(viewModel: viewModel, project: project)
            }
            .presentationDetents([.large])
        }
    }

    private func taskRow(_ task: Task) -> some View {
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

    private func title(for option: TaskListViewModel.SortOption) -> String {
        switch option {
        case .dueDate: "Fecha de vencimiento"
        case .priority: "Prioridad"
        case .status: "Estado"
        }
    }

    private func icon(for option: TaskListViewModel.SortOption) -> String {
        switch option {
        case .dueDate: return "calendar"
        case .priority: return "flag.fill"
        case .status: return "checkmark.circle"
        }
    }
}

struct TaskCreationView: View {
    @ObservedObject var viewModel: TaskListViewModel
    let project: Project

    var body: some View {
        Form {
            Section("Detalles") {
                TextField("Título *", text: $viewModel.draft.title)
                TextField("Descripción *", text: $viewModel.draft.description, axis: .vertical)
                Picker("Prioridad", selection: $viewModel.draft.priority) {
                    Text("Alta").tag(Task.Priority.high)
                    Text("Media").tag(Task.Priority.medium)
                    Text("Baja").tag(Task.Priority.low)
                }
                .pickerStyle(.segmented)
            }

            Section("Responsable") {
                Text(viewModel.draft.responsible.name)
                Text(viewModel.draft.responsible.role)
                    .foregroundStyle(.secondary)
            }

            Section("Fechas") {
                DatePicker("Inicio", selection: $viewModel.draft.startDate, displayedComponents: .date)
                DatePicker("Vence *", selection: $viewModel.draft.dueDate, in: viewModel.draft.startDate..., displayedComponents: .date)
            }

            if let validation = viewModel.validationMessage {
                Section {
                    Label(validation, systemImage: "exclamationmark.triangle.fill")
                        .foregroundStyle(.yellow)
                }
            }
        }
        .navigationTitle("Nueva tarea")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancelar") { viewModel.isPresentingNewTask = false }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Crear") {
                    if viewModel.createTask(for: project) {
                        viewModel.isPresentingNewTask = false
                    }
                }
                .buttonStyle(.borderedProminent)
            }
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
