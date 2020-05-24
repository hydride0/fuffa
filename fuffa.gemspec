Kernel.load 'lib/fuffa/version.rb'

Gem::Specification.new { |s|
  s.name         = 'fuffa'
  s.version      = Fuffa::VERSION
  s.author       = 'hydride0'
  s.email        = 'lol@lol.com'
  s.homepage     = 'https://github.com/hydride0/fuffa'
  s.platform     = Gem::Platform::RUBY
  s.summary      = 'Not really useful, seriously'
  s.description  = 'The fuzzer nobody needed'
  s.files        = Dir.glob('lib/**/*')
  s.require_path = 'lib'
  s.executables  = 'fuffa'
  s.license      = 'Nonstandard'

  s.add_dependency 'terminal-table', '~> 1.8'
}
