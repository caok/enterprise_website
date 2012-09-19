#encoding: utf-8
class MyController < ApplicationController
  def edit
    @my= current_user
  end

  def password
    @user = current_user
    if request.post?
      if @user.update_with_password(params[:user])
        sign_in(@user, :bypass => true)
        redirect_to root_path, :notice => "密码更新成功！"
      else
        render
      end
    end
  end

  def information
    @user = current_user
  end

  def update
    @my = current_user

    respond_to do |format|
      if @my.update_attributes(params[:user])
        flash[:notice] = '修改信息成功。'
        format.html { redirect_to :action => 'information' }
      else
        format.html { render :action =>  "edit" }
      end
    end
  end
end
