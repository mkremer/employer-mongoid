module Employer
  module Mongoid
    class Pipeline
      def enqueue(job_hash)
        job_attributes = {
          type: job_hash[:class],
          properties: job_hash[:attributes]
        }

        Employer::Mongoid::Job.create!(job_attributes).id
      end

      def dequeue
        job = Employer::Mongoid::Job.
          free.
          asc(:created_at).
          find_and_modify({"$set" => {state: :locked}}, new: true)

        {
          id: job.id,
          class: job.type,
          attributes: job.properties,
        }
      end

      def complete(job)
        Employer::Mongoid::Job.find(job.id).destroy
      end

      def reset(job)
        Employer::Mongoid::Job.find(job.id).update_attributes(state: :free)
      end

      def fail(job)
        Employer::Mongoid::Job.find(job.id).update_attributes(state: :failed)
      end
    end
  end
end
