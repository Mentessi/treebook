class Status < ActiveRecord::Base
  attr_accessible :content, :user_id, :name
  belongs_to :user
end
