module FlickrCli
  module Authentication
    def self.establish_session
      auth_file               = File.expand_path("~/.flick_airliftrc")
      FlickRaw.api_key        = "d4d152785af1b0ea68a5a2d173c75707"
      FlickRaw.shared_secret  = "b9da0b4f99507dd0"

      if File.exists?(auth_file)
        puts "authenticating thought #{auth_file}"
        data = YAML.load_file(auth_file)
        auth = flickr.auth.checkToken :auth_token => data["api_token"]
      else
        frob                    = flickr.auth.getFrob
        auth_url                = FlickRaw.auth_url :frob => frob, :perms => "write"

        puts " "
        puts "opening your browser..."
        sleep 1
        puts "Come back and press Enter when you are finished"
        sleep 2
        Launchy.open(auth_url)

        STDIN.getc

        # Authentication
        auth  = flickr.auth.getToken :frob => frob
        login = flickr.test.login

        puts auth.token

        require 'yaml'
        data = {}
        data["api_token"] = auth.token
        File.open(auth_file, "w"){|f| YAML.dump(data, f) }
      end
    end
  end
end