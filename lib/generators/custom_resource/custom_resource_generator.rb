class CustomResourceGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration
  source_root File.expand_path('templates', __dir__)

  argument :resource_name, type: :string, default: 'Resource'

  def r_capitalize(resource_name = '')
    resource_name.mb_chars.capitalize.to_s
  end

  def r_pluralize(resource_name = '')
    resource_name.mb_chars.pluralize(:ru).to_s
  end

  def create_files
    app_path = 'app'
    models_path = "#{app_path}/models"
    controllers_path = "#{app_path}/controllers/web"
    policies_path = "#{app_path}/policies"
    views_path = app_path + "/views/web/#{plural_name.downcase}"
    spec_path = 'spec'

    template 'models/resource.rb', models_path + "/#{class_name.downcase}.rb"
    template 'models/concerns/resource_ransack.rb', models_path + "/concerns/#{class_name.downcase}_ransack.rb"
    template 'controllers/resources_controller.rb', controllers_path + "/#{plural_name.downcase}_controller.rb"
    template 'policies/resource_policy.rb', policies_path + "/#{class_name.downcase}_policy.rb"
    template 'views/_form.html.erb', "#{views_path}/_form.html.erb"
    template 'views/edit.html.erb', "#{views_path}/edit.html.erb"
    template 'views/index.html.erb', "#{views_path}/index.html.erb"
    template 'views/new.html.erb', "#{views_path}/new.html.erb"
    template 'views/show.html.erb', "#{views_path}/show.html.erb"
    template 'spec/factories/resources.rb', spec_path + "/factories/#{plural_name.downcase}.rb"
    directory 'spec/features', spec_path + "/features/#{plural_name.downcase}", recursive: true
    migration_template 'migration.rb', "db/migrate/create_#{plural_name.downcase}.rb"
  end

  # solution for `next_migration_number': NotImplementedError
  def self.next_migration_number(dirname)
    next_migration_number = current_migration_number(dirname) + 1
    ActiveRecord::Migration.next_migration_number(next_migration_number)
  end
end
