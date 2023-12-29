import Nuke
import NukeImageMock
import SwiftUI

private struct ImagePipelineEnvironmentKey: EnvironmentKey {
  static let defaultValue: ImagePipeline = .init()
}

extension EnvironmentValues {
  public var imagePipeline: ImagePipeline {
    get { self[ImagePipelineEnvironmentKey.self] }
    set { self[ImagePipelineEnvironmentKey.self] = newValue }
  }
}
