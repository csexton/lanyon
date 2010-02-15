# post.rb
# lanyon
#
# Created by Christopher Sexton on 2/11/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

class Post
  attr_accessor :name, :title, :file_name, :data, :content

  def load_file(file_name)
    @file_name = file_name
    @name = File.basename(file_name).gsub(/\.markdown$/, '')
    #yaml = YAML.load_file file_name
    self.read_yaml(file_name)
    @title = @data["title"]
  end

  def save()
    puts "saving #{self.inspect}"
  end

  def body()
    @body = File.open(@file_name, 'r').read
    @body
  end

  def read_yaml(file_name)
    @content = File.read(file_name)

    if @content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
      @content = self.content[($1.size + $2.size)..-1]

      @data = YAML.load($1)
    end

    @data ||= {}
  end

end
