class Goal < ActiveRecord::Base
  validates :user, :description, :title, :status, :private, presence: true

  belongs_to :user 
end
