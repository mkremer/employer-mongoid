require "mongoid"

module Employer
  module Mongoid
    class Job
      include ::Mongoid::Document
      include ::Mongoid::Timestamps
      store_in collection: "employer_jobs"

      field :state, type: Symbol
      field :type, type: String
      field :properties, type: Hash, default: {}

      validates :state, presence: true
      validates :type, presence: true

      scope :free, where(state: :free)
    end
  end
end
