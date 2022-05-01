-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "station" (
    "station_name" string   NOT NULL,
    CONSTRAINT "pk_station" PRIMARY KEY (
        "station_name"
     )
);

CREATE TABLE "train" (
    "train_id" UUID   NOT NULL,
    "train_name" stirng   NOT NULL,
    CONSTRAINT "pk_train" PRIMARY KEY (
        "train_id"
     ),
    CONSTRAINT "uc_train_train_name" UNIQUE (
        "train_name"
    )
);

CREATE TABLE "van" (
    "van_id" UUID   NOT NULL,
    "seats_num" int   NOT NULL,
    "price_per_km" int   NOT NULL,
    CONSTRAINT "pk_van" PRIMARY KEY (
        "van_id"
     )
);

CREATE TABLE "train_vans" (
    "conenction_id" UUID   NOT NULL,
    "van_id" UUID   NOT NULL,
    "train_id" UUID   NOT NULL,
    "vans_num" int   NOT NULL,
    CONSTRAINT "pk_train_vans" PRIMARY KEY (
        "conenction_id"
     )
);

CREATE TABLE "station_dist" (
    "connection_id" UUID   NOT NULL,
    "lhs" string   NOT NULL,
    "rhs" string   NOT NULL,
    "distance_km" int   NOT NULL,
    CONSTRAINT "pk_station_dist" PRIMARY KEY (
        "connection_id"
     )
);

CREATE TABLE "route" (
    "route_id" UUID   NOT NULL,
    "train_id" UUID   NOT NULL,
    "from" string   NOT NULL,
    "to" string   NOT NULL,
    "travel_time_min" int   NOT NULL,
    CONSTRAINT "pk_route" PRIMARY KEY (
        "route_id"
     )
);

CREATE TABLE "routes_schedule" (
    "scheduled_id" UUID   NOT NULL,
    "route_id" UUID   NOT NULL,
    "start_time" timestamp   NOT NULL,
    "arrival_wait_time_min" int   NOT NULL,
    CONSTRAINT "pk_routes_schedule" PRIMARY KEY (
        "scheduled_id"
     )
);

CREATE TABLE "ticket" (
    "ticket_id" UUID   NOT NULL,
    "user" string   NOT NULL,
    "total_price" int   NOT NULL,
    "from" string   NOT NULL,
    "to" string   NOT NULL,
    "start_time" timestamp   NOT NULL,
    "arrival_time" timestamp   NOT NULL,
    CONSTRAINT "pk_ticket" PRIMARY KEY (
        "ticket_id"
     )
);

CREATE TABLE "ticket_routes" (
    "ticket_id" UUID   NOT NULL,
    "seat_id" UUID   NOT NULL
);

CREATE TABLE "seats" (
    "seat_id" UUID   NOT NULL,
    "scheduled_id" UUID   NOT NULL,
    "seat_num_van" string   NOT NULL,
    "ticket_id" UUID   NOT NULL,
    "price" int   NOT NULL,
    CONSTRAINT "pk_seats" PRIMARY KEY (
        "seat_id"
     )
);

ALTER TABLE "train_vans" ADD CONSTRAINT "fk_train_vans_van_id" FOREIGN KEY("van_id")
REFERENCES "van" ("van_id");

ALTER TABLE "train_vans" ADD CONSTRAINT "fk_train_vans_train_id" FOREIGN KEY("train_id")
REFERENCES "train" ("train_id");

ALTER TABLE "station_dist" ADD CONSTRAINT "fk_station_dist_lhs" FOREIGN KEY("lhs")
REFERENCES "station" ("station_name");

ALTER TABLE "station_dist" ADD CONSTRAINT "fk_station_dist_rhs" FOREIGN KEY("rhs")
REFERENCES "station" ("station_name");

ALTER TABLE "route" ADD CONSTRAINT "fk_route_train_id" FOREIGN KEY("train_id")
REFERENCES "train" ("train_id");

ALTER TABLE "route" ADD CONSTRAINT "fk_route_from" FOREIGN KEY("from")
REFERENCES "station" ("station_name");

ALTER TABLE "route" ADD CONSTRAINT "fk_route_to" FOREIGN KEY("to")
REFERENCES "station" ("station_name");

ALTER TABLE "routes_schedule" ADD CONSTRAINT "fk_routes_schedule_route_id" FOREIGN KEY("route_id")
REFERENCES "route" ("route_id");

ALTER TABLE "ticket" ADD CONSTRAINT "fk_ticket_from" FOREIGN KEY("from")
REFERENCES "station" ("station_name");

ALTER TABLE "ticket" ADD CONSTRAINT "fk_ticket_to" FOREIGN KEY("to")
REFERENCES "station" ("station_name");

ALTER TABLE "ticket_routes" ADD CONSTRAINT "fk_ticket_routes_ticket_id" FOREIGN KEY("ticket_id")
REFERENCES "ticket" ("ticket_id");

ALTER TABLE "ticket_routes" ADD CONSTRAINT "fk_ticket_routes_seat_id" FOREIGN KEY("seat_id")
REFERENCES "seats" ("seat_id");

ALTER TABLE "seats" ADD CONSTRAINT "fk_seats_scheduled_id" FOREIGN KEY("scheduled_id")
REFERENCES "routes_schedule" ("scheduled_id");

