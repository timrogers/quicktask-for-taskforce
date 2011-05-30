require 'net/https'
require 'URI'
class HomeController < ApplicationController
  def index
    session
   puts "Username: " + session[:username]
      puts "Password:" + session[:password]
    if session[:email] == nil or session[:apikey] == nil
      flash[:notice] = "Please log in."
      redirect_to "/login"
    else
       @uri = URI.parse("https://www.taskforceapp.com/api/v1/user.json")
       @http = Net::HTTP.new(@uri.host, @uri.port)
       @http.use_ssl = true
       @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
       @request = Net::HTTP::Get.new(@uri.request_uri)
       @request.basic_auth(session[:email], session[:apikey])
       response = @http.request(@request)
       if response.code == "401"
         flash[:error] = "Your username or API key is invalid."
         redirect_to "/login"
       end    
   end
  end
  
  def add
      puts "Username: " + session[:username]
      puts "Password:" + session[:password]
       @uri = URI.parse("https://www.taskforceapp.com/api/v1/user.json")
       @http = Net::HTTP.new(@uri.host, @uri.port)
       @http.use_ssl = true
       @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
       @request = Net::HTTP::Get.new(@uri.request_uri)
       @request.basic_auth(session[:email], session[:apikey])
       response = @http.request(@request)
       puts "Cpde: " + response.code
       puts "Body: " + response.body
       if response.code == "401"
         puts "Bad response."
         flash[:error] = "Your username or API key is invalid."
         redirect_to "/lol2"
       end    
  end
  
  def login
    
  end
  
  def authenticate
    if params[:email] == nil or params[:apikey] == nil
      flash[:notice] = "Please log in."
      redirect_to "/login"
    else
       @uri = URI.parse("https://www.taskforceapp.com/api/v1/user.json")
       @http = Net::HTTP.new(@uri.host, @uri.port)
       @http.use_ssl = true
       @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
       @request = Net::HTTP::Get.new(@uri.request_uri)
       @request.basic_auth(params[:email], params[:apikey])
       @response = @http.request(@request)
       puts "Body - " + @response.body
       puts "Code - " + @response.code
       if @response.code == "401"  
         flash[:notice] = "Your username or API key is invalid."
         redirect_to "/login"
       else
         session
         session[:email] = params[:email]
         session[:apikey] = params[:apikey]
         redirect_to "/"
       end    
   end
   end
    end

