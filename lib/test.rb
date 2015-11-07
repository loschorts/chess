Dir[Dir.pwd + "/*"].each {|file| require file }

p game = Game.new(false)
