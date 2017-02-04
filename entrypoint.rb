require 'filesize'
require 'fileutils'
require 'colorize'
origin    = "/source"
target    = "/target"
sizelimit = ENV["SIZE"]
check_only = ENV["CHECK"] || false

Dir.glob("#{origin}/**/*")
.select{|f| File.file?(f)}
.select{|f|
  file_size = File.size(f)
  selected = file_size > Filesize.from(sizelimit).to_i
  if (check_only)
    if (selected)
      puts "Checked #{f} - size: #{file_size}".red
    else
      puts "Checked #{f} - size: #{file_size}".green
    end
    next
  end
  selected
}
.each{|path|
  if File.size(path) > Filesize.from(sizelimit).to_i
    mkdir_path  = File.dirname(path).sub(origin, target)
    move_path   = path.sub(origin, target)
    puts "Moving #{path} to #{move_path}"
    begin
      FileUtils.mkdir_p mkdir_path
      FileUtils.mv(path, move_path)
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
}
