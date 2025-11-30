import Foundation

@MainActor
final class TaskDetailViewModel: ObservableObject {
    @Published private(set) var task: Task
    @Published var newComment: String = ""
    private let onUpdate: (Task) -> Void

    init(task: Task, onUpdate: @escaping (Task) -> Void) {
        self.task = task
        self.onUpdate = onUpdate
    }

    func updateStatus(_ status: Task.Status) {
        task.status = status
        if status == .completed {
            task.progress = 1
        }
        onUpdate(task)
    }

    func updateProgress(_ progress: Double) {
        task.progress = progress
        if progress >= 1 { task.status = .completed }
        onUpdate(task)
    }

    func addComment(author: UserSummary) {
        guard !newComment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let comment = Comment(id: UUID(), author: author, message: newComment, date: Date())
        task.comments.append(comment)
        newComment = ""
        onUpdate(task)
    }

    func addPhotoAttachment(by author: UserSummary) {
        let sampleURL = URL(string: "https://picsum.photos/200")!
        let attachment = PhotoAttachment(id: UUID(), url: sampleURL, uploadedBy: author, date: Date())
        task.photos.append(attachment)
        onUpdate(task)
    }
}
