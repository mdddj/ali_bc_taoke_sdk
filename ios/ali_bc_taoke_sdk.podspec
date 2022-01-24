#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ali_bc_taoke_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ali_bc_taoke_sdk'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'mtopSDK', '3.0.0.5'
  s.dependency 'securityGuard', '5.4.191'
  s.dependency 'BCUserTrack', '7.2.0.7-BC4'
  s.dependency 'AliAuthSDK', '1.1.0.42-BC3'
  s.dependency 'AliLinkPartnerSDK', '4.0.0.24-wk'
  s.dependency 'MunionBcAdSDK', '1.0.5'
  s.dependency 'AlibcTradeUltimateSDK', '5.0.0.7'
  s.dependency 'Masonry'
  s.dependency 'AlibcTradeUltimateSDK/MiniApp', '5.0.0.7'
  s.dependency 'WindVane', '8.5.0.46-bc11'
  s.dependency 'WindMix', '1.0.4-BC1'
  s.dependency 'Ariver', '1.0.11.2-BC5'
  s.dependency 'Triver', '1.0.11.5-BC15'
  s.dependency 'Triver/LivePlayer', '1.0.11.5-BC15'
  s.dependency 'Windmill', '1.3.7.3-BC2'
  s.dependency 'TBMediaPlayer', '2.0.7.70-BC'
  s.dependency 'miniAppMediaSDK', '0.0.1.45-BC2'
  s.dependency 'DWInteractiveSDK', '2.0.7.54-BC'
  s.dependency 'FMDB'
  s.dependency 'Reachability'
  s.dependency 'SocketRocket'
  s.dependency 'SSZipArchive'
  s.dependency 'SDWebImage'
  s.dependency 'AlibcTradeSDK'
  s.platform = :ios, '9.0'
  

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
