class JwtAuthenticator
  def initialize(app)
    @app = app
  end

  def call(env)
    token = extract_token(env)
    if token
      decoded_token = decode_token(token)
      if decoded_token && decoded_token.key?('student_id')
        student = Student.find(decoded_token['student_id'])
        env['student'] = student if student
      end
    end
    @app.call(env)
  end

  private

  def extract_token(env)
    auth_header = env['HTTP_AUTHORIZATION']
    token = auth_header.split(' ').last if auth_header
    token
  end

  def decode_token(token)
    secret_key = Rails.application.credentials.jwt_secret_key
    begin
      JWT.decode(token, secret_key, true, algorithm: 'HS256').first
    rescue JWT::DecodeError
      nil
    end
  end
end
