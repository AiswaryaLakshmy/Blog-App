class Article < ActiveRecord::Base
	belongs_to :user
	enum status: [ :active, :pending, :approved, :rejected ]
end
