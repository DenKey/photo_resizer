class StatusController < ActionController::API
  # This action provide info about ability of our server
  def static
    render json: 'ok'
  end

  # This action checks whether a server in the production server
  # has its environment set to production. If so, it will send
  # a status 200. Otherwise, send a status 500.
  def production
    if Rails.env.production?
      head :ok
    else
      head :internal_server_error
    end
  end

  # This action checks whether a server in the staging server
  # has its environment set to staging. If so, it will send
  # a status 200. Otherwise, send a status 500.
  def staging
    if Rails.env.staging?
      head :ok
    else
      head :internal_server_error
    end
  end

  # This action checks whether a server in the development mode
  # has its environment set to staging. If so, it will send
  # a status 200. Otherwise, send a status 500.
  def development
    if Rails.env.development?
      head :ok
    else
      head :internal_server_error
    end
  end
end
