class Task < ApplicationRecord
 validates :name, presence: true 
 validate :validate_name_not_inclueding_column
 
 scope :recent, -> { order(created_at: :desc) }

 belongs_to :user
  def validate_name_not_inclueding_column
    errors.add(:name, "にカンマを含める事はできません") if name&.include?(',')
  end
end
