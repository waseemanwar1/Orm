class BadAppController < ApplicationController

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
    redirect_back(fallback_location: root_path)
  end

  def swallowedexception
    redirect_back(fallback_location: root_path)
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