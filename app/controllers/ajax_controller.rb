class AjaxController < ApplicationController
  skip_before_filter :verify_authenticity_token

  include FileHelper

  def folders
    render json: { results: Dir.glob("#{public_assets_files}/**/*.html") }
  end

  def converts
    FileUtils.mkdir_p(public_assets_files) unless directory_exists?(public_assets_files)

    assets_files.each do |file_path|
      doc = Nokogiri::HTML(open(file_path))
      doc.css("a").each do |link|
        next unless link.attributes["href"].value.start_with?("http://acme.test/")

        referall_link = add_param(link.attributes["href"].value, 'partner', 'widget.co')
        link.attributes["href"].value = referall_link
      end
      filename = File.basename(file_path)

      File.open("#{public_assets_files}/#{filename}", 'w') {|f| f.write(doc)}
    end

    head :ok
  end

  def renders
    render :file => params[:public]
  end

  private
    def add_param(url, param_name, param_value)
      uri = URI(url)
      params = URI.decode_www_form(uri.query || "") << [param_name, param_value]
      uri.query = URI.encode_www_form(params)
      uri.to_s
    end

    def assets_files
      @assets_file ||= Dir.glob("#{assets_path}/files/**/*.html")
    end

    def public_assets_files
      @public_assets_files ||= "#{public_path}/files"
    end
end
