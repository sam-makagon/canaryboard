class Event < ActiveRecord::Base
  attr_accessible :message, :indicator_id, :status_id

  belongs_to :indicator
  belongs_to :status

  default_scope order("created_at DESC")
end
