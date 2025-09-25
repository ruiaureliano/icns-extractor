import SwiftUI

struct IcnsExtractorContentSideView: View {

    @Binding var items: [Item]
    @Binding var selected: Item?
    @State private var collapsedSections: Set<ItemType> = Set(ItemType.allCases)
    @State private var search: String = ""

    var body: some View {
        VStack {
            if items.isEmpty {
                VStack(spacing: 12) {
                    Text("Click + to add")
                        .font(.title)
                        .foregroundStyle(.secondary)

                    Image(systemName: "arrow.down.left")
                        .font(.system(size: 64))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(selection: $selected) {
                    if search.isEmpty {
                        ForEach(ItemType.allCases, id: \.self) { type in
                            let sectionItems = items.filter { $0.type == type }.sorted(by: { $0.title < $1.title })
                            if !sectionItems.isEmpty {
                                Section {
                                    DisclosureGroup(
                                        isExpanded: .init(
                                            get: { !collapsedSections.contains(type) },
                                            set: { expanded in
                                                if expanded {
                                                    collapsedSections.remove(type)
                                                } else {
                                                    collapsedSections.insert(type)
                                                }
                                            }
                                        ),
                                        content: {
                                            ForEach(sectionItems, id: \.id) { item in
                                                itemRow(item)
                                            }
                                        },
                                        label: {
                                            HStack(spacing: 6) {
                                                type.image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 20, height: 20)
                                                Text(type.rawValue.capitalized)
                                                Spacer()
                                            }
                                        }
                                    )
                                }
                            }
                        }
                    } else {
                        ForEach(filteredItems, id: \.id) { item in
                            itemRow(item)
                        }
                    }
                }
                .listStyle(.sidebar)
                .searchable(text: $search, prompt: "Search")
                // 🔑 Clear selection if search removes it
                .onChange(of: search) { _ in
                    if let selected, !filteredItems.contains(where: { $0.id == selected.id }) {
                        self.selected = nil
                    }
                }
            }

            Spacer()

            HStack {
                Button {
                    let panel = NSOpenPanel()
                    panel.title = "Add a App, File or Folder ..."
                    panel.allowsMultipleSelection = false
                    panel.canChooseFiles = true
                    panel.canChooseDirectories = true

                    if let window = NSApp.keyWindow {
                        panel.beginSheetModal(for: window) { response in
                            if response == .OK, let url = panel.urls.first {
                                let image = NSWorkspace.shared.icon(forFile: url.path)
                                let title = url.lastPathComponent
                                items.append(Item(image: image, title: title, type: .custom))
                            }
                        }
                    } else {
                        let response = panel.runModal()
                        if response == .OK, let url = panel.urls.first {
                            let image = NSWorkspace.shared.icon(forFile: url.path)
                            let title = url.lastPathComponent
                            items.append(Item(image: image, title: title, type: .custom))
                        }
                    }
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 24, height: 24)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderless)
                Spacer()
            }
            .padding(10)
        }
    }

    private var filteredItems: [Item] {
        items.filter { $0.title.localizedCaseInsensitiveContains(search) }
    }

    private func itemRow(_ item: Item) -> some View {
        HStack {
            Image(nsImage: item.image)
            Text(item.title)
        }
        .contentShape(Rectangle())
        .tag(item)
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                items.removeAll { $0.id == item.id }
                if selected?.id == item.id {
                    selected = nil
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
