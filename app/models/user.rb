class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile
  accepts_nested_attributes_for :user_profile, reject_if: :all_blank

  #Callback
  after_create :set_statistic
  
  #Validations
    validates :name, presence: true, length:{minimum: 2}, on: :update, unless: :reset_password_token_present?
    validates :last_name, presence: true, on: :update

  #Virtual Attributes
    def full_name
      [self.name,self.last_name].join(' ')
    end
  
    private

    def set_statistic
      AdminStatistic.set_event(AdminStatistic::EVENTS[:total_users])
    end
    def reset_password_token_present?
      !!$global_params[:user][:reset_password_token]
    end 
end
