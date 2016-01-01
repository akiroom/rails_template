# MongoDB
gem 'bson_ext'
gem 'mongoid', '~> 5.0', '>= 5.0.1'
after_bundle do
  generate 'mongoid:config'
end

run 'bundle install'
