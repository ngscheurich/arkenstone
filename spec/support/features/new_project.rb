module Features
  APP_NAME = "arkenstone_test".freeze

  def run_arkenstone(options = nil)
    Dir.chdir(Dir.tmpdir) do
      `#{arkenstone_bin} new #{APP_NAME} #{options}`
    end
  end

  def remove_dummy_app
    FileUtils.rm_rf(app_path)
  end

  def app_path
    File.join(Dir.tmpdir, APP_NAME)
  end

  def lib_path
    "#{app_path}/lib"
  end

  def file_contents(file)
    File.open(file, &:read)
  end

  def project_file_exist?(file)
    Dir.chdir(add_path) do
      File.exist?(file)
    end
  end

  private

  def root_path
    File.expand_path("../../../../", __FILE__)
  end

  def arkenstone_bin
    File.join(root_path, "bin", "arkenstone")
  end
end
