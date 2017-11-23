class Covoiturage < ApplicationRecord

  belongs_to :user

  validates :destination, presence: {message: "Destination à renseigner"}, length: { maximum: 40, too_long: "Maximum 40 caractères" }
  validates :date, presence: {message: "Date à préciser"}
  validates :heure, presence: {message: "Heure à préciser"}, format: { with: /\A([01]?[0-9]|2[0-3]):[0-5][0-9]\z/, message: "Heure à saisir au format HH:MM" }
  #validates :heure, presence: {message: "Heure à préciser"}
  validates :nbplaces, presence: {message: "Nombre de places proposées à renseigner : 1, 2 ou 3"}, inclusion: {in: [1, 2, 3], message: "Nombre de places proposées à renseigner : 1, 2 ou 3"}
  validates :depart, presence: {message: "Lieu de départ à renseigner"}, length: { maximum: 40, too_long: "Maximum 40 caractères" }
  #validates :nbpass1, presence: {message: "Nombre de places à réserver à renseigner : 1, 2 ou 3"}, inclusion: {in: [1, 2, 3]}
  #validates :nbpass2, presence: {message: "Nombre de places à réserver à renseigner : 1, 2 ou 3"}, inclusion: {in: [1, 2, 3]}
  #validates :nbpass3, presence: {message: "Nombre de places à réserver à renseigner : 1, 2 ou 3"}, inclusion: {in: [1, 2, 3]}

  paginates_per 5

  #@trajets_pris = Trajet.where(takenby: current_user).order(:date)
  scope :taken_by, -> (utilisateur) { where("(takenby1 = ? or takenby2 = ? or takenby3 = ?) and date >= ?", utilisateur, utilisateur, utilisateur, Time.now.to_date.strftime("%Y%m%d").to_s).order(date: :asc) }
  #@trajets_dispo = Trajet.find_by_sql("SELECT t.* FROM trajets t, users u WHERE
  #    t.user_id = u.id AND t.user_id <> '#{current_user.id}' AND t.takenby = 0 AND
  #    u.code_postal='#{current_user.code_postal}' AND t.date >= '#{@jour}'
  #    order by t.date")
  scope :not_taken, -> (utilisateur, code_postal) { joins(:user).where("user_id != ? AND takenby1 != ? AND takenby2 != ? AND takenby3 != ? and nbdispos > ? AND date >= ? AND users.code_postal = ?", utilisateur, utilisateur, utilisateur, utilisateur, 0, Time.now.to_date.strftime("%Y%m%d").to_s, code_postal).order(date: :asc) }
  scope :my_covoits, -> (utilisateur) { where("user_id = ? and date >= ?", utilisateur, Time.now.to_date.strftime("%Y%m%d").to_s).order(date: :asc) }

end
