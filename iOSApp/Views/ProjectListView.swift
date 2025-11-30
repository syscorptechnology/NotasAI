import SwiftUI

struct ProjectListView<Destination: View>: View {
    let projects: [Project]
    let destination: (Project) -> Destination

    var body: some View {
        List(projects) { project in
            NavigationLink(value: project) {
                ProjectRow(project: project)
            }
            .navigationDestination(for: Project.self) { project in
                destination(project)
            }
        }
    }
}

private struct ProjectRow: View {
    let project: Project

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(project.name)
                    .font(.headline)
                Spacer()
                Text("\(Int(project.progress * 100))%")
                    .font(.caption)
                    .padding(6)
                    .background(Capsule().fill(Color.blue.opacity(0.1)))
            }
            Text(project.client)
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                Label(project.location, systemImage: "mappin.and.ellipse")
                Spacer()
                Label(project.responsible.name, systemImage: "person.fill")
            }
            .font(.caption)
            ProgressView(value: project.progress)
                .tint(.blue)
        }
        .padding(.vertical, 6)
    }
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView(projects: MockDataService.shared.projects, destination: { _ in Text("Detalle") })
    }
}
