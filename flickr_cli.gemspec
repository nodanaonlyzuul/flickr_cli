$spec = Gem::Specification.new do |s|
  s.name        = "flickr_cli"
  s.description = "A Command-Line tool for exploring your flickr account"
  s.version     = '0.2.5'
  s.summary     = "A Command-Line tool for exploring your flickr account"

  s.authors   = ['Stephen Schor']
  s.email     = ['beholdthepanda@gmail.com']
  s.homepage  = 'https://github.com/nodanaonlyzuul/flickr_cli'

  s.executables   =  ['flickr_cli']
  s.files         = Dir['bin/*','lib/**/*']

  s.add_dependency 'highline',              '1.6.11'
  s.add_dependency 'asciiart',              '0.2.0'
  s.add_dependency 'flickr_authentication', '0.0.4'

  s.add_development_dependency('pry')

  s.rubyforge_project = 'nowarning'
end
