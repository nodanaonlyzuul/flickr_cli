# Extental Dependencies
require 'rubygems'
require 'flickraw'
require 'net/http'
require 'cgi'
require 'launchy'
require 'highline/import'
require 'asciiart'
# Internal Libraries
require 'authentication'
require 'menu'

module FlickrCli

  def self.start_program
    HighLine.track_eof = false

    Authentication.establish_session
    Menu.main_menu
  end
end