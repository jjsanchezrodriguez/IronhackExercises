require 'rspec'
require '../models/Task'
require 'date'

RSpec.describe "Task Class tests" do

  before :each do
    @task = Task.new('test text')
  end

  it "task counter should be 2 when creating two objects" do
    second_task = Task.new('blablabla')
    expect(second_task.id).to eq(2)
  end


  it "marking task as complete should return 'true' when calling completed?" do
    expect(@task.complete).to eq(false)
    @task.complete!
    expect(@task.completed?).to eq(true)
  end

  it "when calling make_incomplete!, the method completed? should return false" do
    @task.make_incomplete!
    expect(@task.completed?).to eq(false)
  end

  it "when initizialing a task, the created_at attribute == current time" do
    expect(@task.created_at).to be_within(0.002).of(Time.now)
  end

  it "update_content! overwrites content attribute with given argument" do
    @task.update_content!("new content")
    expect(@task.content).to eq("new content")
  end

  it "update_content! sets attribute update_at to the time of change" do
    @task.update_content!("changed again")
    expect(@task.content).to eq("changed again")
    expect(@task.updated_at).to be_within(0.002).of(Time.now)
  end

end
