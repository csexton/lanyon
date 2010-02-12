# post.rb
# lanyon
#
# Created by Christopher Sexton on 2/11/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.


class Post
  attr_accessor :name, :title
  
  def load_file(file_name)
    @name = File.basename(file_name).gsub(/\.markdown$/, '')
    yaml = YAML.load_file file_name
    @title = yaml["title"]
  end
  
  def save()
    puts "saving #{self.inspect}"
  end
end