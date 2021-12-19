class BadAppController < ApplicationController

  def orm
  end

  def slowdb
    sql = ""
    source = File.new("db/stored_procedure.sql", "r")
    while (line = source.gets)
      sql << line
    end
    source.close
    ActiveRecord::Base.connection.execute(sql)
    ActiveRecord::Base.clear_active_connections!
    puts results

    flash[:notice] = "SQL stored procedure successfully executed!"
    Rails.logger.info("SlowDB SQL query executed succesfully")
    redirect_back(fallback_location: root_path)
  end


  def slowrequest
    redirect_back(fallback_location: root_path)
  end

  def swallowedexception
    redirect_back(fallback_location: root_path)
  end
end