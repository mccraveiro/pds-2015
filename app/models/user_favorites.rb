class UserFavorites < ActiveRecord::Base
  belongs_to :domain
  belongs_to :subdomain
  belongs_to :nature

  def url
    favorite_url = "/?city=" + Rack::Utils.escape(city)
    favorite_url = favorite_url + "&year=" + Rack::Utils.escape(year)
    favorite_url = favorite_url + "&month=" + Rack::Utils.escape(month)

    if domain.present?
      favorite_url = favorite_url + "&domain=" + Rack::Utils.escape(domain.value)
    end

    if subdomain.present?
      favorite_url = favorite_url + "&subdomain=" + Rack::Utils.escape(subdomain.value)
    end

    if nature.present?
      favorite_url = favorite_url + "&nature=" + Rack::Utils.escape(nature.value)
    end

    favorite_url
  end
end
