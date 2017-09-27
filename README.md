使用帮助:
source https://github.com/MTPodSpec/MTKitSpec.git

1. 初次使用: pod repo add MTKitSpec https://github.com/MTPodSpec/MTKitSpec.git
2. 更新: pod repo update MTKitSpec

其他常用命令: 

查看本地所有repo
pod repo list

删除某个repo
pod repo remove <REPO_NAME>

更新某个repo
pod repo update <REPO_NAME>

更新本地Spec到github仓库中
pod repo push MTKitSpec MTKit.podspec

调试中指定commit

pod 'MTKit', :git => 'https://github.com/MTKit/MTKit.git', :commit => '25e9041fb4b0c12149b4e33dc0e87f2d5615e27c'
