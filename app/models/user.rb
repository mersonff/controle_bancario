class User < ApplicationRecord

	before_save { self.email = email.downcase }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255}, 
																		format: {with: VALID_EMAIL_REGEX},
																		uniqueness: {case_sensitive: false} 

	has_secure_password
	validates :password, presence: true, length: {minimum: 5}, allow_nil: true

	has_many :transactions, dependent: :destroy

end
