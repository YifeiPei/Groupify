class Upload < ActiveRecord::Base
  attr_accessor :username, :file_id

  validates :username, presence: true
  belongs_to :user
  before_save :store_file

  def add_file(upload)
    @upload = upload
  end

  def store_file
    directory = 'uploads'
    if !Dir.exist?(directory)
      Dir.mkdir(directory)
    end
    self[:file] = @upload.original_filename
    self[:file_id] = SecureRandom.uuid
    #@upload.file_id = self[:file_id]
    path = File.join(directory, self[:file_id])

    if File.file?(path)
      raise 'A naming conflict occured. Please try again'
    else
      File.open(path, "wb") {|f| f.write(@upload.read) }
    end
  end
end
