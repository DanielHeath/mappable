
module RPOLScraper
  def self.scrape_game_characters(map, gi)
    # respond_to should take an array! (currently if you give it an array it returns as though only the first had been passed.)
    # Groups? We don't need no stinkin groups. At least, not for a little while.
#    map.editing = true (prevents anyone but GM making changes, disables movement validation)

    character_names = []
    characters = {}

    contents = Net::HTTP.get URI.parse("http://www.rpol.net/gameinfo.cgi?action=cast&amp;gi=#{gi}")
    contents.split(/=viewdescription&amp;gi=\d+&amp;cn=([^&]+)/).each_with_index do |name, index|
      next if (index % 2 == 0)
      character_names << name        
    end
    
    character_names.each do |name|
      doc = Net::HTTP.get URI.parse(character_details_url(gi, name))
      characters[name] = extract_portrait_url(doc)
    end
    characters.map {|name, image|
      [Entity.create( :map_id => map.id,
                      :name => name.gsub('+', ' '),
                      :image_filename => image
                      )]  
    }
  end
  
  def self.get_portrait_for(gi, name)
    extract_portrait_url http_get_body(character_details_url(gi, name))
  end
  
  def self.character_details_url(gi, name)
    "http://www.rpol.net/gameinfo.cgi?action=viewdescription&gi=#{gi}&cn=#{name}"
  end
  
  def self.extract_portrait_url(page)
    begin
      /<img.*src=["']([^"]+)["'].*onerror=["']np\(this\)["']/i.match(page)[1]
    rescue
      ""
    end
  end
end

#RPOLScraper.scrape_game_characters(nil, nil, nil,nil)