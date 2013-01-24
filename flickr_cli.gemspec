$spec = Gem::Specification.new do |s|
  s.name        = "flickr_cli"
  s.description = "A Command-Line tool for exploring your flickr account"
  s.version     = '0.2.0'
  s.summary     = "A Command-Line tool for exploring your flickr account"

  s.authors   = ['Stephen Schor']
  s.email     = ['beholdthepanda@gmail.com']
  s.homepage  = 'https://github.com/nodanaonlyzuul/flickr_cli'

  s.executables   =  ['flickr_cli']
  s.files         = Dir['bin/*','lib/**/*']

  s.add_dependency('highline', '1.6.11')
  s.add_dependency('launchy',  '0.4.0')
  s.add_dependency('flickraw', '0.8.4')
  s.add_dependency('rmagick')

  s.add_development_dependency('pry')

  s.rubyforge_project = 'nowarning'
end
