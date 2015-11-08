class ProgramStudent < ActiveRecord::Base
  belongs_to :user
  belongs_to :program
  belongs_to :lab
  
  validates_uniqueness_of :user_id, scope: :program_id

  def to_s
    user.to_s
  end
end
