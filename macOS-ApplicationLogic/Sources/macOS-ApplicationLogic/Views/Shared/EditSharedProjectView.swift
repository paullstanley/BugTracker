import SwiftUI
import CoreDataPlugin
import Domain

struct EditSharedProjectView: View {
  let project: ProjectDM
    private var stack = StorageProvider.shared
  private var hasInvalidData: Bool {
    return project.name.isBlank ||
      project.info.isBlank ||
    (project.name == projectName && project.info == projectDetails)
  }

  @State private var projectName: String = ""
  @State private var projectDetails: String = ""
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) var managedObjectContext

  init(project: ProjectDM) {
    self.project = project
  }

  var body: some View {
    NavigationView {
      VStack {
        VStack(alignment: .leading) {
          Text("Caption")
            .font(.caption)
            .foregroundColor(.secondary)
          TextField(text: $projectName) {}
            .textFieldStyle(.roundedBorder)
        }
        .padding(.bottom, 8)

        VStack(alignment: .leading) {
          Text("Details")
            .font(.caption)
            .foregroundColor(.secondary)
          TextEditor(text: $projectDetails)
        }
      }
      .padding()
      .navigationTitle("Edit Destination")
        #if os(iOS)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
              if let storageProviderContainer = stack.persistentContainer {
                  let context = storageProviderContainer.viewContext
                  context.performAndWait {
                      if let selectedProjectsId = UUID(uuidString: project.id)  {
                          let projectMO = ProjectMO.findOrInsert(using: selectedProjectsId, in: context)
                          projectMO.name = projectName
                          projectMO.info = projectDetails
                          do {
                              try context.save()
                          } catch {
                              
                          }
                      }
                  }
              }
           
          } label: {
            Text("Save")
          }
          .disabled(hasInvalidData)
        }
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            Text("Cancel")
          }
        }
      }
        #endif
    }
    .onAppear {
        projectName = project.name
        projectDetails = project.info
    }
  }
}

// MARK: String
extension String {
  var isBlank: Bool {
    self.trimmingCharacters(in: .whitespaces).isEmpty
  }
}
