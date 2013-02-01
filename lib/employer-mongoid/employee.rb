module Employer
  module Mongoid
    module Employee
      def perform_job
        super
      ensure
        ::Mongoid::IdentityMap.clear
        ::Mongoid.sessions.keys.each do |session_name|
          ::Mongoid.session(session_name).disconnect
        end
      end
    end
  end
end
