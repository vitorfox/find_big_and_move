require 'find'
require 'filesize'
require 'fileutils'
origin    = "/source"
target    = "/target"
sizelimit = ENV["SIZE"]

Find.find(origin) do |path|
  if File.file?(path)
    if File.size(path) > Filesize.from(sizelimit).to_i
      mkdir_path  = File.dirname(path).sub(origin, target)
      move_path   = path.sub(origin, target)
      puts "Moving #{path} to #{move_path}"
      begin
        Dir.mkdir(mkdir_path)
      rescue
        puts "Can't create #{mkdir_path}"
      end
      FileUtils.mv(path, move_path)
    end
  end
end
