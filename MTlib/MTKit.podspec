Pod::Spec.new do |s|

s.name         = "MTKit"
s.version      = "1.0.0"
s.summary      = "MTKitTest is a easy test."

s.description  = <<-DESC
This description is used to generate tags and improve search results;
DESC

s.homepage     = "https://github.com/MTKit/MTKit/tree/master/MTlib"
s.license      = "MIT"

s.author             = { "HaoSun" => "sunhao.private@foxmail.com" }
s.source       = { :git => "https://github.com/MTKit/MTKit/tree/master/MTlib.git", :tag => "1.0.0" }
s.source_files  = 'lib/*.{h,m}'
s.requires_arc = true
end
