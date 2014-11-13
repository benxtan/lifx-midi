# lifx-midi

require 'bundler'
require 'unimidi'
require 'lifx'

Bundler.require

# Create client
client = LIFX::Client.lan

# Wait until at least one light has been found
client.discover!
puts "Lights found: #{client.lights.count}"

# Listen for MIDI
UniMIDI::Input.gets do |input| # using their selection...

  puts "Send some MIDI to your input now..."
  puts "Press Enter to quit"

  flip = 0
  t = Thread.new do
  	loop do
	    m = input.gets
	    puts m

	    received = input.gets.map { |m| m[:data] }.flatten
	    puts received
	    
	    #if received == 128
	    	#client.lights.set_color(LIFX::Color.random_color())
	    #end
	    
	    if flip == 0
		    client.lights.set_color(LIFX::Color.rgb(255, 64, 64))
		    flip = 1
	    else
		    client.lights.set_color(LIFX::Color.rgb(64, 64, 255))
		    flip = 0
	    end
	end
  end

  gets
  t.kill

end
