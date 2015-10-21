require './Todo'
require './Task'
require 'yaml/store'

t = ToDo.new('superman')
tasks = t.load_tasks
