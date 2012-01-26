require 'csv'
require 'fileutils'
require 'erb'

assignments = CSV.read("assignments.csv")

topic = ""
title = ""
filename = ""
assignments.each_with_index do |row, i|
  topic = row[1] if row[0] == "topic"
  title = row[1] if row[0] != "topic"
  title[0] = ""
  filename = "#{row[0]}-#{title}-#{topic}.md"
  filename.gsub!(' ', '-')
  
  template = ERB.new <<-EOF
---
layout : post
category : crim
topic : <%= topic %>
read : false
briefed : false
discussed : false
---

### <%= title %>
  EOF
    
  File.open(filename, 'w') {|f| f.write(template.result)}
end
