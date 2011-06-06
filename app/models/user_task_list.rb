class UserTaskList < ActiveRecord::Base
  belongs_to :uask
  belongs_to :user
end
