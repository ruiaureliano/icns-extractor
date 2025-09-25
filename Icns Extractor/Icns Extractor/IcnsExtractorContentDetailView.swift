import SwiftUI
import UniformTypeIdentifiers

struct IcnsExtractorContentDetailView: View {

	@Binding var selected: Item?

	var body: some View {
		VStack {
			if let selected {
				Image(nsImage: selected.image)
					.resizable()
					.interpolation(.high)
					.aspectRatio(contentMode: .fit)
					.frame(width: 512, height: 512)
					.padding()
			}
		}
		.frame(minWidth: 600, minHeight: 600)
		.toolbar {
			if let selected {
				ToolbarItem(placement: .automatic) {
					Spacer()
				}
				ToolbarItem(placement: .automatic) {
					Button {
						let panel = NSSavePanel()
						panel.allowedContentTypes = [.icns]
						panel.nameFieldStringValue = "\(selected.title).icns"
						panel.begin { response in
							if response == .OK, let url = panel.url {
								do {
									try selected.image.writeIcns(to: url)
								} catch {
								}
							}
						}
					} label: {
						Image(systemName: "square.and.arrow.up")
					}
				}
			}
		}
	}
}
