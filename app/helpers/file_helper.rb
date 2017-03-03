module FileHelper
  def directory_exists?(directory)
    File.directory?(directory)
  end

  def file_exists?(file)
    File.exist?(file)
  end

  def public_path
    @public_path ||= File.join 'public'
  end

  def assets_path
    @assets_path ||= File.join 'app', 'assets'
  end
end
