import AppKit

extension NSImage {

	static func hfsIcon(_ code: Int) -> NSImage {
		if let fileType = NSFileTypeForHFSTypeCode(OSType(code)) {
			return NSWorkspace.shared.icon(forFileType: fileType)
		} else {
			return NSImage(named: NSImage.cautionName) ?? NSImage()
		}
	}
}
