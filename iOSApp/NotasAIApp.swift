import SwiftUI

@main
struct NotasAIApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var projectsViewModel = ProjectsViewModel()

    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                RootView()
                    .environmentObject(authViewModel)
                    .environmentObject(projectsViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
