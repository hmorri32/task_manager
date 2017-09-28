require 'sqlite3'

class Task
  attr_reader :title, :description, :id
  
  def initialize(params)
    @title       = params['title']
    @description = params['description']
    @id          = params["id"] if params["id"]
    @database    = SQLite3::Database.new('db/task_manager_development.db')
    @database_results_as_hash = true
  end
  
  def save
    @database.execute("INSERT INTO tasks (title, description) VALUES (?, ?);", @title, @description)    
  end

  def self.database
    database = SQLite3::Database.new('db/task_manager_development.db')
    database.results_as_hash = true
    database
  end

  def self.all 
    tasks = database.execute("SELECT * FROM tasks")
    tasks.map {|task| Task.new(task)}
  end

  def self.find(id)
    task = database.execute('SELECT * FROM tasks WHERE id = ?', id.to_i).first
    Task.new(task)
  end

  def self.update(id, params)
    database.execute("UPDATE tasks
                      SET title = ?,
                      description = ?
                      WHERE id = ?;",
                      params[:title],
                      params[:description],
                      id)
    Task.find(id)
  end

  def self.destroy(id)
    database.execute('DELETE FROM tasks WHERE id = ?;', id)
  end
end