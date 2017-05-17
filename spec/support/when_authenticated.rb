RSpec.shared_context 'When authenticated' do

  background do
    authenticate
  end

  def authenticate
    if page.driver.browser.respond_to?(:authorize)
      # When headless
      page.driver.browser.authorize(username, password)
    else
      # When javascript test
      visit "http://#{username}:#{password}@#{host}:#{port}/"
     end
  end

  def username
    "facturation@keycoopt.com"
  end

  def password
    "password"
  end

  def host
    Capybara.current_session.server.host
  end

  def port
    Capybara.current_session.server.port
  end
end
