require 'net/http'
class BadAppController < ApplicationController
  BADWEBREQUEST = "/badwebrequest"

  def orm
  end

  def slowdb
    results = ActiveRecord::Base.connection.execute("call 5sec_proc()")
    ActiveRecord::Base.clear_active_connections!
    puts results

    flash[:notice] = "SQL stored procedure successfully executed!"
    Rails.logger.info("SlowDB SQL query executed succesfully")
    redirect_back(fallback_location: root_path)
  end


  def slowrequest
    if ENV['API_ENDPOINT'].present?
      response = Api.do_get_request(params)
      puts response
 
      if response.status_code == 200
        flash[:notice] = "Successful API call"
        Rails.logger.info("SlowRequest API called successfully")
      else
        flash[:alert] = "Unsuccessful API call, please try again"
        Rails.logger.error("SlowRequest API call failed")
      end
    else
      flash[:alert] = "Please make sure you have added api url"
    end
    redirect_back(fallback_location: root_path)
  end

  def swallowedexception
    if ENV['API_ENDPOINT'].present?
      params[:apicall] = BADWEBREQUEST
      response = Api.do_get_request(params)
      puts response
 
      if response.status_code == 200
        flash[:notice] = "Bad app working as intended!"
        Rails.logger.info("SwallowedException successfully")
      end
    else
      flash[:alert] = "Please make sure you have added api url"
    end
    redirect_back(fallback_location: root_path)
  rescue Exception => e
    puts "SwallowedException test"
  end

  def untracked
    results = ActiveRecord::Base.connection.execute("call bad_getsupplierid_proc()")
    ActiveRecord::Base.clear_active_connections!
    puts results

    flash[:notice] = "Untracked call successfully executed!"
    Rails.logger.info("Untracked application call executed succesfully")
    redirect_back(fallback_location: root_path)
  end
end