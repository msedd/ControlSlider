
Pod::Spec.new do |spec|
  spec.name         = 'ControlSlider'
  spec.version      = '0.5.0'
  spec.license      = { :type => 'Apache 2' }
  spec.homepage     = 'https://github.com/msedd/ControlSlider.git'
  spec.authors      = { 'Marko Seifert' => 'http://www.marko-seifert.de' }
  spec.summary      = 'Sliding UIControl for controlling IoT or home devices '
  spec.source       = { :git => 'https://github.com/msedd/ControlSlider.git'}
  spec.source_files = 'ControlSlider/*.{h,swift}'
  spec.framework    = 'Foundation'
end
