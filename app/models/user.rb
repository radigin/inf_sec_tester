class User < ActiveRecord::Base
  validates :user_login, uniqueness: {allow_nil: false}, presence: true
  validates :email, uniqueness: {allow_nil: false}, presence: true
  validates :user_password, presence: true
  
  has_one :user_desc
  
  def is_admin?()
    self.is_admin == 1
  end

  def User.check_user(login, password)
    User.find_by(user_login: login, user_password: password).present?
  end
end
