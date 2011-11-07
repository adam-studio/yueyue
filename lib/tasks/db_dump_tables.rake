namespace :db do
  desc 'Create YAML test fixtures for references. Defaults to development database. Set RAILS_ENV to override.'   

  task :dump_tables => :environment do  
    sql = "SELECT * FROM %s"  
    #dump_tables = ["yueyue_types","yueyue_type_actions","yueyue_type_properties"] # 需要导入的表们
    dump_tables = ["cities"]
    ActiveRecord::Base.establish_connection(:development)   
    dump_tables.each do |table_name|   
      i = "000"  # 表中每条数据的编号
      file_name = "#{RAILS_ROOT}/tmp/#{table_name}.yml"  
      p "Fixture save for table #{table_name} to #{file_name}"  
      File.open(file_name, 'w') do |file|   
        data = ActiveRecord::Base.connection.select_all(sql % table_name)   
        file.write data.inject({}) { |hash, record|   
          hash["#{table_name}_#{i.succ!}"] = record   
          hash   
          }.to_yaml   
        end  
      end
  end #task

end #namespace :db do