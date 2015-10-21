require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'
require_relative "./models/Task.rb"
require_relative "./models/Todo.rb"

get "/" do
  erb :index
end

get "/tasks" do
  
  @loaded_tasks = ToDo.new('Josh').load_tasks

  erb :tasks
end

get "/new_task" do
  erb :new_task
end

post "/new_task" do
  new_task = params[:content]
  todo = ToDo.new('Josh')
  todo.load_tasks
  todo.add_task(Task.new(new_task))
  todo.save

  redirect "/tasks"
end

post "/complete" do
  id = params[:complete].to_i
  todo = ToDo.new('Josh')
  todo.load_tasks
  task = todo.find_by_id(id)

  if task.complete
    task.make_incomplete!
  else
    task.complete!
  end

  todo.save
  redirect "/tasks"
end

post "/delete" do
  id = params[:id].to_i
  todo = ToDo.new('Josh')
  todo.load_tasks
  task = todo.find_by_id(id)
  todo.delete_task!(id)
  todo.save

  redirect "/tasks"
end

