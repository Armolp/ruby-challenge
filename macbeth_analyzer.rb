#

require "net/http"

class Speaker
    attr_accessor :name, :lines

    def initialize (name = "No name provided")
        self.name = name
        self.lines = 0
    end

    def display
        puts lines.to_s + "\t" + name.to_s
    end
end

# get xml from url
def getXML(url)
    puts "Requesting from " + url.to_s
    url = URI.parse(url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http|
        http.request(req)
    }
    return res.body
end

def parse_XML(xml_string)
    speakers = Array.new
    currentSpeaker = -1
    # parse the xml
    xml_string.each_line do |line|
        # remove white space from beginning and end
        line = line.strip

        # if the line is a speaker line ...
        if line.include? "<SPEAKER>"
            # get name by using the substring of the line
            name = line[9..(line.size-11)].strip

            # if the name of the speaker is ALL we want to ignore it
            if (name == "ALL")
                currentSpeaker = -1
            else
                #find name in speakers array
                found = false
                speakers.each_with_index { |speaker, index|
                    #if it is found set the current speaker to that one
                    if speaker.name == name
                        found = true
                        currentSpeaker = index
                    end
                }

                # if the name was not found add it to the speakers Array
                # we also set the current speaker to that onw
                if !found
                    speakers.push(Speaker.new (name))
                    currentSpeaker = speakers.size - 1
                end
            end
        end

        # each time we find a Line we want to add 1 to the number of Lines
        # of that speaker
        if line.include? "<LINE>"
            if currentSpeaker != -1
                speakers[currentSpeaker].lines += 1;
            end
        end
    end

    return speakers
end

play_xml = getXML("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")

play_speakers = parse_XML(play_xml)

play_speakers.each {|speaker| speaker.display}
