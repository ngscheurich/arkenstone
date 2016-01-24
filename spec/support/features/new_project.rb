module Features
  APP_NAME = "arkenstone_dummy"

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

  private

  def root_path
    File.expand_path("../../../../", __FILE__)
  end

  def arkenstone_bin
    File.join(root_path, "bin", "arkenstone")
  end
end
