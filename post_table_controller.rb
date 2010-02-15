# post_table_controller.rb
# lanyon
#
# Created by Christopher Sexton on 2/11/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

require 'yaml'


class PostTableController
  attr_writer :postTableView, :textView
  
  def add_post(sender)
    p = Post.new
    p.name = 'John'
    p.title = 'Smith'
    @posts << p
    @postTableView.reloadData
  end
  
  def awakeFromNib
    @posts = []
    Dir["/Users/csexton/src/personal/lanyon/Tests/Fixtures/_posts/*.markdown"].each do |file|
      p = Post.new
      p.load_file(file)
      @posts << p
    end
    
    @postTableView.dataSource = self
    @postTableView.delegate = self
    
    @textView.setFont NSFont.userFixedPitchFontOfSize(12)
  end
  
  def numberOfRowsInTableView(view)
    @posts.size
  end
  
  def tableView(view, objectValueForTableColumn:column, row:index)
    post = @posts[index]
    #puts "column.identifier #{column.identifier}" 
    #puts "index #{index}" 
    case column.identifier
      when 'name'
      post.name
      when 'title'
      post.title
    end
  end
  
  def tableView(view, setObjectValue:object, forTableColumn:column, row:index)
    post = @posts[index]
    case column.identifier
      when 'name'
      post.name = object
      when 'title'
      post.title = object
    end
    post.save
  end
  
  
  #works
  def tableView(view, willDisplayCell:cell, forTableColumn:col,  
                row:the_row)
    NSLog("willDisplayCell")
  end
  #works
  def tableViewSelectionDidChange(notification)
    NSLog("tableViewSelectionDidChange")
    @textView.setString @posts[@postTableView.selectedRow].body
  end
  
  
  
end