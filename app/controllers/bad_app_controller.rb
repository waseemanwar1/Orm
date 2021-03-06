require 'net/http'
class BadAppController < ApplicationController
  BADWEBREQUEST = "/badwebrequest"

  def orm
    get_rows = 'SELECT id, first_name, last_name, city, country_region, mobile_phone FROM customers;'
    rows = ActiveRecord::Base.connection.execute(get_rows).to_a
    puts rows
    rows.each do |row|
      sql = "SELECT id, order_date, employee_id, customer_id, shipping_fee, taxes, payment_type FROM orders WHERE customer_id = #{row["id"]} LIMIT 1;"
      results = ActiveRecord::Base.connection.execute(sql).to_a
      puts results
    end
    flash[:notice] = "SQL stored procedure successfully executed!"
    Rails.logger.info("ORM SQL query executed succesfully")
    ActiveRecord::Base.clear_active_connections!
  rescue Exception => e
    puts e
    Rails.logger.warn("ORM SQL query failed")
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