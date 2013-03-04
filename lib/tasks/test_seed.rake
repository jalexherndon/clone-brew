namespace :db do
  namespace :test do
    task :prepare do
      Rake::Task["db:import:ingredients"].invoke
    end
  end
end