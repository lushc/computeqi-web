class ValidationProject
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_one :validation, as: :validatable, dependent: :destroy

  field :name, type: String

  def allow_validation?
    true
  end

  def complete?
    !self.validation.nil? and self.validation.success?
  end

  def busy?
    # horrible
    (!self.validation.nil? and (self.validation.in_progress? or self.validation.queued?))
  end

  def error?
    # also horrible
    (!self.validation.nil? and self.validation.error?) 
  end
end