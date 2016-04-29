require "thor"

module Arkenstone
  class Forge < Thor
    include Thor::Actions

    PROVISIONERS = %w(ansible).freeze

    option :box,         type: :string, aliases: "-B", default: "ubuntu/trusty64",
                         desc: "Vagrant base box"

    option :port,        type: :numeric, default: "3001",
                         desc: "Port on the host to forward Rails server to"

    option :provider,    type: :string, aliases: "-P", default: "virtualbox",
                         desc: "Vagrant VM provider"

    option :provisioner, type: :string, aliases: "-p", default: "ansible",
                         desc: "Vagrant provisioner (options: #{PROVISIONERS.join('/')})"

    desc "new APP_PATH [options]", "Generate a new Rails environment at APP_PATH"
    def new(app_path)
      @app_path = app_path
      vagrant
      provisioner
    end

    private

    def vagrant
      template "Vagrantfile.erb", "#{@app_path}/Vagrantfile"
    end

    def provisioner
      case options[:provisioner]
      when "ansible"
        directory "ansible", "#{@app_path}/prov/ansible"
      end
    end
  end
end
