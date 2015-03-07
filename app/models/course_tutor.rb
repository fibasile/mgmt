class CourseTutor < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates_uniqueness_of :user_id, scope: :course_id
  validates_presence_of :user, :course

  def to_s
    user.to_s
  end
end
