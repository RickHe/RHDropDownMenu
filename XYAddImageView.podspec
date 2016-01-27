Pod::Spec.new do |s|
  s.name            = "XYAddImageView"
  s.version         = "1.0.0"
  s.summary          = "A UI component that can add and display any more images on iOS"
  s.description      = "A UI component that can add and display any more images, which implement by Objective-C"
  s.homepage         = "https://github.com/RickHe/HMYPodTest.git"
  # s.screenshots      = "nTrg38EPmY/goTuEfegLcfA3NAwyS1sk0PM1j0Gwx*M!/b/dHYBAAAAAAAA&bo=PgFLAgAAAAACeCo!&rf=viewer_4"
  s.license          = 'MIT'
  s.author           = { "何米颖" => "1292711060@qq.com" }
  s.source           = { :git => "https://github.com/RickHe/HMYPodTest.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://github.com/RickHe'

  s.platform     = :ios, '7.0'
  # s.ios.deployment_target = '7.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'XYAddImageView/*.{h,m}'
  s.resources = "XYAddImageView/Images/*.png"
  s.frameworks = 'Foundation', 'UIKit'

end
