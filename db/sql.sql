DROP TABLE IF EXISTS meals;
DROP TABLE IF EXISTS parties;
DROP TABLE IF EXISTS orders;

CREATE TABLE meals (
  id serial primary key,
  name text not null,
  cuisine_type text not null,
  price int not null,
  allergens boolean,
  created_at timestamp not null,
  updated_at timestamp
);

CREATE TABLE parties (
  id serial primary key,
  t_number int not null,
  guests int not null,
  paid boolean not null,
  created_at timestamp not null,
  updated_at timestamp
);

CREATE TABLE orders (
  id serial primary key,
  party_id int not null,
  meal_id int not null,
  created_at timestamp
);