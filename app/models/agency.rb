class Agency < ApplicationRecord

	validates :number, presence: true, uniqueness: true
	validates :address, presence: true, length: { minimum: 5}

	has_many :accounts, dependent: :destroy

end
