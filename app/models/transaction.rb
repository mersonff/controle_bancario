class Transaction < ApplicationRecord

	validates :value, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0 }
	validates :date, presence: true
	validates :type_of_transaction, presence: true

	belongs_to :account
	belongs_to :user

	validates :account_id, presence: true
	validates :user_id, presence: true

	enum types_of_transactions: { deposito: 0, transferencia: 1, estorno: 2, saque: 3 }
	
end