module Features
  APP_NAME = "arkenstone_test"

  def app_name
    APP_NAME
  end
  
  def run_arkenstone(args = nil)
    Dir.chdir(Dir.tmpdir) do
      `#{arkenstone_bin} #{args} #{project_path}`
    end
  end

  def remove_dummy_app
    FileUtils.rm_rf(project_path)
  end

  def project_path
    File.join(Dir.tmpdir, APP_NAME)
  end

  def models_path
    "#{project_path}/app/models"
  end

  def controllers_path
    "#{project_path}/app/controllers"
  end

  def config_path
    "#{project_path}/config"
  end

  def lib_path
    "#{project_path}/lib"
  end

  def file_contents(file)
    File.open(file, &:read)
  end

  def project_file_exist?(file)
    Dir.chdir(project_path) do
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
