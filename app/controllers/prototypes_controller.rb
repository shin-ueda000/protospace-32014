class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)    
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(prototype.id), method: :get  
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id)
  end
end


#beforeアクションのmove_to_indexでindexを記述していない時、つまりindexのアクションが起こった時はmove_to_indexが起きる
# アプリ立ち上げる
# indexページにアクセスする
# move_to_indexが起きる
# redirect_to action: :indexでindexページにアクセスする
# move_to_indexが起きる
# redirect_to action: :indexでindexページにアクセスする
# move_to_indexが起きる
# redirect_to action: :indexでindexページにアクセスする



# ◎やりたい事
# ログインしている人が他の人の編集を出来ないようにする
# →投稿編集ページにアクセスした際に、その投稿のuser_idとログインしているユーザーidが一致していなければ、トップページに飛ばす。
# これをメソッドとして作る。（条件：unlessを使う）
# →unless current_user.id == @tweet.user_id
# redirect_to action: :index