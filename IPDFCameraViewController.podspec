Pod::Spec.new do |spec|
  spec.name         = 'IPDFCameraViewController'
  spec.version      = '0.1'
  spec.license      = 'MIT'
  spec.summary      = 'Library and simple view controllers for scanning images using the camera into PDF files'
  spec.homepage     = 'https://github.com/fsaint/IPDFCameraViewController'
  spec.author       = 'Maximilian Mackh'
  spec.source       =  :git => 'https://github.com/fsaint/IPDFCameraViewController.git', :tag => s.version.to_s
  spec.source_files = 'IPDFCameraViewController/*.{h,m,c}'
  spec.resources     = "IPDFCameraViewController/**/*.{xib,png,plist,storyboard,ttf,jpg}"
  spec.requires_arc = true
end
