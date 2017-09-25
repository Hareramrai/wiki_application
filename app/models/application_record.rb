class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  class << self
    def pagination(params)
      page(params[:page]).per(params[:size])
    end
  end
end
