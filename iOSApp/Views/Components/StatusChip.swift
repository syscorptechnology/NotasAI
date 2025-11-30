import SwiftUI

struct StatusChip: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Capsule().fill(color.opacity(0.15)))
            .foregroundColor(color)
    }
}

struct StatusChip_Previews: PreviewProvider {
    static var previews: some View {
        StatusChip(text: "En progreso", color: .blue)
    }
}
