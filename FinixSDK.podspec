Pod::Spec.new do |s|  
    s.name              = 'FinixSDK'
    s.version           = '1.0.0'
    s.summary           = 'Finix sdk for tokenization.'
    s.homepage          = 'https://github.com/finix-payments/ios-sdk-zip'

    s.author            = { 'Name' => 'Finix Payments' }
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/finix-payments/ios-sdk-zip.git', :tag => '1.0.0' }

    s.ios.deployment_target = '10.3'
    s.ios.vendored_frameworks = 'ios-sdk-zip/FinixSDK/FinixSDK.framework'
    #s.vendored_frameworks = 'FinixSDK.framework'
end