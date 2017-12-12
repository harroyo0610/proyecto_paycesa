# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171212063010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clientes", force: :cascade do |t|
    t.string   "nombre"
    t.string   "telefono"
    t.string   "email"
    t.string   "direccion"
    t.string   "direccion_entrega"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "cotizacions", force: :cascade do |t|
    t.string   "tc"
    t.string   "cliente"
    t.string   "bodega"
    t.string   "pago"
    t.integer  "cantidad"
    t.integer  "descuento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "embarques", force: :cascade do |t|
    t.string   "numero_guia"
    t.string   "transportista"
    t.datetime "fecha_salida"
    t.string   "numero_orden"
    t.string   "destino"
    t.string   "cliente"
    t.string   "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "inventarios", force: :cascade do |t|
    t.string   "upc"
    t.string   "tipo"
    t.string   "bodega"
    t.string   "modelo"
    t.string   "descripcion"
    t.float    "compra"
    t.float    "venta"
    t.integer  "cantidad"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "productos", force: :cascade do |t|
    t.string   "tc"
    t.string   "upc"
    t.string   "nombre"
    t.integer  "cantidad"
    t.float    "precio"
    t.string   "bodega"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  create_table "venta", force: :cascade do |t|
    t.string   "tc"
    t.string   "cliente"
    t.string   "bodega"
    t.string   "pago"
    t.integer  "cantidad"
    t.float    "descuento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
