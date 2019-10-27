class Task < ApplicationRecord
 validates :name, presence: true 
 validate :validate_name_not_inclueding_column
 has_one_attached :image

 scope :recent, -> { order(created_at: :desc) }

 belongs_to :user

  def self.csv_attributes
    # カラムの出力
    ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr)}
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
  end

  def validate_name_not_inclueding_column
    errors.add(:name, "にカンマを含める事はできません") if name&.include?(',')
  end

  def self.ransakable_attributes(auth_object = nil)
    %w[name created_at description]
  end
  def self.ransakable_associations(auth_object = nil)
    []
  end
end
