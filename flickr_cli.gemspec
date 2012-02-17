$spec = Gem::Specification.new do |s|
  s.name        = "flickr_cli"
  s.description = "A Command-Line tool for exploring your flickr account"
  s.version     = '0.1.1'
  s.summary     = "A Command-Line tool for exploring your flickr account"

  s.authors   = ['Stephen Schor']
  s.email     = ['beholdthepanda@gmail.com']
  s.homepage  = 'https://github.com/nodanaonlyzuul/flickr_cli'

  s.executables   =  ['flickr_cli']
  s.files         = Dir['bin/*','lib/**/*']

  # TODO: Add all the dependencies
  s.add_dependency('launchy',  '0.4.0')
  s.add_dependency('flickraw', '0.8.4')
  s.add_dependency('rmagick')

  s.rubyforge_project = 'nowarning'
end