import Foundation

@MainActor
final class TaskDetailViewModel: ObservableObject {
    @Published private(set) var task: Task
    @Published var newComment: String = ""

    init(task: Task) {
        self.task = task
    }

    func updateStatus(_ status: Task.Status) {
        task.status = status
        if status == .completed {
            task.progress = 1
        }
    }

    func updateProgress(_ progress: Double) {
        task.progress = progress
        if progress >= 1 { task.status = .completed }
    }

    func addComment(author: UserSummary) {
        guard !newComment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let comment = Comment(id: UUID(), author: author, message: newComment, date: Date())
        task.comments.append(comment)
        newComment = ""
    }
}
