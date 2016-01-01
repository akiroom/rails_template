
includesUserLogin = yes?("Include user login?")

# MongoDB
gem 'bson_ext'
gem 'mongoid', '~> 5.0', '>= 5.0.1'
after_bundle do
  generate 'mongoid:config'
end

# devise

if includesUserLogin
  gem 'devise'
  after_bundle do
    generate 'devise:install'
    environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
    generate 'devise User'
    generate 'devise:views'
  end
end

# Slim
# deviseはerbを生成するのでdeviseの後にafter_bundleを実行する
gem 'slim-rails'
gem_group :development do
  gem 'html2slim'
end
after_bundle do
  #environment 'config.generators.template_engine = :slim'
  run 'for file in app/views/**/*.erb; do erb2slim $file ${file%erb}slim && rm $file; done'
  run 'for file in app/views/devise/**/*.erb; do erb2slim $file ${file%erb}slim && rm $file; done'
end

run 'bundle install'

# HomeView
after_bundle do
  generate 'controller Home index'
  route "root to: 'home#index'"
end

# Edit some files
after_bundle do
  if includesUserLogin
    inside 'app/views/layouts/' do
      old_text = '  body\\n'
      new_text = 'body\\n    p.notice= notice\\n    p.alert= alert\\n'
      run "ruby -i -pe '$_.gsub!(\"#{old_text}\", \"#{new_text}\")' ./application.html.slim"
    end
  end
end

# git
after_bundle do
  git :init
end
