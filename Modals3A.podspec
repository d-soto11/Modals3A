Pod::Spec.new do |s|

s.name         = "Modals3A"
s.version      = "0.4.0"
s.summary      = "CocoaPod for 3A's (Tres Astronautas) custom alerts and modals."
s.requires_arc = true

s.description  = <<-DESC
Library for modal and alert views customaziable developed for 3A.
DESC

s.homepage     = "https://github.com/d-soto11/Modals3A"
# s.screenshots  = "https://i.imgflip.com/1wllsm.gif", "https://i.imgflip.com/1wlkxn.gif"

s.license      = { :type => "MIT", :file => "LICENSE" }

s.author             = { "Daniel Soto" => "soto@tresastronautas.com" }
# Or just: s.author    = "Daniel Soto"
# s.authors            = { "Daniel Soto" => "d.soto11@uniandes.edu.co" }

s.platform     = :ios, "9.0"

s.source       = { :git => "https://github.com/d-soto11/Modals3A.git", :tag => "#{s.version}" }

s.framework = "UIKit"
s.dependency 'JModalController'

s.source_files  = "Modals3A", "Modals3A/**/*.{swift}"
s.resource_bundles = { 'Modals3A' => ['Modals3A/**/*.{xib,xcassets,storyboard}'] }

# s.resources = "Modals3A/*.png"
end
