class Task < ActiveRecord::Base
  has_many :user_task_lists
  has_many :comments,:foreign_key => "task_id"
  belongs_to :taskgroup
  belongs_to :user
  def to_param
    permalink
  end
end
