
module Repo
  def self.create(source_dir)
    puts "[INFO] Create repo #{source_dir}"
    files = Dir.glob('**/info.yaml')
    puts files
  end
end
