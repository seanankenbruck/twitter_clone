class Tweet < ActiveRecord::Base
	validates :message, presence: true
	validates :message, length: {maximum: 140, too_long: "A tweet is only 140 characters."}
	
	belongs_to :user
end
