# Extental Dependencies
require 'rubygems'
require 'highline/import'
require 'asciiart'
require 'flickr_authentication'

# Internal Libraries
require 'menu'

module FlickrCli

  def self.start_program
    HighLine.track_eof = false

    fa = FlickrAuthentication.new(key: 'e8505c88feb2c0cc9d2da6bcbe18767c', shared_secret: 'd344de362ea86f0e', auth_file: File.join(Dir.home, ".flickr_clirc"))
    fa.authenticate

    # Authentication.establish_session
    Menu.main_menu
  end
end