# Source: https://gist.github.com/amit/45e750edde94b70431f5d42caadee423
namespace :db do

    desc "Dumps the database to backups"
    task :dump => :environment do

        dump_fmt = 'p'      # 'c' or 'p', 't', 'd'
        dump_sfx = suffix_for_format dump_fmt
        backup_dir = backup_directory true
        cmd = nil
        with_config do |app, host, db, user, passw|
            file_name = Time.now.strftime("%Y%m%d%H%M%S") + "_" + db + '.' + dump_sfx
            # puts "app = #{app}"
            # puts "host = #{host}"
            # puts "db = #{db}"
            # puts "user = #{user}"
            # puts "Password = #{passw}"
            cmd = "PGPASSWORD=#{passw}  pg_dump -F #{dump_fmt} -v -U #{user} -h #{host} -d #{db} -f #{backup_dir}/#{file_name}"
        end
        puts cmd
        exec cmd
    end

    desc "Writes forum posts to CSV"
    task :csv => :environment do
        require "csv"

        file_name = Time.now.strftime("%Y%m%d%H%M%S") + "_posts.csv"

        CSV.open(file_name, "wb") do |csv|
            headers = [:id, :author, :topic, :topic_id, :body, :created_at]
            csv << headers

            Post.includes(:author, :topic).in_batches do |batch|
                batch.each do |post|
                    csv << [
                        post.id,
                        post.author.username,
                        post.topic.title,
                        post.topic_id,
                        post.body.gsub(/[\r\n]+/, "\\n"),
                        post.created_at
                    ]
                end
            end
        end

        puts "Created CSV export at #{file_name}"
    end

    desc "Show the existing database backups"
    task :list => :environment do
        backup_dir = backup_directory
        puts "#{backup_dir}"
        exec "/bin/ls -lt #{backup_dir}"
    end

    desc "Restores the database from a backup using PATTERN"
    task :restore, [:pat] => :environment do |task,args|
        if args.pat.present?
            cmd = nil
            with_config do |app, host, db, user, passwd|
                backup_dir = backup_directory
                files = Dir.glob("#{backup_dir}/*#{args.pat}*")
                case files.size
                when 0
                  puts "No backups found for the pattern '#{args.pat}'"
                when 1
                  file = files.first
                  fmt = format_for_file file
                  if fmt.nil?
                    puts "No recognized dump file suffix: #{file}"
                  else
                    cmd = "pg_restore -F #{fmt} -v -c -C #{file}"
                  end
                else
                  puts "Too many files match the pattern '#{args.pat}':"
                  puts ' ' + files.join("\n ")
                  puts "Try a more specific pattern"
                end
            end
            unless cmd.nil?
              Rake::Task["db:drop"].invoke
              Rake::Task["db:create"].invoke
              puts cmd
              exec cmd
            end
        else
            puts 'Please pass a pattern to the task'
        end
    end

    private

    def suffix_for_format suffix
        case suffix
        when 'c' then 'dump'
        when 'p' then 'sql'
        when 't' then 'tar'
        when 'd' then 'dir'
        else nil
        end
    end

    def format_for_file file
        case file
        when /\.dump$/ then 'c'
        when /\.sql$/  then 'p'
        when /\.dir$/  then 'd'
        when /\.tar$/  then 't'
        else nil
        end
    end

    def backup_directory create=false
        backup_dir = "#{Rails.root}/db/backups"
        if create and not Dir.exists?(backup_dir)
          puts "Creating #{backup_dir} .."
          Dir.mkdir(backup_dir)
        end
        backup_dir
    end

    def with_config
        yield Rails.application.class.module_parent_name.underscore,
          ActiveRecord::Base.connection_db_config.host,
          ActiveRecord::Base.connection_db_config.database,
          ActiveRecord::Base.connection_db_config.configuration_hash[:username],
          ActiveRecord::Base.connection_db_config.configuration_hash[:password]
    end

end