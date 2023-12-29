import Foundation
import Nuke

public final class MockDataCache: DataCaching, @unchecked Sendable {
  private static let sampleImageSize: Double = 500

  public init() {}

  public func cachedData(for key: String) -> Data? {
    let dimensions: [Double] = {
      if let url = URL(string: key), url.scheme == "size" {
        guard let dim = url.host?.split(separator: "x").compactMap({ Double($0) }), dim.count > 0,
          dim.count < 3, dim.allSatisfy({ $0 > 0 })
        else { fatalError("Invalid url format") }

        return dim
      } else {
        return [Self.sampleImageSize]
      }
    }()

    return
      PlatformImage.placeholder(
        width: dimensions[0],
        height: dimensions.count == 2 ? dimensions[1] : dimensions[0]
      )
      .pngData()
  }

  public func containsData(for key: String) -> Bool { true }

  public func storeData(_ data: Data, for key: String) {}

  public func removeData(for key: String) {}

  public func removeAll() {}

  public subscript(key: String) -> Data? {
    get { cachedData(for: key) }
    set { if let data = newValue { storeData(data, for: key) } else { removeData(for: key) } }
  }
}

// from: https://stackoverflow.com/a/29263098/13162032
#if os(macOS)
  import AppKit

  extension NSBitmapImageRep { var png: Data? { representation(using: .png, properties: [:]) } }

  extension Data { var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) } }

  extension NSImage { func pngData() -> Data? { tiffRepresentation?.bitmap?.png } }
#endif
