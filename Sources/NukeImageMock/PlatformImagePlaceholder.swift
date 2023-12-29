import Nuke

#if !os(macOS)
  import UIKit.UIImage
#else
  import AppKit.NSImage
#endif

extension PlatformImage {
  static func placeholder(width: Double, height: Double) -> PlatformImage {
    placeholder(with: CGSize(width: width, height: height))
  }

  static func placeholder(width: Double) -> PlatformImage {
    placeholder(with: CGSize(width: width, height: width))
  }

  static func placeholder(with size: CGSize) -> PlatformImage {
    func drawPlaceholder(context: CGContext, bounds: CGRect) {
      let gray = CGColor(gray: 0.5, alpha: 1)
      let lightGray = CGColor(gray: 2 / 3, alpha: 1)

      context.setFillColor(gray)
      context.fill(bounds)
      context.setStrokeColor(lightGray)
      context.stroke(bounds)

      context.move(to: .zero)
      context.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
      context.move(to: CGPoint(x: bounds.width, y: 0))
      context.addLine(to: CGPoint(x: 0, y: bounds.height))
      context.strokePath()
    }

    #if !os(macOS)
      let renderer = UIGraphicsImageRenderer(size: size)

      return renderer.image { context in
        let bounds = renderer.format.bounds
        let cgContext = context.cgContext

        drawPlaceholder(context: cgContext, bounds: bounds)
      }
    #else
      return NSImage(size: size, flipped: false) { bounds in
        let cgContext = NSGraphicsContext.current!.cgContext

        drawPlaceholder(context: cgContext, bounds: bounds)

        return true
      }
    #endif
  }
}
