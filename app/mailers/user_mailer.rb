class UserMailer < ApplicationMailer

   default from: 'contact@bestneighbor.fr'

# Gestion des mails pour les listes de courses

   def dont_take_list_email(current, liste, user)

      @cemail = current.email
      @nom = liste.nom
      @uemail = user.email
      @url  = 'https://www.bestneighbor.fr'

      mail(to: @cemail, subject: "Bestneighbor - vous ne prenez plus en charge une liste")

  end

  def no_list_taken_email(user, liste, current)

    @uemail = user.email
    @nom = liste.nom
    @cemail = current.email
    @url  = 'https://www.bestneighbor.fr'

    mail(to: @uemail, subject: "Bestneighbor- votre liste n'est plus prise en charge")

  end

  def take_list_email(current, liste, user)

    @cemail = current.email
    @nom = liste.nom
    @uemail = user.email
    @url  = 'https://www.bestneighbor.fr'

    mail(to: @cemail, subject: 'Bestneighbor - vous prenez une liste en charge')

  end

  def list_taken_email(user, liste, current)

    @uemail = user.email
    @nom = liste.nom
    @cemail = current.email
    @url  = 'https://www.bestneighbor.fr'

    mail(to: @uemail, subject: 'Bestneighbor - votre liste est prise en charge')

  end

  def liste_destroyed_email(current, liste)

    @cemail = current.email
    @nom = liste.nom
    @url  = 'https://www.bestneighbor.fr'

    mail(to: @cemail, subject: "Bestneighbor - vous avez supprimé une liste")

  end

  def nomore_liste_email(user, liste, current)

    @uemail = user.email
    @nom = liste.nom
    @cemail = current.email
    @url  = 'https://www.bestneighbor.fr'

    mail(to: @uemail, subject: "Bestneighbor- une liste a été supprimée")

  end

# Gestion des mails pour le covoiturage
  def take_covoiturage_email(current, covoiturage, user, cas)

    @cemail = current.email
    @nom = covoiturage.destination
    @uemail = user.email

    if cas === 1
      @nbpass = covoiturage.nbpass1
    elsif cas === 2
      @nbpass = covoiturage.nbpass2
    elsif cas === 3
      @nbpass = covoiturage.nbpass3
    end

    @date = covoiturage.date.to_date.strftime("%d %b %Y")
    @heure = covoiturage.heure

    @url  = 'https://www.bestneighbor.fr'

    mail(to: @cemail, subject: "Bestneighbor - vous avez réservé un trajet")

  end

  def covoiturage_taken_email(user, covoiturage, current, cas)

    @uemail = user.email
    @nom = covoiturage.destination
    @cemail = current.email

    if cas === 1
      @nbpass = covoiturage.nbpass1
    elsif cas === 2
      @nbpass = covoiturage.nbpass2
    elsif cas === 3
      @nbpass = covoiturage.nbpass3
    end

    @date = covoiturage.date.to_date.strftime("%d %b %Y")
    @heure = covoiturage.heure

    @url  = 'https://www.bestneighbor.fr'

    mail(to: @uemail, subject: "Bestneighbor - votre trajet est réservé")

  end

  def dont_take_covoiturage_email(current, covoiturage, user, cas)

      @cemail = current.email
      @nom = covoiturage.destination
      @uemail = user.email

      @date = covoiturage.date.to_date.strftime("%d %b %Y")
      @heure = covoiturage.heure

      @url  = 'https://www.bestneighbor.fr'

      mail(to: @cemail, subject: "Bestneighbor - vous avez annulé la réservation d'un trajet")

  end

  def no_covoiturage_taken_email(user, covoiturage, current, cas)

    @uemail = user.email
    @nom = covoiturage.destination
    @cemail = current.email

    @date = covoiturage.date.to_date.strftime("%d %b %Y")
    @heure = covoiturage.heure

    @url  = 'https://www.bestneighbor.fr'

    mail(to: @uemail, subject: "Bestneighbor- votre trajet n'est plus réservé")

  end

  def covoiturage_destroyed_email(current, covoiturage)

      @cemail = current.email
      @nom = covoiturage.destination
      @url  = 'https://www.bestneighbor.fr'

      mail(to: @cemail, subject: "Bestneighbor - vous avez supprimé un trajet proposé")

  end

  def nomore_covoiturage_email(user, covoiturage, current)

    @uemail = user.email
    @nom = covoiturage.destination
    @cemail = current.email
    @url  = 'https://www.bestneighbor.fr'

    mail(to: @uemail, subject: "Bestneighbor- votre réservation a été supprimée")

  end

end
