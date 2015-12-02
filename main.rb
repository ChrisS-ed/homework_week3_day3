require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all' if development?
require 'pg'

get '/tasks' do
  # get all tasks from DB
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :index
end

get '/tasks/new' do
  # render a form
  erb :new
end

post '/tasks' do
  # persist new task to DB
  name = params[:name]
  details = params[:details]
  sql = "INSERT INTO tasks(name, details) VALUES ('#{name}', '#{details}')"
  run_sql(sql)
  redirect to('/tasks')
end

get '/tasks/:id' do
  # grab task from DB where id = :id - homework
  sql = "SELECT * FROM tasks WHERE id = #{params[:id].to_i}"
  @task = run_sql(sql)

  erb :show
end

get '/tasks/:id/edit' do
  # grab task from DB and render form
end

post '/tasks/:id' do
  # grab params and update in DB
end

post '/tasks/:id/delete' do
  # destroy in DB 
end

def run_sql(sql)
  conn = PG.connect(dbname: 'todo', host: 'localhost')

  result = conn.exec(sql)
  conn.close
  result
end


