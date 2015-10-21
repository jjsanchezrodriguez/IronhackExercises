require 'rspec'
require 'pry'
require '../models/Todo'
require '../models/Task'

RSpec.describe "ToDo tests" do

  before :each do
    @todo = ToDo.new('Josh')
  end

  it "add_task puts a single task object into tasks attribute" do
    @todo.add_task(Task.new('haha'))
    @todo.add_task(Task.new('blabla'))
    expect(@todo.tasks.size).to eq(2)
  end

  it "delete_task! removes task by its ID" do
    @todo.add_task(Task.new('hey'))
    @todo.add_task(Task.new('hey'))
    @todo.add_task(Task.new('wut?'))
    expect(@todo.tasks.size).to eq(3)
    @todo.delete_task!(4)
    expect(@todo.tasks.size).to eq(2)
    expect(@todo.find_by_id(4)).to eq(nil)
  end

  it "find_by_id method will fetch task by its ID attribute" do
    @todo.add_task(Task.new('get me!'))
    expect(@todo.find_by_id(6).content).to eq('get me!')
    expect(@todo.find_by_id(6).id).to eq(6)
  end

  it "sort_by_created will return array by tasks sorted by time created ASC" do
    @todo.add_task(Task.new('one'))
    @todo.add_task(Task.new('2'))
    @todo.add_task(Task.new('three'))
    # manually adjust time
    @todo.tasks[1].instance_variable_set(:@created_at, Time.now - 70000)
    sorted = @todo.sort_by_created("ASC")
    expect(sorted.first.content).to eq('2')
    expect(sorted.first.id).to eq(8)
  end

  it "sort_by_created will return array by tasks sorted by time created DESC" do
    @todo.add_task(Task.new('one'))
    @todo.add_task(Task.new('2'))
    @todo.add_task(Task.new('three'))
    # manually adjust time
    @todo.tasks[0].instance_variable_set(:@created_at, Time.now - 70000)
    sorted = @todo.sort_by_created("DESC")
    expect(sorted.first.content).to eq('three')
    expect(@todo.tasks.first.id).to eq(10)
  end

  it "class accepts a user argument" do
    expect(ToDo.new('Ondrej').user).to eq('Ondrej')
  end

  it "method save will store objs to YAML, load will retrieve them" do
    user = "superman"
    yaml_todo = ToDo.new(user)
    yaml_todo.add_task(Task.new('YAML'))
    yaml_todo.add_task(Task.new('is'))
    yaml_todo.add_task(Task.new('new'))
    yaml_todo.add_task(Task.new('to me'))
    yaml_todo.save
    saved_tasks = yaml_todo.load_tasks
    expect(saved_tasks.size).to eq(4)
  end

end
