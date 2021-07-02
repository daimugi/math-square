class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :questions
  has_many :favorites 
  has_many :likes, through: :favorites, source: :question
  has_many :answers
  
  
  def favorite(question)
    self.favorites.find_or_create_by(question_id: question.id)
  end 
  
  def unfavorite(question)
    relationship = self.favorites.find_or_create_by(question_id: question.id)
    relationship.destroy if relationship
  end
  
  def liking?(question)
    self.likes.include?(question)
  end  
end
