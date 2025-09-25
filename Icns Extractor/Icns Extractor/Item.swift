import AppKit
import SwiftUI
import UniformTypeIdentifiers

enum ItemType: String, CaseIterable {
    case core
    case devices
    case documents
    case images
    case audio
    case video
    case archives
    case code
    case other
    case custom
    case folders
    case files

    var image: Image {
        switch self {
        case .core:
            return Image(systemName: "gearshape")
        case .documents:
            return Image(systemName: "doc.text")
        case .devices:
            return Image(systemName: "opticaldiscdrive")
        case .images:
            return Image(systemName: "photo")
        case .audio:
            return Image(systemName: "waveform")
        case .video:
            return Image(systemName: "film")
        case .archives:
            return Image(systemName: "archivebox")
        case .code:
            return Image(systemName: "chevron.left.forwardslash.chevron.right")
        case .other:
            return Image(systemName: "questionmark.circle")
        case .custom:
            return Image(systemName: "star")
        case .folders:
            return Image(systemName: "folder")
        case .files:
            return Image(systemName: "doc")
        }
    }
}

struct Item: Identifiable, Hashable {

    var id = UUID()
    var image: NSImage
    var title: String
    var type: ItemType = .custom

    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Item {
    static var items: [Item] {
        return [
            /* CORE */
            Item(image: NSWorkspace.shared.icon(for: .content), title: "Content", type: .core),
            Item(image: NSWorkspace.shared.icon(for: .directory), title: "Directory", type: .core),
            Item(image: NSWorkspace.shared.icon(for: .bundle), title: "Bundle", type: .core),
            Item(image: NSWorkspace.shared.icon(for: .applicationBundle), title: "Application Bundle", type: .core),
            Item(image: NSWorkspace.shared.icon(for: .unixExecutable), title: "Unix Executable", type: .core),
            Item(image: NSWorkspace.shared.icon(for: .systemPreferencesPane), title: "System Preferences Pane", type: .core),

            /* DOCUMENTS */
            Item(image: NSWorkspace.shared.icon(for: .plainText), title: "Plain Text", type: .documents),
            Item(image: NSWorkspace.shared.icon(for: .utf8PlainText), title: "UTF-8 Plain Text", type: .documents),
            Item(image: NSWorkspace.shared.icon(for: .utf16PlainText), title: "UTF-16 Plain Text", type: .documents),
            Item(image: NSWorkspace.shared.icon(for: .rtf), title: "RTF", type: .documents),
            Item(image: NSWorkspace.shared.icon(for: .rtfd), title: "RTFD", type: .documents),
            Item(image: NSWorkspace.shared.icon(for: .html), title: "HTML", type: .documents),
            Item(image: NSWorkspace.shared.icon(for: .xml), title: "XML", type: .documents),
            Item(image: NSWorkspace.shared.icon(for: .yaml), title: "YAML", type: .documents),
            Item(image: NSWorkspace.shared.icon(for: .json), title: "JSON", type: .documents),
            Item(image: NSWorkspace.shared.icon(for: .pdf), title: "PDF", type: .documents),
            Item(image: NSWorkspace.shared.icon(for: .log), title: "Log File", type: .documents),

            /* IMAGES */
            Item(image: NSWorkspace.shared.icon(for: .image), title: "Image", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .jpeg), title: "JPEG", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .png), title: "PNG", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .gif), title: "GIF", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .tiff), title: "TIFF", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .icns), title: "ICNS", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .ico), title: "ICO", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .bmp), title: "BMP", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .svg), title: "SVG", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .heic), title: "HEIC", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .heif), title: "HEIF", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .rawImage), title: "RAW Image", type: .images),
            Item(image: NSWorkspace.shared.icon(for: .webP), title: "WebP", type: .images),

            /* AUDIO */
            Item(image: NSWorkspace.shared.icon(for: .audio), title: "Audio File", type: .audio),
            Item(image: NSWorkspace.shared.icon(for: .mp3), title: "MP3 Audio", type: .audio),
            Item(image: NSWorkspace.shared.icon(for: .wav), title: "WAV Audio", type: .audio),
            Item(image: NSWorkspace.shared.icon(for: .aiff), title: "AIFF Audio", type: .audio),
            Item(image: NSWorkspace.shared.icon(for: .midi), title: "MIDI Sequence", type: .audio),
            Item(image: NSWorkspace.shared.icon(for: .appleProtectedMPEG4Audio), title: "Apple Protected M4P", type: .audio),

            /* VIDEO */
            Item(image: NSWorkspace.shared.icon(for: .movie), title: "Movie", type: .video),
            Item(image: NSWorkspace.shared.icon(for: .video), title: "Video", type: .video),
            Item(image: NSWorkspace.shared.icon(for: .mpeg4Movie), title: "MPEG-4 Movie", type: .video),
            Item(image: NSWorkspace.shared.icon(for: .quickTimeMovie), title: "QuickTime Movie", type: .video),
            Item(image: NSWorkspace.shared.icon(for: .avi), title: "AVI", type: .video),
            Item(image: NSWorkspace.shared.icon(for: .mpeg), title: "MPEG", type: .video),

            /* ARCHIVES */
            Item(image: NSWorkspace.shared.icon(for: .archive), title: "Archive", type: .archives),
            Item(image: NSWorkspace.shared.icon(for: .zip), title: "ZIP Archive", type: .archives),
            Item(image: NSWorkspace.shared.icon(for: .gzip), title: "GZip Archive", type: .archives),
            Item(image: NSWorkspace.shared.icon(for: .bz2), title: "Bzip2 Archive", type: .archives),
            Item(image: NSWorkspace.shared.icon(for: .appleArchive), title: "Apple Archive", type: .archives),

            /* CODE */
            Item(image: NSWorkspace.shared.icon(for: .sourceCode), title: "Source Code", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .assemblyLanguageSource), title: "Assembly Source", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .cSource), title: "C Source", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .cHeader), title: "C Header", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .cPlusPlusSource), title: "C++ Source", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .cPlusPlusHeader), title: "C++ Header", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .objectiveCSource), title: "Objective-C Source", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .objectiveCPlusPlusSource), title: "Objective-C++ Source", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .swiftSource), title: "Swift Source", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .javaScript), title: "JavaScript", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .pythonScript), title: "Python Script", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .rubyScript), title: "Ruby Script", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .phpScript), title: "PHP Script", type: .code),
            Item(image: NSWorkspace.shared.icon(for: .shellScript), title: "Shell Script", type: .code),

            /* OTHER */
            Item(image: NSWorkspace.shared.icon(for: .vCard), title: "vCard", type: .other),
            Item(image: NSWorkspace.shared.icon(for: .emailMessage), title: "Email Message", type: .other),
            Item(image: NSWorkspace.shared.icon(for: .internetLocation), title: "Internet Location", type: .other),
            Item(image: NSWorkspace.shared.icon(for: .bookmark), title: "Bookmark", type: .other),
            Item(image: NSWorkspace.shared.icon(for: .font), title: "Font", type: .other),

            // Devices
            Item(image: .hfsIcon(kGenericHardDiskIcon), title: "Hard Disk", type: .devices),
            Item(image: .hfsIcon(kGenericFloppyIcon), title: "Floppy Disk", type: .devices),
            Item(image: .hfsIcon(kGenericCDROMIcon), title: "CD-ROM", type: .devices),
            Item(image: .hfsIcon(kGenericRemovableMediaIcon), title: "Removable Media", type: .devices),
            Item(image: .hfsIcon(kGenericRAMDiskIcon), title: "RAM Disk", type: .devices),
            Item(image: .hfsIcon(kComputerIcon), title: "Computer", type: .devices),
            Item(image: .hfsIcon(kGenericFileServerIcon), title: "File Server", type: .devices),
            Item(image: .hfsIcon(kGenericNetworkIcon), title: "Network", type: .devices),

            // Folders
            Item(image: .hfsIcon(kGenericFolderIcon), title: "Folder", type: .folders),
            Item(image: .hfsIcon(kOpenFolderIcon), title: "Open Folder", type: .folders),
            Item(image: .hfsIcon(kDropFolderIcon), title: "Drop Folder", type: .folders),
            Item(image: .hfsIcon(kMountedFolderIcon), title: "Mounted Folder", type: .folders),
            Item(image: .hfsIcon(kSharedFolderIcon), title: "Shared Folder", type: .folders),
            Item(image: .hfsIcon(kSystemFolderIcon), title: "System Folder", type: .folders),
            Item(image: .hfsIcon(kApplicationsFolderIcon), title: "Applications Folder", type: .folders),
            Item(image: .hfsIcon(kDocumentsFolderIcon), title: "Documents Folder", type: .folders),
            Item(image: .hfsIcon(kPreferencesFolderIcon), title: "Preferences Folder", type: .folders),
            Item(image: .hfsIcon(kExtensionsFolderIcon), title: "Extensions Folder", type: .folders),
            Item(image: .hfsIcon(kFontsFolderIcon), title: "Fonts Folder", type: .folders),
            Item(image: .hfsIcon(kUtilitiesFolderIcon), title: "Utilities Folder", type: .folders),
            Item(image: .hfsIcon(kUsersFolderIcon), title: "Users Folder", type: .folders),
            Item(image: .hfsIcon(kDesktopIcon), title: "Desktop", type: .folders),

            // Files
            Item(image: .hfsIcon(kGenericDocumentIcon), title: "Document", type: .files),
            Item(image: .hfsIcon(kGenericApplicationIcon), title: "Application", type: .files),
            Item(image: .hfsIcon(kGenericPreferencesIcon), title: "Preferences", type: .files),
            Item(image: .hfsIcon(kGenericQueryDocumentIcon), title: "Query Document", type: .files),
            Item(image: .hfsIcon(kGenericStationeryIcon), title: "Stationery", type: .files),
            Item(image: .hfsIcon(kGenericExtensionIcon), title: "Extension", type: .files),
            Item(image: .hfsIcon(kGenericDeskAccessoryIcon), title: "Desk Accessory", type: .files),
            Item(image: .hfsIcon(kGenericSuitcaseIcon), title: "Suitcase", type: .files),

            // Trash
            Item(image: .hfsIcon(kTrashIcon), title: "Trash (Empty)", type: .other),
            Item(image: .hfsIcon(kFullTrashIcon), title: "Trash (Full)", type: .other),

            // Internet
            Item(image: .hfsIcon(kInternetLocationHTTPIcon), title: "HTTP Location", type: .other),
            Item(image: .hfsIcon(kInternetLocationFTPIcon), title: "FTP Location", type: .other),
            Item(image: .hfsIcon(kInternetLocationMailIcon), title: "Mail Location", type: .other),
            Item(image: .hfsIcon(kInternetLocationNewsIcon), title: "News Location", type: .other),
            Item(image: .hfsIcon(kInternetLocationGenericIcon), title: "Internet Location", type: .other),

            // Toolbar
            Item(image: .hfsIcon(kToolbarCustomizeIcon), title: "Toolbar Customize", type: .other),
            Item(image: .hfsIcon(kToolbarDeleteIcon), title: "Toolbar Delete", type: .other),
            Item(image: .hfsIcon(kToolbarFavoritesIcon), title: "Toolbar Favorites", type: .other),
            Item(image: .hfsIcon(kToolbarHomeIcon), title: "Toolbar Home", type: .other),
            Item(image: .hfsIcon(kToolbarInfoIcon), title: "Toolbar Info", type: .other),

            // Alerts
            Item(image: .hfsIcon(kAlertNoteIcon), title: "Alert Note", type: .other),
            Item(image: .hfsIcon(kAlertCautionIcon), title: "Alert Caution", type: .other),
            Item(image: .hfsIcon(kAlertStopIcon), title: "Alert Stop", type: .other),
        ]
    }
}
