#
#  Be sure to run `pod spec lint ffmpeg.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "ffmpeg"
  spec.version      = "6.1"
  spec.summary      = "A short description of ffmpeg."
  spec.description  = <<-DESC
    ffmpeg lib.
                   DESC

  spec.homepage     = "http://EXAMPLE/ffmpeg"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author       = { "yangjie" => "yangjie@puwell.com" }

  spec.ios.deployment_target = "12.0"
  spec.osx.deployment_target = "10.15"
  spec.tvos.deployment_target = "13.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "git@192.168.10.246:/home/git/iOS/ffmpeg.git", :tag => "#{spec.version}" }
  spec.source_files = "ffmpeg/include/**/*"
  spec.public_header_files = "ffmpeg/include/**/*.h"
  spec.header_mappings_dir = 'ffmpeg/include'

  spec.ios.vendored_libraries = "ffmpeg/libios/*.a"
  spec.osx.vendored_libraries = "ffmpeg/libmacos/*.a"
  spec.tvos.vendored_libraries = "ffmpeg/libtvos/*.a"

  spec.frameworks =  "Foundation", "AVFoundation", "CoreMedia", "VideoToolbox", "AudioToolbox"
  spec.libraries = "iconv", "z", 'bz2'

  spec.requires_arc = true
  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    "HEADER_SEARCH_PATHS" => "$(PODS_TARGET_SRCROOT)/ffmpeg/include/"
  }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
