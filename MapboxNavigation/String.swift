import Foundation

extension String {
    var nonEmptyString: String? {
        return isEmpty ? nil : self
    }
    
    var wholeRange: NSRange {
        get {
            return NSRange(location: 0, length: characters.count)
        }
    }

    typealias Replacement = (of: String, with: String)

    func byReplacing(_ replacements: [Replacement]) -> String {
        return replacements.reduce(self) { $0.replacingOccurrences(of: $1.of, with: $1.with) }
    }
    
    var addingXMLEscapes: String {
        return byReplacing([
            ("&", "&amp;"),
            ("<", "&lt;"),
            ("\"", "&quot;"),
            ("'", "&apos;")
            ])
    }

    var isFreeway: Bool {
        return self.components(separatedBy: " ").filter {
            ["freeway", "expressway", "highway", "fwy", "hwy"].contains($0)
        }.isEmpty
    }
}
