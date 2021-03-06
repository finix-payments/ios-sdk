Pod::Spec.new do |s|  
    s.name              = 'PaymentsSDK'
    s.version           = '1.0.7'
    s.summary           = 'Payments sdk for tokenization.'
    s.homepage          = 'https://github.com/finix-payments/ios-sdk'

    s.swift_version     = '4.1'
    s.authors		= {'Payments Team' => ''}
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/finix-payments/ios-sdk.git', :tag => '1.0.7' }
    s.source_files      = 'src/**/*', 'src/*'
    s.ios.deployment_target = '9.0'
end
