class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :man_tests, dependent: :destroy
  has_many :jokes, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :reminders, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :rules, dependent: :destroy
  has_many :orders
  
  acts_as_voter

  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  before_save :set_username

  private

  def ordinal(number)
    abs_number = number.to_i.abs

    if (11..13).include?(abs_number % 100)
      "th"
    else
      case abs_number % 10
        when 1; "st"
        when 2; "nd"
        when 3; "rd"
        else    "th"
      end
    end
  end

  def ordinalize(number)
    "#{number}#{ordinal(number)}"
  end

  def set_username
    @users = User.where(first_name: self.first_name)
    same_first_name_array = []
    @users.each do |u|
      same_first_name_array << u.first_name
    end

    if same_first_name_array.size == 0
      self.username = first_name
    else
      self.username = first_name + " the " + ordinalize(same_first_name_array.size)
    end
  end
end
