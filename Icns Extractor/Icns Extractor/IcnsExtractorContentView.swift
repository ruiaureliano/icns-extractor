import SwiftUI
import UniformTypeIdentifiers

struct IcnsExtractorContentView: View {

    @State private var items: [Item] = Item.items
	@State private var selected: Item? = nil
	@State private var isTargeted: Bool = false

	var body: some View {

		NavigationSplitView {
			IcnsExtractorContentSideView(items: $items, selected: $selected)
		} detail: {
			IcnsExtractorContentDetailView(selected: $selected)
		}
		.navigationTitle(selected?.title ?? "")
		.navigationSplitViewStyle(.automatic)
		.onDrop(of: [.fileURL], isTargeted: $isTargeted) { providers in
			for provider in providers {
				if provider.hasItemConformingToTypeIdentifier("public.file-url") {
					provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { item, error in
						if let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) {
							let image = NSWorkspace.shared.icon(forFile: url.path)
							let title = url.lastPathComponent
                            items.append(Item(image: image, title: title, type: .custom))
						}
					}
				}
			}
			return true
        }
	}
}

#Preview {
	IcnsExtractorContentView()
}
