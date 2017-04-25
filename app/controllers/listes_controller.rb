class ListesController < ApplicationController

  before_action :select_listes_dispo, only: [:index]
  before_action :select_listes_prises, only: [:index]
  before_action :select_user_liste, only: [:new]
  before_action :find_liste, only: [:show, :edit, :update, :destroy]
  before_action :find_liste_and_prop, only: [:takenby]

  def index
    @listesd = @listes_dispo
    @listesp = @listes_prises
  end

  def show
    @id = params[:id]
  end

  def new
    @liste = Liste.new
    @ma_liste = @liste_user
    @takenby = @takenby_user
  end

  def create
    @liste = Liste.new(liste_params)
    @liste.user = current_user
    @liste.takenby = 0
    if @liste.save
      redirect_to choix_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @liste.update(liste_params)
      redirect_to choix_path
    else
      render :edit
    end
  end

  def takenby
    if @liste.takenby != current_user.id
      @liste.takenby = current_user.id
      @cas = 1
    else
      @liste.takenby = 0
      @cas = 0
    end

    if @liste.save

      if @cas == 0
        # Envoi d'un mail au current_user et au propriétaire de la liste
        # pour indiquer qu'elle n'est plus prise en charge
        no_list_taken(@user, @liste, current_user)
        dont_take_list(current_user, @liste, @user)
      end

      if @cas == 1
        # Envoi d'un mail au current_user et au propriétaire de la liste
        # pour indiquer qu'elle est prise en charge
        list_taken(@user, @liste, current_user)
        take_list(current_user, @liste, @user)
      end

      redirect_to listes_path

    end

  end

  def destroy
    @liste.destroy
    redirect_to choix_path
  end

  private
  # Cette fonction permet de protéger le formulaire
  # Seules les données permises seront sauvegardées en base
  def liste_params
    params.require(:liste).permit(:nom, :content, :date_livraison)
  end

  def find_liste
    @liste = Liste.find(params[:id])
  end

  def find_liste_and_prop
    @liste = Liste.find(params[:id])

    # on récupère le propriétaire de la liste
    @user = User.find_by_sql("SELECT u.* FROM listes l, users u WHERE
      l.id = '#{@liste.id}' AND u.id = l.user_id")

  end

  def select_listes_dispo
    #@listes_dispo = Liste.where('user_id != ? AND takenby = ?', current_user.id, 0)
    # on sélectionne les listes qui n'appartiennent pas au current_user,
    # qui ne sont pas déjà prises et dont le propriétaire a le même code postal
    # que le current_user
    @listes_dispo = Liste.find_by_sql("SELECT l.* FROM listes l, users u WHERE
      l.user_id = u.id AND l.user_id <> '#{current_user.id}' AND l.takenby = 0 AND
      u.code_postal='#{current_user.code_postal}' AND l.date_livraison >= '#{Time.now}'")

  end

  def select_user_liste

    # on récupère la liste du user courant
    @liste_user = Liste.where(user_id: current_user)

    # on récupère le user qui a pris en charge la liste du user courant
    @liste_user.each do |liste|
      @takenby_user = User.find_by_sql("SELECT u.* FROM listes l, users u WHERE
      l.id = '#{liste.id}' AND u.id = l.takenby")
    end

  end

  def select_listes_prises
    @listes_prises = Liste.where(takenby: current_user)
  end

########################"
# Gestion de l'envoi des mails
# Certainement "crad" ...

  def dont_take_list(current, liste, user)
      @current = current
      @liste = liste
      @user = user

      @cemail = @current.email
      @nom = @liste.nom
      @uemail = @user[0].email

      @body = 'Bonjour ' + @cemail + ', ' + 'vous ne prenez plus en charge la liste ' + @nom + ' de ' + @uemail

      email_sendgrid(@cemail, "Bestneighbor - vous ne prenez plus en charge une liste", @body)
  end

  def no_list_taken(user, liste, current)
    @user = user
    @liste = liste
    @current = current

    @uemail = @user[0].email
    @nom = @liste.nom
    @cemail = @current.email

    @body = 'Bonjour ' + @uemail + ', ' + 'votre liste ' + @nom + " n'est plus prise en charge" + ' par ' + @cemail

    email_sendgrid(@uemail, "Bestneighbor- votre liste n'est plus prise en charge", @body)
  end

  def take_list(current, liste, user)
    @current = current
    @liste = liste
    @user = user

    @cemail = @current.email
    @nom = @liste.nom
    @uemail = @user[0].email

    @body = 'Bonjour ' + @cemail + ', ' + 'vous avez pris en charge la liste ' + @nom + ' de ' + @uemail

    email_sendgrid(@cemail, "Bestneighbor - vous prenez une liste en charge", @body)
  end

  def list_taken(user, liste, current)
    @user = user
    @liste = liste
    @current = current

    @uemail = @user[0].email
    @nom = @liste.nom
    @cemail = @current.email

    @body = 'Bonjour ' + @uemail + ', ' + 'votre liste ' + @nom + ' est prise en charge par ' + @cemail + ' !'

    email_sendgrid(@uemail, "Bestneighbor - votre liste est prise en charge", @body)
  end

  def email_sendgrid (to, subject, body)

    dest = to.to_s
    sujet = subject.to_s
    corps = body.to_s

    require 'mail'

    Mail.defaults do
    delivery_method :smtp, { :address   => "smtp.sendgrid.net",
                             :port      => 587,
                             :domain    => "bestneighbor.fr",
                             :user_name => ENV['SENDGRID_USERNAME'],
                             :password  => ENV['SENDGRID_PASSWORD'],
                             :authentication => 'plain',
                             :enable_starttls_auto => true }
    end

    mail = Mail.deliver do

      to "#{dest}"
      from 'contact@bestneighbor.fr'
      subject "#{sujet}"
      text_part do
        body "#{corps}"
      end

    end

  end

end
