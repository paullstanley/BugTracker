#if os(iOS)
import CloudKit
import SwiftUI
import CoreDataPlugin
import Domain

struct CloudSharingView: UIViewControllerRepresentable {
  let share: CKShare
  let container: CKContainer
  let project: ProjectDM

  func makeCoordinator() -> CloudSharingCoordinator {
    CloudSharingCoordinator(project: project)
  }

  func makeUIViewController(context: Context) -> UICloudSharingController {
    share[CKShare.SystemFieldKey.title] = project.name
    let controller = UICloudSharingController(share: share, container: container)
    controller.modalPresentationStyle = .formSheet
    controller.delegate = context.coordinator
    return controller
  }

  func updateUIViewController(_ uiViewController: UICloudSharingController, context: Context) {
  }
}

final class CloudSharingCoordinator: NSObject, UICloudSharingControllerDelegate {
  let stack = StorageProvider()
  let project: ProjectDM
  init(project: ProjectDM) {
    self.project = project
  }

  func itemTitle(for csc: UICloudSharingController) -> String? {
      project.name
  }

  func cloudSharingController(_ csc: UICloudSharingController, failedToSaveShareWithError error: Error) {
    print("Failed to save share: \(error)")
  }

  func cloudSharingControllerDidSaveShare(_ csc: UICloudSharingController) {
    print("Saved the share")
  }

  func cloudSharingControllerDidStopSharing(_ csc: UICloudSharingController) {
    if !stack.isOwner(object: project) {
     // stack.delete(project)
    }
  }
}
#endif
