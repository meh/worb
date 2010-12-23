Kernel.load 'lib/worb/version.rb'

Gem::Specification.new {|s|
    s.name         = 'worb'
    s.version      = Worb.version
    s.author       = 'meh.'
    s.email        = 'meh@paranoici.org'
    s.homepage     = 'http://github.com/meh/worb'
    s.platform     = Gem::Platform::RUBY
    s.summary      = 'Analyze text and stuff'
    s.files        = Dir.glob('lib/**/*.rb')
    s.require_path = 'lib'
    s.has_rdoc     = false
}
