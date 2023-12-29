import Nuke

extension ImagePipeline.Configuration {
  public static var withMockCache: ImagePipeline.Configuration {
    var configuration = ImagePipeline.Configuration()
    
    configuration.dataCache = MockDataCache()

    return configuration
  }
}
