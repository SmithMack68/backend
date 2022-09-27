class ApplicationController < ActionController::API
    include ActionController::Cookies
    before_action :authorized

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    private

    def login_user
        session[:user_id] = @user_id
    end

    def logged_in?
     !!session[:user_id]
    end
    
    def current_user
     @current_user ||= User.find(session[:user_id])#find or find_by_id
    end

    def authorized
        render json: { message: 'Please login' }, status: :unauthorized unless logged_in?
    end

   
    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def render_not_found(error)
        render json: { errors: {error.model => "Not Found"}}, status: :not_found
    end


end



# JWT
    # def encode_token(payload)
    #     JWT.encode(payload, ENV['JWT_SECRET'])
    # end

    # def auth_header
    #     request.headers['Authorization']
    # end

    # def decoded_token
    #     if auth_header
    #         token = auth_header.split(' ')[1]
    #         #headers: { 'Authorization': "Bearer <token>" }
    #         begin
    #             JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: ENV['JWT_ALGORITHM'])
    #             # JWT.decode => [{ "beef" => "steak"},{ "alg" =>"HS256"}] this is what's returned as hash
    #         rescue JWT::DecodeError
    #             nil
    #         end
    #     end
    # end

    # def current_user
    #     if decoded_token
    #         #decoded_token => [{"user_id" =>2}, { "alg" => ""}]
    #         # or nil if undecodable
    #         user_id = decoded_token[0]['user_id']
    #         @user = User.find_by(id: user_id)
    #     end
    # end

    # def logged_in? 
    #     !!current_user
    # end