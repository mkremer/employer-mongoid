require "employer-mongoid/version"
require "employer-mongoid/pipeline"
require "employer-mongoid/job"
require "employer-mongoid/employee"
require "employer/employees/abstract_employee"

Employer::Employees::AbstractEmployee.send(:include, Employer::Mongoid::Employee)
