class User < ApplicationRecord
  has_many :experiences
  has_many :dones, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:github]

  lw_cities = [
    "bordeaux", "lille", "lyon", "marseille", "nantes", "paris", "rennes",
    "amsterdam", "barcelona", "berlin", "brussels", "copenhagen", "lausanne",
    "lisbon", "london", "madrid", "milan", "oslo", "rome", "bali", "chengdu",
    "kyoto", "melbourne", "shanghai", "shenzhen", "singapore", "tokyo",
    "belo horizonte", "buenos aires", "mexico", "montreal", "rio de janeiro",
    "são paulo", "casablanca", "tel aviv"
  ]
  before_validation :batch_location_to_lowercase, on: :update

  validates :batch_number, presence: true, numericality: { only_integer: true }, on: :update
  validates :batch_location, presence: true, inclusion: lw_cities, on: :update
  validates :country, presence: true, on: :update
  validates :visited_bali, inclusion: [ true, false ], on: :update
  validate :has_avatar, on: :create

  def country_name
    c = ISO3166::Country[self.country]
    return c.translations[I18n.locale.to_s] || c.name
  end

  def has_avatar
    identicons = ["https://avatars0.githubusercontent.com/u/11577265?s=460&v=4", "https://avatars2.githubusercontent.com/u/12451650?s=460&v=4", "https://avatars1.githubusercontent.com/u/26235955?s=460&v=4", "https://topcoder-prod-media.s3.amazonaws.com/member/profile/Dhirendra24-1521096232990.png"]
    if self.github_picture_url.nil?
      self.github_picture_url = identicons.sample
    end
  end

  def has_done?(experience)
    Done.where(experience_id: experience.id, user_id: self.id).first
  end

  def has_favorite?(experience)
    Favorite.where(experience_id: experience.id, user_id: self.id).first
  end

  def has_voted?(experience)
    Vote.where(experience_id: experience.id, user_id: self.id).first
  end

  def has_upvoted?(experience)
    if has_voted?(experience)
      Vote.where(experience_id: experience.id, user_id: self.id).first.value == 1
    end
  end


  def has_downvoted?(experience)
    if has_voted?(experience)
      Vote.where(experience_id: experience.id, user_id: self.id).first.value == -1
    end
  end

  def batch_location_to_lowercase
    self.batch_location = self.batch_location.downcase unless self.batch_location.nil?
  end

  def self.find_for_github_oauth(auth)
    user_params = auth.slice("provider", "uid")
    user_params.merge! auth.info.slice("email", "first_name")
    user_params[:github_username] = auth.info.nickname
    user_params[:github_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params = user_params.to_h

    repositories_json = open(auth.extra.raw_info.repos_url,
      "Accept" => "application/vnd.github.v3+json",
      "Authorization" => "token #{auth.credentials.token}"
    ).read
    repositories = JSON.parse(repositories_json)

    # Identify all the repositories' names of the user
    user_repos = repositories.map {|repo| repo["name"]}

    # Array containing all the repositories of a LW students
    lw_repos = [
      "fullstack-challenges", "rails-stupid-coaching", "dotfiles",
      "rails-longest-word-game", "rails-mister-cocktail", "rails-task-manager",
      "rails-yelp-mvp", "rails-wikinimous"
    ]

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    elsif (lw_repos & user_repos).length > 1 # Check if the user has at least one LW student repo
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    else
      return false
    end

    return user
  end

end
