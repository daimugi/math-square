class Question < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 1000 }
  
  has_many :favorites, dependent: :destroy
  has_many :likeds, through: :favorites, source: :user
  has_many :answers, dependent: :destroy

  def self.search(keyword)
    where(["content like?", "%#{keyword}%"])
  end

end
