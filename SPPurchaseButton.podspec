Pod::Spec.new do |s|
  s.name         = "SPPurchaseButton"
  s.version      = "0.1.0"
  s.summary      = "SPPurchaseButton imitates the purchase button found in apples App Store, but with an added feedback mode. Works with autolayout."
  s.homepage     = "https://github.com/akelagercrantz/SPPurchaseButton"
  s.license      = 'MIT'
  s.author       = { "Åke Lagercrantz" => "ake@spire.se" }
  s.source       = { :git => "https://github.com/akelagercrantz/SPPurchaseButton.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'SPPurchaseButton'

end
