import SwiftUI

struct RootView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var projectsViewModel: ProjectsViewModel

    var body: some View {
        NavigationStack {
            ProjectListView(projects: projectsViewModel.projects) { project in
                ProjectDetailView(project: project)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar sesión") {
                        authViewModel.logout()
                    }
                }
            }
            .navigationTitle("Proyectos")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(AuthViewModel())
            .environmentObject(ProjectsViewModel())
    }
}
