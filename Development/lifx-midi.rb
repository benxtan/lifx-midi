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

  t = Thread.new do
  	loop do
	    m = input.gets
	    puts m
	    client.lights.set_color(LIFX::Color.random_color)
	end
  end

  gets
  t.kill

end
