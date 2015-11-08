class LabProgram < ActiveRecord::Base
  belongs_to :program
  belongs_to :lab
end
