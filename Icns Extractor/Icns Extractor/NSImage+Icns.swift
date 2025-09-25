import AppKit
import ImageIO
import UniformTypeIdentifiers

extension NSImage {

	func writeIcns(to url: URL) throws {
		let sizes: [CGFloat] = [16, 32, 64, 128, 256, 512, 1024]

		guard
			let destination = CGImageDestinationCreateWithURL(url as CFURL, UTType.icns.identifier as CFString, sizes.count, nil)
		else {
			throw NSError(domain: "NSImage+Icns", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create CGImageDestination"])
		}

		for size in sizes {
			guard
				let resized = self.resized(to: NSSize(width: size, height: size)),
				let cgImage = resized.cgImage(forProposedRect: nil, context: nil, hints: nil)
			else {
				continue
			}
			CGImageDestinationAddImage(destination, cgImage, nil)
		}

		if !CGImageDestinationFinalize(destination) {
			throw NSError(domain: "NSImage+Icns", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to finalize ICNS file"])
		}
	}

	private func resized(to targetSize: NSSize) -> NSImage? {
		let newImage = NSImage(size: targetSize)
		newImage.lockFocus()
		self.draw(
			in: NSRect(origin: .zero, size: targetSize),
			from: NSRect(origin: .zero, size: self.size),
			operation: .copy,
			fraction: 1.0
		)
		newImage.unlockFocus()
		return newImage
	}
}
