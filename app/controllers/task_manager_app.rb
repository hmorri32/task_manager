class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get '/' do 
    'SUH DUDES'
  end 
end 