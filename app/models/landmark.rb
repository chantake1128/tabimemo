class Landmark < ApplicationRecord
  has_many :posts
  has_one_attached :image

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :city,          presence: true
  
  validate  :valid_name
  validate  :valid_street_address

  private

  def valid_name
    unless name.present? && name =~ /\A.{1,100}\z/
    errors.add(:name, "Please enter name in 100 characters or less")
    end
  end

  def valid_street_address
    unless street_address.present? && street_address =~ /\A.{1,20}\z/
    errors.add(:street_address, "Please enter street address in 20 characters or less")
    end
  end
end
