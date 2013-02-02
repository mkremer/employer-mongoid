require "employer-mongoid/pipeline"

describe Employer::Mongoid::Pipeline do
  let(:pipeline) { Employer::Mongoid::Pipeline.new }

  before(:each) do
    stub_const("Employer::Mongoid::Job", Class.new)
  end

  describe "#enqueue" do
    it "saves the job hash to the collection" do
      job_hash = {class: "TestJob", attributes: {shape: "Square", color: "Blue"}}
      job_attributes_hash = {type: "TestJob", properties: {shape: "Square", color: "Blue"}}
      job_document = double("Job", id: "123")
      Employer::Mongoid::Job.should_receive(:create!).with(job_attributes_hash).and_return(job_document)
      pipeline.enqueue(job_hash).should eq("123")
    end
  end

  describe "#dequeue" do
    it "locks a job from the collection and returns it as a job hash" do
      job_document = double("Job", type: "TestJob", id: "234", properties: {shape: "Triangle", color: "Green"})
      free_jobs_scope = double("Free jobs")
      sorted_scope = double("Sorted scope")
      Employer::Mongoid::Job.should_receive(:free).and_return(free_jobs_scope)
      free_jobs_scope.should_receive(:asc).with(:created_at).and_return(sorted_scope)
      sorted_scope.should_receive(:find_and_modify).with({"$set" => {state: :locked}}, new: true).and_return(job_document)
      job_hash = {id: "234", class: "TestJob", attributes: {shape: "Triangle", color: "Green"}}
      pipeline.dequeue.should eq(job_hash)
    end
  end

  describe "clear" do
    it "deletes all jobs" do
      Employer::Mongoid::Job.should_receive(:destroy_all)
      pipeline.clear
    end
  end

  describe "#complete" do
    it "deletes the job from the collection" do
      job_document = double("Job document")
      job = double("Job", id: "345")
      Employer::Mongoid::Job.should_receive(:find).with("345").and_return(job_document)
      job_document.should_receive(:destroy)
      pipeline.complete(job)
    end
  end

  describe "#reset" do
    it "unlocks the job in the collection" do
      job_document = double("Job document")
      job = double("Job", id: "456")
      Employer::Mongoid::Job.should_receive(:find).with("456").and_return(job_document)
      job_document.should_receive(:update_attributes).with({state: :free})
      pipeline.reset(job)
    end
  end

  describe "#fail" do
    it "marks the job as failed in the collection" do
      job_document = double("Job document")
      job = double("Job", id: "567")
      Employer::Mongoid::Job.should_receive(:find).with("567").and_return(job_document)
      job_document.should_receive(:update_attributes).with({state: :failed})
      pipeline.fail(job)
    end
  end
end
