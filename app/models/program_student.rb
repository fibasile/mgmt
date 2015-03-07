class ProgramStudent < ActiveRecord::Base
  belongs_to :user
  belongs_to :program

  def to_s
    user.to_s
  end
end
