Pod::Spec.new do |s|

  s.name             = "DualSlideMenu"
  s.version          = "0.1.1"
  s.summary          = "Swipe to the left or right for a table view"
   s.description      = "Allows the main view of an app to be clutter free by placing all the navigation and buttons in side menus that can be easily reached by swiping to the left or right"

  s.homepage         = "https://github.com/vinnyoodles/DualSlideMenu"
  s.license          = 'MIT'
  s.author           = { "Vincent Le" => "vinnyoodles@gmail.com" }
  s.source           = { :git => "https://github.com/vinnyoodles/DualSlideMenu.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DualSlideMenu' => ['Pod/Assets/*.png']
  }
end
