# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'colorize'

# Init
nb_cities = 20
nb_doctors = 50
nb_patients = 100
nb_appointments = 200

array_specialties = [
  'Allergologie',
  'Andrologie',
  'Anesthésiologie',
  'Cardiologie',
  'Chirurgie',
  'Chirurgie cardiaque',
  'Chirurgie plastique, reconstructive et esthétique',
  'Chirurgie générale',
  'Chirurgie gynécologique',
  'Chirurgie maxillo-faciale',
  'Chirurgie oculaire',
  'Chirurgie orale',
  'Chirurgie pédiatrique',
  'Chirurgie thoracique',
  'Chirurgie vasculaire',
  'Chirurgie viscérale',
  'Neurochirurgie',
  'Dermatologie',
  'Endocrinologie',
  'Gastro-entérologie',
  'Gériatrie',
  'Gynécologie',
  'Hématologie',
  'Hépatologie',
  'Immunologie',
  'Infectiologie',
  'Médecine aiguë',
  'Médecine du travail',
  'Médecine d\'urgence',
  'Médecine générale',
  'Médecine interne',
  'Médecine nucléaire',
  'Médecine palliative',
  'Médecine physique et de réadaptation',
  'Médecine préventive',
  'Néonatologie',
  'Néphrologie',
  'Neurologie',
  'Obstétrique',
  'Odontologie',
  'Oncologie',
  'Ophtalmologie',
  'Orthopédie',
  'Otorhinolaryngologie',
  'Pédiatrie',
  'Pneumologie',
  'Podologie',
  'Psychiatrie',
  'Radiologie',
  'Radiothérapie',
  'Rhumatologie',
  'Urologie'
]

count_doctors = 0
count_specialties = 0
count_doc_specialties = 0
count_patients = 0
count_appointments = 0
count_cities = 0

# CITIES
nb_cities.times do
  city = City.create(name: Faker::Address.city)

  count_cities += 1 unless city.nil?
end

# Confirm seed it's OK
if count_cities == nb_cities
  puts '   City:             '.green + "#{count_cities}/#{nb_cities}".green + '  ont été créées !'.green
else
  puts '   City:             '.red + "#{count_cities}/#{nb_cities}".red + '  ont été créé !'.red
end

# SPECIALTIES
array_specialties.size.times do |x|
  specialty = Specialty.create(name: array_specialties[x])

  count_specialties += 1 unless specialty.nil?
end

# Confirm seed it's OK
if count_specialties == array_specialties.size
  puts '   Specialty:        '.green + "#{count_specialties}/#{array_specialties.size}".green + '  ont été créées !'.green
else
  puts '   Specialty:        '.red + "#{count_specialties}/#{array_specialties.size}".red + '  ont été créé !'.red
end

# PATIENTS
nb_patients.times do
  patient = Patient.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city_id: Faker::Number.between(from: 0, to: nb_cities)
  )

  count_patients += 1 unless patient.nil?
end

# Confirm seed it's OK
if count_patients == nb_patients
  puts '   Patient:         '.green + "#{count_patients}/#{nb_patients}".green + ' ont été créés  !'.green
else
  puts '   Patient:          '.red + "#{count_patients}/#{nb_patients}".red + '  ont été créé !'.red
end

# DOCTORS
nb_doctors.times do
  doctor = Doctor.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    zip_code: Faker::Address.zip_code,
    city_id: Faker::Number.between(from: 0, to: nb_cities)
  )

  count_doctors += 1 unless doctor.nil?
end

# Confirm seed it's OK
if count_doctors == nb_doctors
  puts '   Doctor:           '.green + "#{count_doctors}/#{nb_doctors}".green + '  ont été créés  !'.green
else
  puts '   Doctor:           '.red + "#{count_doctors}/#{nb_doctors}".red + '  ont été créé !'.red
end

# APPOINTMENTS
t1 = Time.parse('2020-07-29 00:00:00')
t2 = Time.parse('2021-07-29 23:59:59')
nb_appointments.times do
  appointment = Appointment.create(
    doctor_id: Faker::Number.between(from: 0, to: nb_doctors),
    patient_id: Faker::Number.between(from: 0, to: nb_patients),
    city_id: Faker::Number.between(from: 0, to: nb_cities),
    date: rand(t1..t2)
  )

  count_appointments += 1 unless appointment.nil?
end

# Confirm seed it's OK
if count_appointments == nb_appointments
  puts '   Appointment:     '.green + "#{count_appointments}/#{nb_appointments}".green + ' ont été créés  !'.green
else
  puts '   Appointment:      '.red + "#{count_appointments}/#{nb_appointments}".red + ' ont été créé !'.red
end

# JOIN DOCTORS_SPECIALTIES
nb_doctors.times do
  doc_spe = DoctorSpecialty.create(
    doctor_id: Faker::Number.between(from: 0, to: nb_doctors),
    specialty_id: Faker::Number.between(from: 0, to: array_specialties.size)
  )

  count_doc_specialties += 1 unless doc_spe.nil?
end

# Add 50 random specialties
50.times do
  doc_spe = DoctorSpecialty.create(
    doctor_id: Faker::Number.between(from: 0, to: nb_doctors),
    specialty_id: Faker::Number.between(from: 0, to: array_specialties.size)
  )

  count_doc_specialties += 1 unless doc_spe.nil?
end

# Confirm seed it's OK
if count_doc_specialties == (nb_doctors + 50)
  puts '   Doc_specialties: '.green + "#{count_doc_specialties}/#{nb_doctors + 50}".green + ' ont été créées !'.green
else
  puts '   Doc_specialties:  '.red + "#{count_doc_specialties}/#{nb_doctors + 50}".red + '  ont été créé !'.red
end
