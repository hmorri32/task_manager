require 'sqlite3'

class Task
  attr_reader :title, :description
  
  def initialize(params)
    @title       = params['title']
    @description = params['description']
    @database    = SQLite3::Database.new('db/task_manager_development.db')
    @database_results_as_hash = true
  end
  
  def save
    @database.execute("INSERT INTO tasks (title, description) VALUES (?, ?);", @title, @description)    
  end

  def self.all 
    database = SQLite3::Database.new('db/task_manager_development.db')
    database.results_as_hash = true
    tasks = database.execute("SELECT * FROM tasks")
    
    tasks.map {|task| Task.new(task)}
  end

  def self.find(id)
    database = SQLite3::Database.new('db/task_manager_development.db')
    database.results_as_hash = true
    task = database.execute('SELECT * FROM tasks WHERE id = ?', id.to_i).first
    Task.new(task)
  end
end