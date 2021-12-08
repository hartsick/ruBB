namespace :users do  
    desc 'Create a new user for application'
    task :create, [:email] => [:environment] do |_, args|
        email = args[:email]
        if email.nil? || email.empty?
            puts "Email: " unless args[:email].present?
            email = STDIN.gets.strip
        end
        puts "Username: "
        username = STDIN.gets.strip

        puts "Password: "
        password = STDIN.gets.strip

        user = User.create(email: email, username: username, password: password)
        puts "User created with email '#{user.email}' and username '#{user.username}'"
    end
end