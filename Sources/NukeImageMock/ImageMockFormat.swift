import Foundation

extension URL {
  public static func imageMock(width: Double, height: Double) -> URL {
    URL(string: "size://\(width)x\(height)")!
  }

  public static func imageMock(width: Double) -> URL { imageMock(width: width, height: width) }
}
