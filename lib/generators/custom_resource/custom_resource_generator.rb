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

  def module?
    class_name.demodulize != class_name
  end

  def _class_name_dd
    class_name.demodulize.underscore
  end

  def _class_name_ug
    class_name.underscore.tr('/', '_')
  end

  def create_files
    module_name = module? ? "/#{class_name.deconstantize.underscore}" : ''

    app_path = 'app'
    models_path = "#{app_path}/models#{module_name}"
    controllers_path = "#{app_path}/controllers/web#{module_name}"
    policies_path = "#{app_path}/policies#{module_name}"
    views_path = app_path + "/views/web/#{module_name}"
    spec_path = 'spec'
    factories_path = "#{spec_path}/factories#{module_name}"
    features_path = "#{spec_path}/features#{module_name}"

    template 'models/resource.rb', models_path + "/#{_class_name_dd}.rb"
    template 'models/resource_namespace.rb', "#{app_path}/models/#{class_name.deconstantize.underscore}.rb" if module?
    template 'models/concerns/resource_ransack.rb',
             "#{app_path}/models/concerns#{module_name}/#{_class_name_dd}_ransack.rb"
    template 'controllers/resources_controller.rb', controllers_path + "/#{plural_name}_controller.rb"
    template 'policies/resource_policy.rb', policies_path + "/#{_class_name_dd}_policy.rb"
    template 'views/_form.html.erb', "#{views_path}/#{plural_name}/_form.html.erb"
    template 'views/edit.html.erb', "#{views_path}/#{plural_name}/edit.html.erb"
    template 'views/index.html.erb', "#{views_path}/#{plural_name}/index.html.erb"
    template 'views/new.html.erb', "#{views_path}/#{plural_name}/new.html.erb"
    template 'views/show.html.erb', "#{views_path}/#{plural_name}/show.html.erb"
    template 'spec/factories/resources.rb', factories_path + "/#{plural_name}.rb"
    directory 'spec/features', features_path + "/#{plural_name}", recursive: true
    migration_template 'migration.rb', "db/migrate/create_#{plural_name}.rb"
  end

  # solution for `next_migration_number': NotImplementedError
  def self.next_migration_number(dirname)
    next_migration_number = current_migration_number(dirname) + 1
    ActiveRecord::Migration.next_migration_number(next_migration_number)
  end
end
