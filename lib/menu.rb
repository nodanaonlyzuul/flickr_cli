module FlickrCli
  module Menu

    def self.main_menu
      choose do |menu|
        menu.prompt = "What do you want to explore?"
        menu.choice("Your Photostream")       { menu_for(flickr.test.login.username) }
        menu.choice("Contacts' Photostream")  { contacts }
        menu.choice("Quit")                   { end_program }
      end
    end

    def self.menu_for(contact, page = 1)

      the_page  = page
      user_id   = flickr.people.findByUsername(:username => contact).id
      photos    = flickr.photos.search(:user_id => user_id, :page => the_page)

      choose do |menu|
        menu.prompt = "Pick a File (page #{the_page})"

        photos.map(&:title).each do |photo|
          menu.choice(photo) do
            # When you choose a photo...
            FlickrCli::Menu.download_and_print(photos.detect{|x| x.title == photo})
            puts "Press any ENTER to continue"
            do_nothing = STDIN.gets
            self.menu_for(FlickrCli::Menu.menu_for(contact, the_page))
          end
        end
        menu.choice("More >>")          { self.menu_for(contact, (the_page+1) )}
        menu.choice("Back <<")          { self.menu_for(contact, (the_page-1) )} if the_page > 1
        menu.choice("~(==::Main::==)~") { self.main_menu }
        menu.choice("Quit")             { self.end_program }
      end
    end

    def self.end_program
      say self.good_by_message
      exit
    end

    def self.download_and_print(picked_photo)

      photos       = flickr.photos.getSizes(:photo_id => picked_photo.id)
      download_url = nil

      ["Large", "Medium"].each do |style|
        if picture = photos.find{ |photo| photo.label == style }
          download_url  = picture.source
        end
        break if download_url
      end
            
      my_file = Tempfile.new("tempimage#{File.basename(download_url)}")
      my_file << Net::HTTP.get_response(URI.parse(download_url)).body
      my_file.close
      puts FlickrCli::ImageCutter.convert_to_ascii(my_file.path)
      my_file.delete
    end

    def self.good_by_message
      ["Be that way",
        "Goodbye - I'll never love again",
        "See you later, bye!",
        "Goodbye - Flickr? I hardly know her"].shuffle[0]
    end

    def self.contacts
      contacts ||= flickr.contacts.getList.map(&:username).sort

      choose do |menu|
        menu.prompt = "Choose a contact"
        contacts.each do |contact|
          menu.choice(contact.to_sym) { FlickrCli::Menu.menu_for(contact) }
        end
      end
    end
  end

end
