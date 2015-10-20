require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'
require_relative "./models/Task.rb"
require_relative "./models/Todo.rb"

get "/" do
  erb :index
end

get "/" do
  erb :index
end

get "/tasks" do
  
  todo = ToDo.new('Josh')
  todo.add_task(Task.new('blabla'))
  todo.add_task(Task.new('hey'))
  todo.add_task(Task.new('ha'))
  todo.save
  @loaded_tasks = todo.load_tasks

  erb :tasks
end

get "/new_task" do
  erb :new_task
end

post "/new_task?content=:task_content" do
  new_task = params[:task_content]
  todo = ToDo.new('Josh')
  todo.load_tasks
  todo.add_task(Task.new(new_task))

  redirect "/tasks"
end
