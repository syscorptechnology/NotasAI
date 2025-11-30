import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var currentUser: User?

    private let service: MockDataService

    init(service: MockDataService = .shared) {
        self.service = service
    }

    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Ingresa correo y contraseña"
            return
        }

        if let user = service.users.first(where: { $0.email.lowercased() == email.lowercased() }) {
            currentUser = user
            isAuthenticated = true
            errorMessage = nil
        } else {
            errorMessage = "Credenciales incorrectas"
            isAuthenticated = false
        }
    }

    func logout() {
        isAuthenticated = false
        currentUser = nil
        email = ""
        password = ""
    }
}
