import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("NotasAI")
                .font(.largeTitle)
                .bold()

            VStack(alignment: .leading, spacing: 12) {
                TextField("Correo", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))

                SecureField("Contraseña", text: $viewModel.password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.footnote)
                }

                Button(action: viewModel.login) {
                    Text("Iniciar sesión")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.email.isEmpty || viewModel.password.isEmpty ? Color.gray.opacity(0.3) : Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
