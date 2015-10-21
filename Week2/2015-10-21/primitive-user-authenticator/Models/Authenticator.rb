class Authenticator

LOGINS = {
  "Ondrej" => '1234',
  "Superman" => '0000'
}

    def initialize(user, password)
      @user = user
      @password = password
    end

    def valid? 
      digest
    end

    private
    def digest
      success = false
      LOGINS.each { |u,p| u == @user && p == @password ? success = true : false }
      success
    end
end
