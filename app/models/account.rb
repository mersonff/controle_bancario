class Account < ApplicationRecord

	validates :account_number, presence: true, uniqueness: true
	validates :limit, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 200 }
	validates :balance, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 200 }

	belongs_to :agency
	validates :agency_id, presence: true
end